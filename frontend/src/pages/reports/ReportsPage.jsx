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

          <h2 className="text-3xl font-bold text-gray-900 mt-2">{value}</h2>

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
  const [exporting, setExporting] = useState(false);
  const [exportFormat, setExportFormat] = useState("csv"); // 'csv' or 'pdf'

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
      0,
    );

    const wonDeals = deals.filter(
      (d) => String(d.stage).toLowerCase() === "won",
    );

    const pipelineData =
      crmData.pipelineStages?.map((stage) => ({
        name: stage.name,
        deals: stage.deals.length,
      })) || [];

    const activityData = ["Call", "Meeting", "Email", "Note"].map((type) => ({
      name: type,
      value: activities.filter((a) => a.type === type).length,
    }));

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

  // Function to export to CSV
  const exportToCSV = () => {
    if (!analytics) return;

    // Prepare the data for export
    const exportData = {
      summary: {
        totalRevenue: analytics.totalRevenue,
        totalDeals: analytics.totalDeals,
        wonDeals: analytics.wonDeals,
        reportsCount: analytics.reportsCount,
      },
      pipelineData: analytics.pipelineData,
      activityData: analytics.activityData,
      salesPerformance: analytics.salesPerformance,
      reports: analytics.reports,
      exportDate: new Date().toLocaleString(),
    };

    // Create CSV rows
    const csvRows = [];
    
    // Add header
    csvRows.push(['"CRM REPORT EXPORT"']);
    csvRows.push([`"Export Date: ${exportData.exportDate}"`]);
    csvRows.push(['']);
    
    // Summary section
    csvRows.push(['"SUMMARY STATISTICS"']);
    csvRows.push(['"Metric","Value"']);
    csvRows.push([`"Total Revenue","₹${exportData.summary.totalRevenue.toLocaleString()}"`]);
    csvRows.push([`"Total Deals",${exportData.summary.totalDeals}`]);
    csvRows.push([`"Won Deals",${exportData.summary.wonDeals}`]);
    csvRows.push([`"Reports Count",${exportData.summary.reportsCount}`]);
    csvRows.push(['']);
    
    // Pipeline section
    csvRows.push(['"PIPELINE OVERVIEW"']);
    csvRows.push(['"Stage","Number of Deals"']);
    exportData.pipelineData.forEach(item => {
      csvRows.push([`"${item.name}"`, item.deals]);
    });
    csvRows.push(['']);
    
    // Activity section
    csvRows.push(['"ACTIVITY BREAKDOWN"']);
    csvRows.push(['"Activity Type","Count"']);
    exportData.activityData.forEach(item => {
      csvRows.push([`"${item.name}"`, item.value]);
    });
    csvRows.push(['']);
    
    // Sales performance section
    csvRows.push(['"SALES PERFORMANCE"']);
    csvRows.push(['"Sales Rep","Quota"']);
    exportData.salesPerformance.forEach(item => {
      csvRows.push([`"${item.name}"`, item.quota]);
    });
    csvRows.push(['']);
    
    // Reports section
    csvRows.push(['"RECENT REPORTS"']);
    csvRows.push(['"Report Title","Category","Uses","Description"']);
    exportData.reports.forEach(report => {
      csvRows.push([
        `"${report.title.replace(/"/g, '""')}"`,
        `"${report.category}"`,
        report.uses,
        `"${report.description.replace(/"/g, '""')}"`
      ]);
    });
    
    // Create CSV content
    const csvContent = csvRows.map(row => row.join(',')).join('\n');
    
    // Add BOM for UTF-8 with special characters
    const blob = new Blob(['\uFEFF' + csvContent], { type: 'text/csv;charset=utf-8;' });
    
    // Download the file
    const link = document.createElement('a');
    const url = URL.createObjectURL(blob);
    link.setAttribute('href', url);
    link.setAttribute('download', `crm_report_${new Date().toISOString().split('T')[0]}.csv`);
    link.style.visibility = 'hidden';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
  };

  // Function to export to PDF (requires html2pdf.js)
  const exportToPDF = async () => {
    if (!analytics) return;
    
    try {
      // Dynamically import html2pdf to avoid loading if not needed
      const html2pdf = (await import('html2pdf.js')).default;
      
      const element = document.getElementById('report-content');
      const opt = {
        margin: [0.5, 0.5, 0.5, 0.5],
        filename: `crm_report_${new Date().toISOString().split('T')[0]}.pdf`,
        image: { type: 'jpeg', quality: 0.98 },
        html2canvas: { scale: 2, useCORS: true, logging: false },
        jsPDF: { unit: 'in', format: 'a4', orientation: 'landscape' }
      };
      
      await html2pdf().set(opt).from(element).save();
    } catch (error) {
      console.error('PDF export failed:', error);
      alert('PDF export failed. Please try CSV export instead.');
    }
  };

  // Main export handler with format selection
  const handleExportReport = async () => {
    if (!analytics) {
      alert('No data available to export');
      return;
    }

    setExporting(true);
    
    try {
      if (exportFormat === 'csv') {
        exportToCSV();
      } else if (exportFormat === 'pdf') {
        await exportToPDF();
      }
    } catch (error) {
      console.error('Export failed:', error);
      alert('Failed to export report. Please try again.');
    } finally {
      setExporting(false);
    }
  };

  // Format selector dropdown component
  const ExportButton = () => (
    <div className="relative">
      <div className="flex gap-2">
        <select
          value={exportFormat}
          onChange={(e) => setExportFormat(e.target.value)}
          className="px-3 py-2 border border-gray-300 rounded-lg bg-white text-gray-700 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
        >
          <option value="csv">CSV Format</option>
          <option value="pdf">PDF Format</option>
        </select>
        
        <button 
          onClick={handleExportReport}
          disabled={exporting}
          className="btn-primary flex items-center gap-2 px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {exporting ? (
            <>
              <svg className="animate-spin h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              Exporting...
            </>
          ) : (
            <>
              <Icon name="mdi:file-export-outline" className="w-5 h-5" />
              Export Report
            </>
          )}
        </button>
      </div>
    </div>
  );

  if (!analytics) {
    return (
      <div className="h-[80vh] flex items-center justify-center text-gray-500">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
          Loading reports...
        </div>
      </div>
    );
  }

  return (
    <div id="report-content" className="space-y-6 p-6 bg-gray-50 min-h-screen">
      {/* HEADER */}
      <div className="flex items-center justify-between flex-wrap gap-4">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">
            Reports Dashboard
          </h1>

          <p className="text-gray-500 mt-1">
            CRM insights and analytics overview
          </p>
        </div>

        <ExportButton />
      </div>

      {/* STATS */}
      <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-5">
        <StatCard
          title="Revenue"
          value={`₹${analytics.totalRevenue.toLocaleString()}`}
          icon="mdi:currency-inr"
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
          <h2 className="text-lg font-semibold mb-4">Pipeline Overview</h2>

          <div className="h-[300px]">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={analytics.pipelineData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="name" />
                <YAxis />
                <Tooltip />
                <Bar dataKey="deals" radius={[8, 8, 0, 0]} fill="#3B82F6" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* ACTIVITIES */}
        <div className="bg-white rounded-2xl border border-gray-200 p-5 shadow-sm">
          <h2 className="text-lg font-semibold mb-4">Activities</h2>

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
                    <Cell key={index} fill={COLORS[index % COLORS.length]} />
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
        <h2 className="text-lg font-semibold mb-4">Sales Performance</h2>

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
          <h2 className="text-lg font-semibold">Recent Reports</h2>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50">
              <tr>
                <th className="text-left px-5 py-3 font-semibold text-gray-700">Report</th>
                <th className="text-left px-5 py-3 font-semibold text-gray-700">Category</th>
                <th className="text-left px-5 py-3 font-semibold text-gray-700">Uses</th>
                <th className="text-left px-5 py-3 font-semibold text-gray-700">Description</th>
              </tr>
            </thead>

            <tbody>
              {analytics.reports.map((report, index) => (
                <tr
                  key={index}
                  className="border-t border-gray-100 hover:bg-gray-50 transition-colors"
                >
                  <td className="px-5 py-4 font-medium text-gray-900">{report.title}</td>
                  <td className="px-5 py-4 text-gray-600">{report.category}</td>
                  <td className="px-5 py-4 text-gray-600">{report.uses}</td>
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