// import { useState } from "react";
// import { Link } from "react-router-dom";
// import { useLead } from "../../hooks/useLead";
// import AppAlert from "../../components/common/AppAlert";
// import AppCard from "../../components/common/AppCard";
// import AppInput from "../../components/common/AppInput";
// import Icon from "../../components/Icon";

// export default function LeadImportPage() {
//   const { importFromIndiamart } = useLead();
//   const [fromDate, setFromDate] = useState("");
//   const [toDate, setToDate] = useState("");
//   const [loading, setLoading] = useState(false);
//   const [alert, setAlert] = useState(null);

//   function validateDates() {
//     if (!fromDate || !toDate) {
//       return "Both From Date and To Date are required.";
//     }

//     const from = new Date(`${fromDate}T00:00:00`);
//     const to = new Date(`${toDate}T00:00:00`);

//     if (Number.isNaN(from.getTime()) || Number.isNaN(to.getTime())) {
//       return "Please select valid dates.";
//     }

//     if (from > to) {
//       return "From Date cannot be later than To Date.";
//     }

//     const dayMs = 24 * 60 * 60 * 1000;
//     if ((to - from) / dayMs > 365) {
//       return "Date range cannot exceed 365 days.";
//     }

//     return null;
//   }

//   async function handleImport(e) {
//     e.preventDefault();

//     const validationError = validateDates();
//     if (validationError) {
//       setAlert({ type: "error", message: validationError });
//       return;
//     }

//     setLoading(true);
//     setAlert(null);

//     try {
//       const importedLeads = await importFromIndiamart(fromDate, toDate);
//       const count = Array.isArray(importedLeads) ? importedLeads.length : 0;

//       setAlert({
//         type: count > 0 ? "success" : "warning",
//         message:
//           count > 0
//             ? `Successfully imported ${count} lead(s) from Indiamart.`
//             : "No new Indiamart leads were found for this date range.",
//       });
//     } catch (error) {
//       setAlert({
//         type: "error",
//         message:
//           error?.response?.data?.message ||
//           error?.message ||
//           "Import failed. Please check the Indiamart configuration and try again.",
//       });
//     } finally {
//       setLoading(false);
//     }
//   }

//   function updateDate(setter) {
//     return (e) => {
//       setter(e.target.value);
//       if (alert) setAlert(null);
//     };
//   }

//   return (
//     <div className="animate-fade-in">
//       <div className="flex items-center gap-3 mb-6">
//         <Link
//           to="/lead"
//           className="text-gray-400 hover:text-gray-600 transition-colors"
//         >
//           <Icon name="mdi:arrow-left" className="text-xl" />
//         </Link>
//         <h1 className="text-2xl font-bold text-gray-900">
//           Import Leads from Indiamart
//         </h1>
//       </div>

//       <div className="max-w-lg">
//         {alert && (
//           <AppAlert
//             type={alert.type}
//             message={alert.message}
//             className="mb-4"
//             onClose={() => setAlert(null)}
//           />
//         )}

//         <AppCard title="Import Settings">
//           <form onSubmit={handleImport} className="space-y-4">
//             <AppInput
//               label="From Date"
//               type="date"
//               value={fromDate}
//               onChange={updateDate(setFromDate)}
//               required
//             />

//             <AppInput
//               label="To Date"
//               type="date"
//               value={toDate}
//               onChange={updateDate(setToDate)}
//               required
//             />

//             <button
//               type="submit"
//               disabled={loading || !fromDate || !toDate}
//               className="w-full flex items-center justify-center gap-2 px-4 py-2.5 bg-indigo-600 text-white font-semibold rounded-lg hover:bg-indigo-700 transition-colors disabled:opacity-60 disabled:cursor-not-allowed"
//             >
//               {loading ? (
//                 <>
//                   <Icon name="mdi:loading" className="animate-spin" />
//                   Importing...
//                 </>
//               ) : (
//                 <>
//                   <Icon name="mdi:cloud-download" />
//                   Import Leads
//                 </>
//               )}
//             </button>
//           </form>
//         </AppCard>

//         <div className="mt-4 p-3 bg-blue-50 rounded-lg border border-blue-100">
//           <div className="flex items-start gap-2">
//             <Icon name="mdi:information" className="text-blue-500 text-sm mt-0.5" />
//             <p className="text-xs text-blue-700">
//               Select a date range to fetch new Indiamart enquiries. Duplicate
//               enquiries are skipped using the IndiaMART query ID.
//             </p>
//           </div>
//         </div>
//       </div>
//     </div>
//   );
// }

