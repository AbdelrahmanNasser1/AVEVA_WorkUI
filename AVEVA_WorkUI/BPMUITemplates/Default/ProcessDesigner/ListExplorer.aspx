<%@ Page Language="C#" AutoEventWireup="true"  CodeFile ="ListExplorer.aspx.cs" Inherits="BPMUITemplates_Default_Repository_Site_ListExplorer" %>

<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web.Lookup" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<html >
<head runat="server">
    <title>Skelta BPM.NET 2007 -<%= actionname%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <link rel="stylesheet" type="text/css" href="../../../Repository/Site/styles/aquila.css" />
    <!--[if lt IE 7]>
    <script defer type="text/javascript" src="../../../Repository/Site/scripts/pngfix.js"></script>
    <![endif]-->
    <script type="text/javascript" language="javascript">
        function GetRadWindow()
        {
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function setValues(id1)
        {
            var oWindow = GetRadWindow();
            oWindow.close(id1);
        }
    </script>

</head>
<!--<body  background="..\images\bg.jpg"> -->
    <body  bgcolor="6690CD"> 

    <form id="form1" runat="server">
          <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
      <!--  <div  background="..\images\bg.jpg"> -->
            
            <table border="0" width="100%" border="0"  background="..\images\bg1.jpg">
                <tr align="left" valign="middle" height="35px">
                    <td width="5" rowspan="4">
                    </td>
                    <td colspan="2" valign="middle">
                        <table border="0">
                            <tr>
                                <td>
                                 <!--   <img src="..\images\Icon-ListExplorer.png" /> -->
                                </td>
                                <td>
                                    <asp:Label ID="lblhelp" runat="server" Text="" CssClass="runtext" ForeColor="white"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr align="left">
                    <td>
                        <asp:Label ID="lbllistexplorer" runat="server" Text="" CssClass="runtext" ForeColor="white"></asp:Label>
                    </td>
                    <td>
                        <cc1:ListExplorer ID="listExplorer1" runat="server" />
                    </td>
                </tr>
                <tr align="left" id="trlookup" runat="server">
                    <td>
                        <asp:Label ID="lbllookup" runat="server" Text="Listitem " CssClass="runtext" ForeColor="white"></asp:Label>
                    </td>
                    <td>
                        <asp:Panel ID="listItemLookupPanel" runat="server">
                        </asp:Panel>
                    </td>
                </tr>
                <tr align="left" width="100%">
                    <td>
                    </td>
                    <td align="left" valign="middle" height="41">
                        <asp:Button ID="btnSelect" CssClass="inputsBox" runat="server" Text="Select" OnClick="btnSelect_Click1" />
                        <asp:Button ID="btnClose" CssClass="inputsBox" runat="server" OnClientClick="Javascript:setValues('/');"
                            Text="Close" />
                    </td>
                </tr>
            </table>
           
       <!-- </div> -->
    </form>
</body>
</html>
