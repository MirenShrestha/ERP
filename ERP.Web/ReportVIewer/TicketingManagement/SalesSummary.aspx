﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesSummary.aspx.cs" Inherits="ERP.Web.ReportVIewer.TicketingManagement.SalesSummary" %>

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
        <rsweb:ReportViewer ID="ReportViewer1" runat="server"  AsyncRendering="false" SizeToReportContent="true" Width="1375px" ZoomMode="FullPage">
        </rsweb:ReportViewer>
    </form>
</body>
</html>