import { useState } from "react";
import { Link } from "react-router-dom";
import { useLead } from "../../hooks/useLead";

import AppAlert from "../../components/common/AppAlert";
import AppCard from "../../components/common/AppCard";
import AppInput from "../../components/common/AppInput";
import Icon from "../../components/Icon";

export default function LeadImportPage() {
  const { importFromIndiamart } = useLead();

  const [fromDate, setFromDate] = useState("");
  const [toDate, setToDate] = useState("");

  const [loading, setLoading] = useState(false);
  const [alert, setAlert] = useState(null);

  function validateDates() {
    if (!fromDate || !toDate) {
      return "Both From Date and To Date are required.";
    }

    const from = new Date(`${fromDate}T00:00:00`);
    const to = new Date(`${toDate}T00:00:00`);

    if (
      Number.isNaN(from.getTime()) ||
      Number.isNaN(to.getTime())
    ) {
      return "Please select valid dates.";
    }

    if (from > to) {
      return "From Date cannot be later than To Date.";
    }

    const dayMs = 24 * 60 * 60 * 1000;

    if ((to - from) / dayMs > 365) {
      return "Date range cannot exceed 365 days.";
    }

    return null;
  }

  async function handleImport(e) {
    e.preventDefault();

    const validationError = validateDates();

    if (validationError) {
      setAlert({
        type: "error",
        message: validationError,
      });

      return;
    }

    setLoading(true);
    setAlert(null);

    try {
      const importedLeads = await importFromIndiamart(
        fromDate,
        toDate
      );

      const count = Array.isArray(importedLeads)
        ? importedLeads.length
        : 0;

      setAlert({
        type: count > 0 ? "success" : "warning",
        message:
          count > 0
            ? `Successfully imported ${count} lead(s) from Indiamart.`
            : "No new Indiamart leads were found for this date range.",
      });
    } catch (error) {
      setAlert({
        type: "error",
        message:
          error?.response?.data?.message ||
          error?.message ||
          "Import failed. Please check the Indiamart configuration and try again.",
      });
    } finally {
      setLoading(false);
    }
  }

  function updateDate(setter) {
    return (value) => {
      setter(value);

      if (alert) {
        setAlert(null);
      }
    };
  }

  return (
    <div className="animate-fade-in">
      <div className="flex items-center gap-3 mb-6">
        <Link
          to="/lead"
          className="text-gray-400 hover:text-gray-600 transition-colors"
        >
          <Icon
            name="mdi:arrow-left"
            className="text-xl"
          />
        </Link>

        <h1 className="text-2xl font-bold text-gray-900">
          Import Leads from Indiamart
        </h1>
      </div>

      <div className="max-w-lg">
        {alert && (
          <AppAlert
            type={alert.type}
            message={alert.message}
            className="mb-4"
            onClose={() => setAlert(null)}
          />
        )}

        <AppCard title="Import Settings">
          <form
            onSubmit={handleImport}
            className="space-y-4"
          >
            <AppInput
              label="From Date"
              type="date"
              value={fromDate}
              onChange={updateDate(setFromDate)}
              required
            />

            <AppInput
              label="To Date"
              type="date"
              value={toDate}
              onChange={updateDate(setToDate)}
              required
            />

            <button
              type="submit"
              disabled={
                loading || !fromDate || !toDate
              }
              className="w-full flex items-center justify-center gap-2 px-4 py-2.5 bg-indigo-600 text-white font-semibold rounded-lg hover:bg-indigo-700 transition-colors disabled:opacity-60 disabled:cursor-not-allowed"
            >
              {loading ? (
                <>
                  <Icon
                    name="mdi:loading"
                    className="animate-spin"
                  />
                  Importing...
                </>
              ) : (
                <>
                  <Icon name="mdi:cloud-download" />
                  Import Leads
                </>
              )}
            </button>
          </form>
        </AppCard>

        <div className="mt-4 p-3 bg-blue-50 rounded-lg border border-blue-100">
          <div className="flex items-start gap-2">
            <Icon
              name="mdi:information"
              className="text-blue-500 text-sm mt-0.5"
            />

            <p className="text-xs text-blue-700">
              Select a date range to fetch new
              Indiamart enquiries. Duplicate
              enquiries are skipped using the
              IndiaMART query ID.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}