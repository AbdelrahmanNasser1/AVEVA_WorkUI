<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.KillWorkItem" %>
 <link href="<%=csspath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
 <!DOCTYPE html >
<html style="height:100%">
<head runat="server">
    <title><%=GetLangSpecText("KillWorkItem")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script language="javascript">
        function GetRadWindow(){
          var oWindow = null;

          if (window.radWindow) 
	        oWindow = window.radWindow;
          else if (window.frameElement.radWindow) 
	        oWindow = window.frameElement.radWindow;
        	
          return oWindow;
        }           

        function closeWin(){
         var oWindow = GetRadWindow();             
        
         if(parent.parent.document.getElementById('ctl00_Cont_WIframe')!=null)
             parent.parent.document.getElementById('ctl00_Cont_WIframe').contentWindow.RefreshGrid();
         else
            parent.parent.document.getElementById('ctl00_PlaceHolderMain_WIframe').contentWindow.RefreshGrid();
            
             oWindow.close();
        }
        function focusonno()
        {
            try
            {
            var userid = document.getElementById('btnNo');
            userid.focus();
            }
            catch(e)
            {}
        }
        function SetValues()
        {
             var WFName = document.getElementById('hdnWF');
             var ExecID = document.getElementById('hdnEID');
             var ExecDtlsID = document.getElementById('hdnEDID');
             var sharepointPath = '<%=csspath%>';
             if (sharepointPath.indexOf('_layouts') > -1) {
                 try {
                     var workItemsWindow = parent.parent.document.getElementById('ctl00_PlaceHolderMain_WIframe').contentWindow.document;
                 }
                 catch (e) {
                 }

                 WFName.value = workItemsWindow.getElementById('hdnWFNames').value;
                 ExecID.value = workItemsWindow.getElementById('hdnExID').value;
                 ExecDtlsID.value = workItemsWindow.getElementById('hdnEDtlsIds').value;
                 if (document.getElementById('HValue').value == "") {
                     document.getElementById('HValue').value = "someval";
                     var oWindow = GetRadWindow();
                     oWindow.show();
                     document.getElementById('btnYes').click();
                     oWindow.hide();
                 }
             }
             else {
                 WFName.value = window.parent.document.getElementById('hdnWFNames').value;
                 ExecID.value = window.parent.document.getElementById('hdnExID').value;
                 ExecDtlsID.value = window.parent.document.getElementById('hdnEDtlsIds').value;
                 if (document.getElementById('HValue').value == "") {
                     document.getElementById('HValue').value = "someval";
                     var oWindow = GetRadWindow();
                     oWindow.show();
                     document.getElementById('btnYes').click();
                     oWindow.hide();
                 }
             }
        }
    </script>
</head>
<body style="overflow:hidden;height:100%" onload="SetValues();">
    <script>
     se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_close_caption") %>",
                     okButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_ok_caption") %>",
                     cancelButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_cancel_caption") %>",
                     showDetailsCaption: "<%=GetLangSpecText("se_ui_messagedialog_showdetails_caption") %>",
                     hideDetailsCaption: "<%=GetLangSpecText("se_ui_messagedialog_hidedetails_caption") %>"
                 }
     });
        </script>

     <link href="<%=csspath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />  
    <form id="form1" runat="server" style="height:100%">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <asp:HiddenField ID="hdnEID" runat="server" />
        <asp:HiddenField ID="hdnEDID" runat="server" />
        <asp:HiddenField ID="hdnWF" runat="server" />
        <asp:HiddenField ID="HValue" runat="server" />
        <div style="visibility:hidden">
        <table style="width:100%;border-width:0" >
            <tr>
              <td class="bodytext" align="center">
                    <br />
                    <img src="<%=csspath%>Repository/Site/images/Forward-WorkItems-kill.png" style="vertical-align:middle" />&nbsp;&nbsp; 
                        <br /><br />
                </td>
            </tr>
            <tr style="display:none">
                <td class="description" align="center" >
                   <asp:Label ID="lblMsg" runat="server" Text="" Visible="false"></asp:Label>  
                </td>
            </tr>
            <tr align="center" >
                <td class="bodytext" align="center"><br>
                    <table>
                        <tr>
                            <td>
                                <input type="button" id="btnNo" class="inputsecondarybutton" value="<%=GetLangSpecText("kwi_no_btn") %>"  onclick="closeWin()" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnYes" CssClass="inputbutton" runat="server" Visible="true" OnClick="btnYes_Click" />
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
