import { useEffect, useMemo, useRef, useState } from "react";
import Icon from "../../components/Icon";
import AppModal from "../../components/common/AppModal";
import { useAuthStore } from "../../stores/auth";

const STORAGE_KEY = "crm-attendance-records";
const SHIFT_START = "09:00";
const SHIFT_LATE_AFTER = "09:30";
const SHIFT_END = "18:00";

const statusStyles = {
  Present: "border-emerald-100 bg-emerald-50 text-emerald-700",
  Active: "border-blue-100 bg-blue-50 text-blue-700",
  Late: "border-amber-100 bg-amber-50 text-amber-700",
  Absent: "border-rose-100 bg-rose-50 text-rose-700",
};

const emptyForm = {
  name: "",
  role: "",
  date: todayKey(),
  checkIn: "",
  checkOut: "",
  location: "Office",
};

function todayKey() {
  const date = new Date();
  return toDateKey(date);
}

function toDateKey(date) {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
}

function currentTimeValue() {
  const now = new Date();
  return `${String(now.getHours()).padStart(2, "0")}:${String(
    now.getMinutes(),
  ).padStart(2, "0")}`;
}

function formatDate(dateKey) {
  if (!dateKey) return "--";
  return new Date(`${dateKey}T00:00:00`).toLocaleDateString("en-IN", {
    day: "2-digit",
    month: "short",
    year: "numeric",
  });
}

function formatTime(time) {
  if (!time) return "--";
  const [hours, minutes] = time.split(":").map(Number);
  return new Date(2000, 0, 1, hours, minutes).toLocaleTimeString("en-IN", {
    hour: "2-digit",
    minute: "2-digit",
  });
}

function minutesFromTime(time) {
  if (!time) return null;
  const [hours, minutes] = time.split(":").map(Number);
  return hours * 60 + minutes;
}

function formatDuration(minutes) {
  if (!minutes || minutes <= 0) return "0h";
  const hours = Math.floor(minutes / 60);
  const mins = minutes % 60;
  return mins ? `${hours}h ${mins}m` : `${hours}h`;
}

function getWorkedMinutes(record, nowTick) {
  const start = minutesFromTime(record.checkIn);
  if (start == null) return 0;
  const end =
    minutesFromTime(record.checkOut) ??
    (record.date === todayKey()
      ? nowTick.getHours() * 60 + nowTick.getMinutes()
      : start);
  return Math.max(0, end - start);
}

function getRecordStatus(record) {
  if (!record.checkIn) return "Absent";
  if (!record.checkOut) return "Active";
  if (minutesFromTime(record.checkIn) > minutesFromTime(SHIFT_LATE_AFTER)) {
    return "Late";
  }
  return "Present";
}

function getInitials(name) {
  return String(name || "User")
    .split(" ")
    .filter(Boolean)
    .slice(0, 2)
    .map((part) => part[0]?.toUpperCase())
    .join("");
}

function seedRecords(user) {
  const today = todayKey();
  const yesterday = toDateKey(new Date(Date.now() - 24 * 60 * 60 * 1000));
  const twoDaysAgo = toDateKey(new Date(Date.now() - 2 * 24 * 60 * 60 * 1000));
  const currentName = user?.username || user?.userEmail || "Current User";
  const currentRole = user?.role || "Team Member";

  return [
    {
      id: crypto.randomUUID(),
      name: currentName,
      role: currentRole,
      date: today,
      checkIn: "",
      checkOut: "",
      location: "Office",
    },
    {
      id: crypto.randomUUID(),
      name: "Aarav Mehta",
      role: "Sales Manager",
      date: today,
      checkIn: "09:12",
      checkOut: "18:18",
      location: "Office",
    },
    {
      id: crypto.randomUUID(),
      name: "Nisha Rao",
      role: "Account Manager",
      date: today,
      checkIn: "09:48",
      checkOut: "17:55",
      location: "Office",
    },
    {
      id: crypto.randomUUID(),
      name: "Karan Shah",
      role: "Sales Executive",
      date: today,
      checkIn: "10:05",
      checkOut: "",
      location: "Field Visit",
    },
    {
      id: crypto.randomUUID(),
      name: "Rohit Verma",
      role: "Support Executive",
      date: yesterday,
      checkIn: "08:58",
      checkOut: "18:02",
      location: "Remote",
    },
    {
      id: crypto.randomUUID(),
      name: "Priya Nair",
      role: "Lead Qualifier",
      date: twoDaysAgo,
      checkIn: "",
      checkOut: "",
      location: "Office",
    },
  ];
}

