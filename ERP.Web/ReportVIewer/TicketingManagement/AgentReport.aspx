<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgentReport.aspx.cs" Inherits="ERP.Web.ReportVIewer.TicketingManagement.AgentReport" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="542px" Width="1229px">
        </rsweb:ReportViewer>
    </form>
</body>
</html>
