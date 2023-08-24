<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ActorsSelectionWizard.aspx.cs" Inherits="SkeltaTemplates_Default_ProcessDesigner_Wizards_ActorsSelectionWizard" Theme="" StylesheetTheme=""%>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer"   TagPrefix="cc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >

<html>
<head>
    <title><%=actorsSelectionWizardTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>     
	<link href="<%=ProcessDesignerControl.GetCommonRelativeUrl("StyleSheet/Global.css")%>" rel="stylesheet" type="text/css">
</head>
<body class="body-blue"> 

    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
        <cc1:ResourceWizardControl ID="ResourceWizardControl1" runat="server" />
    </div>
       
    </form>
</body>
</html>