function getSavedRecords(user) {
  try {
    const saved = JSON.parse(localStorage.getItem(STORAGE_KEY) || "[]");
    return Array.isArray(saved) && saved.length ? saved : seedRecords(user);
  } catch {
    return seedRecords(user);
  }
}

function parseCsv(text) {
  const rows = [];
  let row = [];
  let value = "";
  let inQuotes = false;

  for (let index = 0; index < text.length; index += 1) {
    const char = text[index];
    const next = text[index + 1];

    if (char === '"' && inQuotes && next === '"') {
      value += '"';
      index += 1;
    } else if (char === '"') {
      inQuotes = !inQuotes;
    } else if (char === "," && !inQuotes) {
      row.push(value.trim());
      value = "";
    } else if ((char === "\n" || char === "\r") && !inQuotes) {
      if (char === "\r" && next === "\n") index += 1;
      row.push(value.trim());
      if (row.some(Boolean)) rows.push(row);
      row = [];
      value = "";
    } else {
      value += char;
    }
  }

  row.push(value.trim());
  if (row.some(Boolean)) rows.push(row);
  return rows;
}

function normalizeHeader(header) {
  return String(header || "")
    .toLowerCase()
    .replace(/[^a-z0-9]/g, "");
}

function getImportValue(row, headerMap, names) {
  for (const name of names) {
    const index = headerMap[normalizeHeader(name)];
    if (index !== undefined) return row[index] || "";
  }
  return "";
}

