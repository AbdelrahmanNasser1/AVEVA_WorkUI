<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FormsLookup.aspx.cs" Inherits="FormsLookup" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!Doctype html>
<html>
<head>
    <title>
        <%=strForm_Lookup %>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <link href="<%=themepath %>Common/StyleSheet/Global.css" type="text/css" rel="stylesheet" />
    <style>
        html, body {
            height: 100%;
            width: 100%;
            overflow-x: hidden;
            overflow-y:auto;
        }
    </style>
    <script type="text/javascript" language="javascript">
        function GetRadWindow()
        {
            
            var oWindow = null;
             oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function ReturnValues(forms)
        {          
            var oWindow = GetRadWindow();
            oWindow.close(forms);
        }
        function DuplicateItem()
        {
            alert('Already the form with the same version has selected');
        }
        function DisplayAllow()
        {
            var div1 = document.getElementById('ownedonly');
            var div2 = document.getElementById('allow');
            div1.style.display='none';
            div2.style.display='block';
        }
        function DisplayOwned()
        {
            var div1 = document.getElementById('ownedonly');
            var div2 = document.getElementById('allow');
            div1.style.display='block';
            div2.style.display='none';
        }
        function CloseWin()
        {
            var oWindow = GetRadWindow();
             oWindow.close();
        }
//        function ClearFormLookup(id) {
//      
//            var lookup=window[id+"_"+id+"_listlookup"];
//            lookup.InputDomElement.value = "";
//        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
         <link href="<%=themepath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%=themepath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
        <div>
            <asp:Panel ID="PanelFormsLookup" runat="server">
            </asp:Panel>
            <table width="660" border="0" cellpadding="3" cellspacing="3">
                <tr>
                    <td align="right" class="lefttdbg" height="24">
                        <input type="button" id="btnCancel" class="inputsecondarybutton" value="<%= strCancelText%>"
                            onclick="CloseWin();" />&nbsp;
                        <asp:Button ID="btnContinue" runat="server" CssClass="inputbutton" OnClick="btnContinue_Click" />
                        
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                            <tr>
                                <td >
                                    <div id="ownedonly" style="display: none;">
                                    <asp:Image runat="server" src="<%$ ReplaceTemplateExpn:Repository/ListControl/Images/icon-warnings.png%>" align="absmiddle" alt="Note" />
                                        
                                      <span class="note"><%=strNoteOwned %></span>
                                    </div>
                                    <div id="allow" style="display: none;">
                                        <img src="Images/icon-warnings.png" align="absmiddle" alt="Note" />
                                       <span class="note"><%=strNoteAllow %></span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
