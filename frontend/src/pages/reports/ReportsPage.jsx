import { useEffect, useMemo, useState } from "react";
import {
  ResponsiveContainer,
  BarChart,
  Bar,
  XAxis,
  Tooltip,
  PieChart,
  Pie,
  Cell,
  LineChart,
  Line,
  CartesianGrid,
  YAxis,
} from "recharts";

import Icon from "../../components/Icon";
import { useAdvancedCrmData } from "../../hooks/useAdvancedCrmData";

const COLORS = ["#3B82F6", "#10B981", "#F59E0B", "#EF4444"];

function StatCard({ title, value, icon, trend }) {
  return (
    <div className="bg-white rounded-2xl border border-gray-200 p-5 shadow-sm">
      <div className="flex items-start justify-between">
        <div>
          <p className="text-sm text-gray-500">{title}</p>

          <h2 className="text-3xl font-bold text-gray-900 mt-2">
            {value}
          </h2>

          <div className="mt-2 flex items-center gap-1 text-sm text-green-600">
            <Icon name="mdi:trending-up" className="w-4 h-4" />
            {trend}
          </div>
        </div>

        <div className="w-12 h-12 rounded-xl bg-blue-50 flex items-center justify-center text-blue-600">
          <Icon name={icon} className="w-6 h-6" />
        </div>
      </div>
    </div>
  );
}

export default function ReportsPage() {
  const { load } = useAdvancedCrmData();

  const [crmData, setCrmData] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await load(true);
        setCrmData(data);
      } catch (error) {
        console.error("Failed to load reports data:", error);
      }
    };

    fetchData();
  }, []);

  const analytics = useMemo(() => {
    if (!crmData) return null;

    const deals = crmData.dealsList || [];
    const activities = crmData.activityFeed || [];
    const reports = crmData.reportLibrary || [];
    const reps = crmData.repRanking || [];

    const totalRevenue = deals.reduce(
      (sum, d) => sum + Number(d.value || 0),
      0
    );

    const wonDeals = deals.filter(
      (d) => String(d.stage).toLowerCase() === "won"
    );

    const pipelineData =
      crmData.pipelineStages?.map((stage) => ({
        name: stage.name,
        deals: stage.deals.length,
      })) || [];

    const activityData = ["Call", "Meeting", "Email", "Note"].map(
      (type) => ({
        name: type,
        value: activities.filter((a) => a.type === type).length,
      })
    );

    const salesPerformance = reps.map((r) => ({
      name: r.name,
      quota: r.quota || 0,
    }));

    return {
      totalRevenue,
      totalDeals: deals.length,
      wonDeals: wonDeals.length,
      reportsCount: reports.length,
      pipelineData,
      activityData,
      salesPerformance,
      reports,
    };
  }, [crmData]);

  if (!analytics) {
    return (
      <div className="h-[80vh] flex items-center justify-center text-gray-500">
        Loading reports...
      </div>
    );
  }

  return (
    <div className="space-y-6 p-6 bg-gray-50 min-h-screen">
      {/* HEADER */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">
            Reports Dashboard
          </h1>

          <p className="text-gray-500 mt-1">
            CRM insights and analytics overview
          </p>
        </div>

        <button className="btn-primary flex items-center gap-2">
          <Icon name="mdi:file-export-outline" className="w-5 h-5" />
          Export Report
        </button>
      </div>

      {/* STATS */}
      <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-5">
        <StatCard
          title="Revenue"
          value={`$${analytics.totalRevenue.toLocaleString()}`}
          icon="mdi:currency-usd"
          trend="+12%"
        />

        <StatCard
          title="Deals"
          value={analytics.totalDeals}
          icon="mdi:briefcase-outline"
          trend="+8%"
        />

        <StatCard
          title="Won Deals"
          value={analytics.wonDeals}
          icon="mdi:trophy-outline"
          trend="+4%"
        />

        <StatCard
          title="Reports"
          value={analytics.reportsCount}
          icon="mdi:file-chart-outline"
          trend="+2 new"
        />
      </div>

      {/* CHARTS */}
      <div className="grid grid-cols-1 xl:grid-cols-3 gap-6">
        {/* PIPELINE */}
        <div className="xl:col-span-2 bg-white rounded-2xl border border-gray-200 p-5 shadow-sm">
          <h2 className="text-lg font-semibold mb-4">
            Pipeline Overview
          </h2>

          <div className="h-[300px]">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={analytics.pipelineData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="name" />
                <YAxis />
                <Tooltip />
                <Bar dataKey="deals" radius={[8, 8, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* ACTIVITIES */}
        <div className="bg-white rounded-2xl border border-gray-200 p-5 shadow-sm">
          <h2 className="text-lg font-semibold mb-4">
            Activities
          </h2>

          <div className="h-[300px]">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={analytics.activityData}
                  dataKey="value"
                  outerRadius={100}
                  label
                >
                  {analytics.activityData.map((entry, index) => (
                    <Cell
                      key={index}
                      fill={COLORS[index % COLORS.length]}
                    />
                  ))}
                </Pie>

                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>

      {/* SALES PERFORMANCE */}
      <div className="bg-white rounded-2xl border border-gray-200 p-5 shadow-sm">
        <h2 className="text-lg font-semibold mb-4">
          Sales Performance
        </h2>

        <div className="h-[300px]">
          <ResponsiveContainer width="100%" height="100%">
            <LineChart data={analytics.salesPerformance}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="name" />
              <YAxis />
              <Tooltip />

              <Line
                type="monotone"
                dataKey="quota"
                stroke="#3B82F6"
                strokeWidth={3}
              />
            </LineChart>
          </ResponsiveContainer>
        </div>
      </div>

      {/* REPORT TABLE */}
      <div className="bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden">
        <div className="p-5 border-b border-gray-100">
          <h2 className="text-lg font-semibold">
            Recent Reports
          </h2>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50">
              <tr>
                <th className="text-left px-5 py-3">Report</th>
                <th className="text-left px-5 py-3">Category</th>
                <th className="text-left px-5 py-3">Uses</th>
                <th className="text-left px-5 py-3">Description</th>
              </tr>
            </thead>

            <tbody>
              {analytics.reports.map((report, index) => (
                <tr
                  key={index}
                  className="border-t border-gray-100 hover:bg-gray-50"
                >
                  <td className="px-5 py-4 font-medium">
                    {report.title}
                  </td>

                  <td className="px-5 py-4">
                    {report.category}
                  </td>

                  <td className="px-5 py-4">
                    {report.uses}
                  </td>

                  <td className="px-5 py-4 text-gray-500">
                    {report.description}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}