function normalizeImportDate(value) {
  const raw = String(value || "").trim();
  if (!raw) return "";
  if (/^\d{4}-\d{2}-\d{2}$/.test(raw)) return raw;

  const slashMatch = raw.match(/^(\d{1,2})[/-](\d{1,2})[/-](\d{2,4})$/);
  if (slashMatch) {
    const [, day, month, year] = slashMatch;
    const fullYear = year.length === 2 ? `20${year}` : year;
    return `${fullYear}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
  }

  const parsed = new Date(raw);
  if (!Number.isNaN(parsed.getTime())) return toDateKey(parsed);
  return "";
}

function normalizeImportTime(value) {
  const raw = String(value || "").trim();
  if (!raw || raw === "--") return "";

  const twentyFourHour = raw.match(/^(\d{1,2}):(\d{2})$/);
  if (twentyFourHour) {
    const hours = Math.min(Number(twentyFourHour[1]), 23);
    const minutes = Math.min(Number(twentyFourHour[2]), 59);
    return `${String(hours).padStart(2, "0")}:${String(minutes).padStart(2, "0")}`;
  }

  const twelveHour = raw.match(/^(\d{1,2})(?::(\d{2}))?\s*(AM|PM)$/i);
  if (twelveHour) {
    let hours = Number(twelveHour[1]);
    const minutes = Number(twelveHour[2] || 0);
    const meridiem = twelveHour[3].toUpperCase();
    if (meridiem === "PM" && hours < 12) hours += 12;
    if (meridiem === "AM" && hours === 12) hours = 0;
    return `${String(Math.min(hours, 23)).padStart(2, "0")}:${String(
      Math.min(minutes, 59),
    ).padStart(2, "0")}`;
  }

  const parsed = new Date(`2000-01-01 ${raw}`);
  if (!Number.isNaN(parsed.getTime())) {
    return `${String(parsed.getHours()).padStart(2, "0")}:${String(
      parsed.getMinutes(),
    ).padStart(2, "0")}`;
  }
  return "";
}

function buildImportedRecords(csvText) {
  const rows = parseCsv(csvText);
  if (rows.length < 2) return { records: [], skipped: rows.length };

  const headers = rows[0];
  const headerMap = headers.reduce((map, header, index) => {
    map[normalizeHeader(header)] = index;
    return map;
  }, {});

  const imported = [];
  let skipped = 0;

  rows.slice(1).forEach((row) => {
    const name = getImportValue(row, headerMap, [
      "Name",
      "Employee",
      "Employee Name",
      "User",
    ]).trim();
    const date = normalizeImportDate(
      getImportValue(row, headerMap, ["Date", "Attendance Date", "Day"]),
    );
    const checkIn = normalizeImportTime(
      getImportValue(row, headerMap, ["Check In", "CheckIn", "In Time", "In"]),
    );
    const checkOut = normalizeImportTime(
      getImportValue(row, headerMap, [
        "Check Out",
        "CheckOut",
        "Out Time",
        "Out",
      ]),
    );

    if (!name || !date) {
      skipped += 1;
      return;
    }

    imported.push({
      id: crypto.randomUUID(),
      name,
      role:
        getImportValue(row, headerMap, ["Role", "Designation", "Position"]) ||
        "Team Member",
      date,
      checkIn,
      checkOut,
      location:
        getImportValue(row, headerMap, ["Location", "Work Location"]) ||
        "Office",
    });
  });

  return { records: imported, skipped };
}

function StatCard({ icon, label, value, detail, tone }) {
  const tones = {
    blue: "from-blue-500 to-cyan-500",
    green: "from-emerald-500 to-teal-500",
    amber: "from-amber-500 to-orange-500",
    rose: "from-rose-500 to-pink-500",
  };

  return (
    <div className="rounded-2xl border border-white/70 bg-white p-5 shadow-sm">
      <div className="flex items-start justify-between gap-3">
        <div>
          <p className="text-xs font-bold uppercase tracking-[0.12em] text-slate-400">
            {label}
          </p>
          <p className="mt-3 text-3xl font-black text-slate-900">{value}</p>
        </div>
        <div
          className={`flex h-11 w-11 items-center justify-center rounded-2xl bg-gradient-to-br ${tones[tone]} text-white shadow-sm`}
        >
          <Icon name={icon} className="h-5 w-5" />
        </div>
      </div>
      <p className="mt-3 text-sm font-medium text-slate-500">{detail}</p>
    </div>
  );
}

export default function AttendancePage() {
  const user = useAuthStore((state) => state.user);
  const importInputRef = useRef(null);
  const [records, setRecords] = useState(() => getSavedRecords(user));
  const [query, setQuery] = useState("");
  const [status, setStatus] = useState("All");
  const [location, setLocation] = useState("All");
  const [dateFilter, setDateFilter] = useState(todayKey());
  const [nowTick, setNowTick] = useState(new Date());
  const [modalOpen, setModalOpen] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [form, setForm] = useState(emptyForm);

  const currentName = user?.username || user?.userEmail || "Current User";
  const currentRole = user?.role || "Team Member";

  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(records));
  }, [records]);

  useEffect(() => {
    const timer = window.setInterval(() => setNowTick(new Date()), 30000);
    return () => window.clearInterval(timer);
  }, []);

  const enrichedRecords = useMemo(
    () =>
      records.map((record) => {
        const workedMinutes = getWorkedMinutes(record, nowTick);
        return {
          ...record,
          status: getRecordStatus(record),
          workedMinutes,
          hours: formatDuration(workedMinutes),
        };
      }),
    [records, nowTick],
  );

  const todayRecords = useMemo(
    () => enrichedRecords.filter((record) => record.date === todayKey()),
    [enrichedRecords],
  );

  const myTodayRecord = useMemo(
    () =>
      todayRecords.find(
        (record) =>
          record.name === currentName ||
          record.name === user?.userEmail ||
          record.role === currentRole,
      ),
    [todayRecords, currentName, currentRole, user?.userEmail],
  );

  const filteredRecords = useMemo(() => {
    const q = query.trim().toLowerCase();
    return enrichedRecords
      .filter((record) => {
        const matchesQuery =
          !q ||
          [record.name, record.role, record.location, record.status].some(
            (value) => String(value).toLowerCase().includes(q),
          );
        const matchesStatus = status === "All" || record.status === status;
        const matchesLocation =
          location === "All" || record.location === location;
        const matchesDate = !dateFilter || record.date === dateFilter;
        return matchesQuery && matchesStatus && matchesLocation && matchesDate;
      })
      .sort((a, b) => {
        if (a.date !== b.date) return b.date.localeCompare(a.date);
        return (a.checkIn || "99:99").localeCompare(b.checkIn || "99:99");
      });
  }, [enrichedRecords, query, status, location, dateFilter]);

  const stats = useMemo(() => {
    const present = todayRecords.filter((record) =>
      ["Present", "Active", "Late"].includes(record.status),
    ).length;
    const late = todayRecords.filter((record) => record.status === "Late").length;
    const absent = todayRecords.filter(
      (record) => record.status === "Absent",
    ).length;
    const worked = todayRecords.reduce(
      (total, record) => total + record.workedMinutes,
      0,
    );
    const averageMinutes = present ? Math.round(worked / present) : 0;

    return {
      present,
      late,
      absent,
      average: formatDuration(averageMinutes),
      coverage: todayRecords.length
        ? `${Math.round((present / todayRecords.length) * 100)}% team coverage`
        : "No records yet",
    };
  }, [todayRecords]);

  const weekly = useMemo(() => {
    return Array.from({ length: 7 }, (_, index) => {
      const date = new Date();
      date.setDate(date.getDate() - (6 - index));
      const key = toDateKey(date);
      const dayRecords = enrichedRecords.filter((record) => record.date === key);
      const present = dayRecords.filter((record) =>
        ["Present", "Active", "Late"].includes(record.status),
      ).length;
      const late = dayRecords.filter((record) => record.status === "Late").length;
      return {
        key,
        day: date.toLocaleDateString("en-IN", { weekday: "short" }),
        date: String(date.getDate()).padStart(2, "0"),
        present,
        late,
        total: dayRecords.length,
        active: key === todayKey(),
      };
    });
  }, [enrichedRecords]);

  function ensureMyRecord() {
    let target = myTodayRecord;
    if (target) return target;

    target = {
      id: crypto.randomUUID(),
      name: currentName,
      role: currentRole,
      date: todayKey(),
      checkIn: "",
      checkOut: "",
      location: "Office",
    };
    setRecords((items) => [target, ...items]);
    return target;
  }

  function handlePunch() {
    const target = ensureMyRecord();
    const time = currentTimeValue();

    setRecords((items) =>
      items.map((record) => {
        if (record.id !== target.id) return record;
        if (!record.checkIn) return { ...record, checkIn: time, checkOut: "" };
        if (!record.checkOut) return { ...record, checkOut: time };
        return { ...record, checkIn: time, checkOut: "" };
      }),
    );
  }

  function openCreateModal() {
    setEditingId(null);
    setForm({
      ...emptyForm,
      date: dateFilter || todayKey(),
      name: "",
      role: "",
    });
    setModalOpen(true);
  }

  function openEditModal(record) {
    setEditingId(record.id);
    setForm({
      name: record.name,
      role: record.role,
      date: record.date,
      checkIn: record.checkIn,
      checkOut: record.checkOut,
      location: record.location,
    });
    setModalOpen(true);
  }

  function handleSave(event) {
    event.preventDefault();
    const payload = {
      ...form,
      name: form.name.trim(),
      role: form.role.trim() || "Team Member",
      location: form.location || "Office",
    };

    if (!payload.name) return;
    if (
      payload.checkIn &&
      payload.checkOut &&
      minutesFromTime(payload.checkOut) < minutesFromTime(payload.checkIn)
    ) {
      alert("Check out time cannot be earlier than check in time.");
      return;
    }

    if (editingId) {
      setRecords((items) =>
        items.map((record) =>
          record.id === editingId ? { ...record, ...payload } : record,
        ),
      );
    } else {
      setRecords((items) => [
        { id: crypto.randomUUID(), ...payload },
        ...items,
      ]);
    }

    setModalOpen(false);
  }

  function handleDelete(id) {
    if (!window.confirm("Delete this attendance record?")) return;
    setRecords((items) => items.filter((record) => record.id !== id));
  }

  function resetDemoData() {
    if (!window.confirm("Reset attendance data to demo records?")) return;
    setRecords(seedRecords(user));
    setQuery("");
    setStatus("All");
    setLocation("All");
    setDateFilter(todayKey());
  }

  function exportCsv() {
    const headers = [
      "Name",
      "Role",
      "Date",
      "Check In",
      "Check Out",
      "Hours",
      "Status",
      "Location",
    ];
    const rows = filteredRecords.map((record) => [
      record.name,
      record.role,
      record.date,
      record.checkIn,
      record.checkOut,
      record.hours,
      record.status,
      record.location,
    ]);
    const csv = [headers, ...rows]
      .map((row) =>
        row
          .map((value) => `"${String(value || "").replace(/"/g, '""')}"`)
          .join(","),
      )
      .join("\n");
    const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    const anchor = document.createElement("a");
    anchor.href = url;
    anchor.download = `attendance-${dateFilter || todayKey()}.csv`;
    document.body.appendChild(anchor);
    anchor.click();
    document.body.removeChild(anchor);
    URL.revokeObjectURL(url);
  }

  async function handleImport(event) {
    const file = event.target.files?.[0];
    event.target.value = "";
    if (!file) return;

    try {
      const csvText = await file.text();
      const result = buildImportedRecords(csvText);

      if (result.records.length === 0) {
        alert(
          "No valid attendance records found. Please include at least Name and Date columns.",
        );
        return;
      }

      setRecords((items) => [...result.records, ...items]);
      alert(
        `Imported ${result.records.length} attendance record${
          result.records.length > 1 ? "s" : ""
        }${result.skipped ? `, skipped ${result.skipped} invalid row(s)` : ""}.`,
      );
    } catch {
      alert("Unable to import this file. Please upload a valid CSV file.");
    }
  }

  const punchLabel = !myTodayRecord?.checkIn
    ? "Punch In"
    : !myTodayRecord?.checkOut
      ? "Punch Out"
      : "Start New Shift";
  const punchStatus = !myTodayRecord?.checkIn
    ? "Ready"
    : !myTodayRecord?.checkOut
      ? "Checked in"
      : "Checked out";

  return (
    <div className="space-y-5">
      <section className="overflow-hidden rounded-3xl border border-white/70 bg-slate-950 text-white shadow-sm">
        <div className="grid gap-6 p-6 lg:grid-cols-[1fr_360px] lg:p-8">
          <div className="flex min-w-0 flex-col justify-between">
            <div>
              <div className="mb-5 inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/10 px-3 py-1 text-xs font-semibold text-blue-100">
                <Icon name="mdi:calendar-clock" className="h-4 w-4" />
                {new Date().toLocaleDateString("en-IN", {
                  weekday: "long",
                  day: "numeric",
                  month: "long",
                  year: "numeric",
                })}
              </div>
              <h1 className="text-3xl font-black tracking-tight md:text-4xl">
                Attendance Control Center
              </h1>
              <p className="mt-3 max-w-2xl text-sm leading-6 text-slate-300">
                Track punch activity, shift hours, late arrivals, absences, and
                daily team attendance in one working view.
              </p>
            </div>

            <div className="mt-8 grid gap-3 sm:grid-cols-3">
              {["Office", "Remote", "Field Visit"].map((item) => (
                <div
                  key={item}
                  className="rounded-2xl border border-white/10 bg-white/10 p-4"
                >
                  <p className="text-xs text-slate-400">{item}</p>
                  <p className="mt-2 text-2xl font-bold">
                    {
                      todayRecords.filter((record) => record.location === item)
                        .length
                    }
                  </p>
                </div>
              ))}
            </div>
          </div>

          <div className="rounded-3xl border border-white/10 bg-white/10 p-5">
            <div className="flex items-start justify-between gap-3">
              <div>
                <p className="text-xs font-bold uppercase tracking-[0.14em] text-slate-400">
                  My Shift
                </p>
                <p className="mt-2 text-2xl font-black">
                  {SHIFT_START} - {SHIFT_END}
                </p>
              </div>
              <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-emerald-400/15 text-emerald-300">
                <Icon name="mdi:fingerprint" className="h-6 w-6" />
              </div>
            </div>
            <div className="mt-5 grid grid-cols-2 gap-3 text-sm">
              <div className="rounded-2xl bg-white/10 p-3">
                <p className="text-slate-400">Check in</p>
                <p className="mt-1 font-bold">
                  {formatTime(myTodayRecord?.checkIn)}
                </p>
              </div>
              <div className="rounded-2xl bg-white/10 p-3">
                <p className="text-slate-400">Worked</p>
                <p className="mt-1 font-bold">
                  {myTodayRecord
                    ? formatDuration(getWorkedMinutes(myTodayRecord, nowTick))
                    : "0h"}
                </p>
              </div>
            </div>
            <button
              type="button"
              className="mt-5 inline-flex w-full items-center justify-center gap-2 rounded-2xl bg-white px-4 py-3 text-sm font-bold text-slate-950 transition hover:bg-blue-50"
              onClick={handlePunch}
            >
              <Icon name="mdi:clock-check-outline" className="h-5 w-5" />
              {punchLabel}
            </button>
            <p className="mt-3 text-center text-xs text-slate-400">
              Current status: {punchStatus}
            </p>
          </div>
        </div>
      </section>

      <section className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
        <StatCard
          icon="mdi:account-check-outline"
          label="Present Today"
          value={stats.present}
          detail={stats.coverage}
          tone="green"
        />
        <StatCard
          icon="mdi:clock-alert-outline"
          label="Late Arrivals"
          value={stats.late}
          detail={`Late after ${formatTime(SHIFT_LATE_AFTER)}`}
          tone="amber"
        />
        <StatCard
          icon="mdi:account-off-outline"
          label="Absent"
          value={stats.absent}
          detail="No check in recorded"
          tone="rose"
        />
        <StatCard
          icon="mdi:timer-sand"
          label="Avg Hours"
          value={stats.average}
          detail="Across present team members"
          tone="blue"
        />
      </section>

      <section className="grid gap-5 xl:grid-cols-[360px_1fr]">
        <div className="rounded-3xl border border-white/70 bg-white p-5 shadow-sm">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.12em] text-slate-400">
                Weekly View
              </p>
              <h2 className="mt-1 text-lg font-bold text-slate-900">
                Attendance Pulse
              </h2>
            </div>
            <Icon name="mdi:chart-bar" className="h-5 w-5 text-blue-600" />
          </div>
          <div className="mt-5 space-y-3">
            {weekly.map((item) => {
              const percent = item.total
                ? Math.round((item.present / item.total) * 100)
                : 0;
              return (
                <button
                  key={item.key}
                  type="button"
                  onClick={() => setDateFilter(item.key)}
                  className={`w-full rounded-2xl border p-3 text-left transition ${
                    item.key === dateFilter
                      ? "border-blue-200 bg-blue-50"
                      : "border-slate-100 bg-slate-50 hover:border-blue-100"
                  }`}
                >
                  <div className="mb-2 flex items-center justify-between text-sm">
                    <span className="font-bold text-slate-800">
                      {item.day} {item.date}
                    </span>
                    <span className="text-xs font-semibold text-slate-500">
                      {item.present}/{item.total || 0} present
                    </span>
                  </div>
                  <div className="h-2 overflow-hidden rounded-full bg-white">
                    <div
                      className="h-full rounded-full bg-gradient-to-r from-blue-500 to-emerald-400"
                      style={{ width: `${percent}%` }}
                    />
                  </div>
                  {item.late > 0 && (
                    <p className="mt-2 text-xs font-semibold text-amber-600">
                      {item.late} late arrival{item.late > 1 ? "s" : ""}
                    </p>
                  )}
                </button>
              );
            })}
          </div>
        </div>

        <div className="overflow-hidden rounded-3xl border border-white/70 bg-white shadow-sm">
          <div className="flex flex-col gap-3 border-b border-slate-100 p-5 xl:flex-row xl:items-center xl:justify-between">
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.12em] text-slate-400">
                Daily Register
              </p>
              <h2 className="mt-1 text-lg font-bold text-slate-900">
                Team Attendance Records
              </h2>
            </div>
            <div className="flex flex-col gap-2 sm:flex-row sm:flex-wrap xl:justify-end">
              <div className="relative">
                <Icon
                  name="mdi:magnify"
                  className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"
                />
                <input
                  type="text"
                  value={query}
                  onChange={(event) => setQuery(event.target.value)}
                  placeholder="Search employee"
                  className="w-full rounded-2xl border border-slate-200 bg-white py-2.5 pl-9 pr-3 text-sm outline-none transition focus:border-blue-300 focus:ring-2 focus:ring-blue-500/10 sm:w-52"
                />
              </div>
              <input
                type="date"
                value={dateFilter}
                onChange={(event) => setDateFilter(event.target.value)}
                className="rounded-2xl border border-slate-200 bg-white px-3 py-2.5 text-sm font-medium text-slate-700 outline-none transition focus:border-blue-300 focus:ring-2 focus:ring-blue-500/10"
              />
              <select
                value={status}
                onChange={(event) => setStatus(event.target.value)}
                className="rounded-2xl border border-slate-200 bg-white px-3 py-2.5 text-sm font-medium text-slate-700 outline-none transition focus:border-blue-300 focus:ring-2 focus:ring-blue-500/10"
              >
                {["All", "Present", "Active", "Late", "Absent"].map((item) => (
                  <option key={item} value={item}>
                    {item}
                  </option>
                ))}
              </select>
              <select
                value={location}
                onChange={(event) => setLocation(event.target.value)}
                className="rounded-2xl border border-slate-200 bg-white px-3 py-2.5 text-sm font-medium text-slate-700 outline-none transition focus:border-blue-300 focus:ring-2 focus:ring-blue-500/10"
              >
                {["All", "Office", "Remote", "Field Visit"].map((item) => (
                  <option key={item} value={item}>
                    {item}
                  </option>
                ))}
              </select>
              <button
                type="button"
                className="inline-flex items-center justify-center gap-2 rounded-2xl border border-slate-200 bg-white px-3 py-2.5 text-sm font-bold text-slate-700 transition hover:border-blue-200 hover:bg-blue-50"
                onClick={() => importInputRef.current?.click()}
              >
                <Icon name="mdi:upload" className="h-4 w-4" />
                Import
              </button>
              <input
                ref={importInputRef}
                type="file"
                accept=".csv,text/csv"
                className="hidden"
                onChange={handleImport}
              />
              <button
                type="button"
                className="inline-flex items-center justify-center gap-2 rounded-2xl border border-slate-200 bg-white px-3 py-2.5 text-sm font-bold text-slate-700 transition hover:border-blue-200 hover:bg-blue-50"
                onClick={exportCsv}
                disabled={filteredRecords.length === 0}
              >
                <Icon name="mdi:download" className="h-4 w-4" />
                Export
              </button>
              <button
                type="button"
                className="inline-flex items-center justify-center gap-2 rounded-2xl bg-slate-950 px-3 py-2.5 text-sm font-bold text-white transition hover:bg-slate-800"
                onClick={openCreateModal}
              >
                <Icon name="mdi:plus" className="h-4 w-4" />
                Add
              </button>
            </div>
          </div>

          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-slate-100">
              <thead className="bg-slate-50">
                <tr>
                  {[
                    "Employee",
                    "Date",
                    "Check In",
                    "Check Out",
                    "Hours",
                    "Status",
                    "Location",
                    "Actions",
                  ].map((heading) => (
                    <th
                      key={heading}
                      className="px-5 py-3 text-left text-xs font-bold uppercase tracking-[0.08em] text-slate-500"
                    >
                      {heading}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-100 bg-white">
                {filteredRecords.length === 0 ? (
                  <tr>
                    <td colSpan={8} className="px-5 py-14 text-center">
                      <Icon
                        name="mdi:calendar-search"
                        className="mx-auto h-10 w-10 text-slate-300"
                      />
                      <p className="mt-3 text-sm font-bold text-slate-700">
                        No attendance records found
                      </p>
                      <p className="mt-1 text-xs text-slate-500">
                        Adjust filters or add a new attendance record.
                      </p>
                    </td>
                  </tr>
                ) : (
                  filteredRecords.map((record) => (
                    <tr key={record.id} className="hover:bg-slate-50">
                      <td className="px-5 py-4">
                        <div className="flex items-center gap-3">
                          <div className="flex h-10 w-10 items-center justify-center rounded-2xl bg-slate-100 text-sm font-bold text-slate-700">
                            {getInitials(record.name)}
                          </div>
                          <div>
                            <p className="font-bold text-slate-900">
                              {record.name}
                            </p>
                            <p className="text-xs text-slate-500">
                              {record.role}
                            </p>
                          </div>
                        </div>
                      </td>
                      <td className="px-5 py-4 text-sm text-slate-600">
                        {formatDate(record.date)}
                      </td>
                      <td className="px-5 py-4 text-sm font-semibold text-slate-700">
                        {formatTime(record.checkIn)}
                      </td>
                      <td className="px-5 py-4 text-sm font-semibold text-slate-700">
                        {formatTime(record.checkOut)}
                      </td>
                      <td className="px-5 py-4 text-sm font-bold text-slate-900">
                        {record.hours}
                      </td>
                      <td className="px-5 py-4">
                        <span
                          className={`inline-flex rounded-full border px-2.5 py-1 text-xs font-bold ${statusStyles[record.status]}`}
                        >
                          {record.status}
                        </span>
                      </td>
                      <td className="px-5 py-4 text-sm text-slate-600">
                        {record.location}
                      </td>
                      <td className="px-5 py-4">
                        <div className="flex items-center gap-1">
                          <button
                            type="button"
                            className="rounded-xl p-2 text-slate-500 transition hover:bg-blue-50 hover:text-blue-700"
                            onClick={() => openEditModal(record)}
                            title="Edit"
                          >
                            <Icon name="mdi:pencil" className="h-4 w-4" />
                          </button>
                          <button
                            type="button"
                            className="rounded-xl p-2 text-slate-500 transition hover:bg-rose-50 hover:text-rose-700"
                            onClick={() => handleDelete(record.id)}
                            title="Delete"
                          >
                            <Icon name="mdi:trash-can-outline" className="h-4 w-4" />
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>

          <div className="flex flex-col gap-3 border-t border-slate-100 bg-slate-50 px-5 py-4 sm:flex-row sm:items-center sm:justify-between">
            <p className="text-sm font-medium text-slate-500">
              Showing {filteredRecords.length} of {enrichedRecords.length}{" "}
              records
            </p>
            <div className="flex flex-wrap gap-2">
              <button
                type="button"
                className="inline-flex items-center gap-2 rounded-2xl border border-slate-200 bg-white px-3 py-2 text-sm font-bold text-slate-700 transition hover:bg-slate-100"
                onClick={() => {
                  setQuery("");
                  setStatus("All");
                  setLocation("All");
                  setDateFilter(todayKey());
                }}
              >
                <Icon name="mdi:filter-remove-outline" className="h-4 w-4" />
                Clear Filters
              </button>
              <button
                type="button"
                className="inline-flex items-center gap-2 rounded-2xl border border-slate-200 bg-white px-3 py-2 text-sm font-bold text-slate-700 transition hover:bg-slate-100"
                onClick={resetDemoData}
              >
                <Icon name="mdi:restore" className="h-4 w-4" />
                Reset Demo
              </button>
            </div>
          </div>
        </div>
      </section>

      <AppModal
        open={modalOpen}
        onClose={() => setModalOpen(false)}
        title={editingId ? "Edit Attendance" : "Add Attendance"}
        size="lg"
      >
        <form onSubmit={handleSave} className="space-y-4">
          <div className="grid gap-4 sm:grid-cols-2">
            <div>
              <label className="form-label">Employee Name</label>
              <input
                required
                className="form-input"
                value={form.name}
                onChange={(event) =>
                  setForm((current) => ({
                    ...current,
                    name: event.target.value,
                  }))
                }
                placeholder="Employee name"
              />
            </div>
            <div>
              <label className="form-label">Role</label>
              <input
                className="form-input"
                value={form.role}
                onChange={(event) =>
                  setForm((current) => ({
                    ...current,
                    role: event.target.value,
                  }))
                }
                placeholder="Team role"
              />
            </div>
            <div>
              <label className="form-label">Date</label>
              <input
                required
                type="date"
                className="form-input"
                value={form.date}
                onChange={(event) =>
                  setForm((current) => ({
                    ...current,
                    date: event.target.value,
                  }))
                }
              />
            </div>
            <div>
              <label className="form-label">Location</label>
              <select
                className="form-select"
                value={form.location}
                onChange={(event) =>
                  setForm((current) => ({
                    ...current,
                    location: event.target.value,
                  }))
                }
              >
                <option value="Office">Office</option>
                <option value="Remote">Remote</option>
                <option value="Field Visit">Field Visit</option>
              </select>
            </div>
            <div>
              <label className="form-label">Check In</label>
              <input
                type="time"
                className="form-input"
                value={form.checkIn}
                onChange={(event) =>
                  setForm((current) => ({
                    ...current,
                    checkIn: event.target.value,
                  }))
                }
              />
            </div>
            <div>
              <label className="form-label">Check Out</label>
              <input
                type="time"
                className="form-input"
                value={form.checkOut}
                onChange={(event) =>
                  setForm((current) => ({
                    ...current,
                    checkOut: event.target.value,
                  }))
                }
              />
            </div>
          </div>

          <div className="flex justify-end gap-2 border-t border-slate-100 pt-4">
            <button
              type="button"
              className="btn-secondary"
              onClick={() => setModalOpen(false)}
            >
              Cancel
            </button>
            <button type="submit" className="btn-primary">
              {editingId ? "Save Changes" : "Add Record"}
            </button>
          </div>
        </form>
      </AppModal>
    </div>
  );
}
