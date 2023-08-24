<%@ Page Language="C#"  AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.Forward" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html style="height:100%">
<head id="Head1" runat="server">
    <title><%=GetLangSpecText("PageTitle")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
</head>

<script type="text/javascript" >
    function selectUsers()
    {
        var oWindow;
        var urlParams = "users=" + encodeURIComponent(document.getElementById('usrNameHidden').value) + "&singleselection=1";
        var sharepointPath = '<%=csspath%>';
        if (sharepointPath.indexOf('_layouts') > -1) {
            oWindow = parent.window.radopen("../BPMUITemplates/Default/Repository/Site/UserLookup.aspx?" + urlParams, null);
        }
        else {
            oWindow = parent.window.radopen("UserLookup.aspx?" + urlParams, null);
        }

        oWindow.setSize(590, 480);
        oWindow.set_modal(true);
        oWindow.set_title('Select Users');
        oWindow.setActive(true);

        oWindow.add_beforeClose(onClientBeforeCloseUserLookup);

        function onClientBeforeCloseUserLookup(sender, args)
        {
            var returnValue = args.get_argument();

            if (returnValue !== null && returnValue !== undefined)
            {
                var oArea = document.getElementById('usrName');
                var ids;
                var names = '';
                var useridstring = '';

                if (returnValue.indexOf('@!@') != -1)
                {
                    se.ui.messageDialog.showError('<%=GetLangSpecText("PageTitle")%>', '<%=GetLangSpecText("MWI_SelectSingleUser")%>');
                    args.set_cancel(true);
                    return false;
                }

                if (returnValue.lastIndexOf("^") != -1)
                {
                    var usernamestring = returnValue.substring(0, returnValue.lastIndexOf("^"));
                    useridstring = returnValue.substring(returnValue.lastIndexOf("^") + 1);
                    names = usernamestring;
                }

                oArea.value = names;
                var oArea1 = document.getElementById('usrNameHidden');
                oArea1.value = useridstring;
            }

            sender.remove_beforeClose(onClientBeforeCloseUserLookup);
        }
    }
    
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
        function Validate()
        {
           var UserName = document.getElementById('usrName').value;
           if(UserName =='')
           {
             se.ui.messageDialog.showError('<%=GetLangSpecText("PageTitle")%>', '<%=GetLangSpecText("MWI_SelectAUser")%>');
             return false;
           }
           return true;
             
        }
        
         // Making header & footer constant
        AddEventHandler(window,'resize', resizefunction);
        AddEventHandler(window,'load', resizefunction);
            
        function AddEventHandler(elementObject, eventName, functionObject)
        {
            if(document.addEventListener)
                elementObject.addEventListener(eventName, functionObject, false);
            else
                if(document.attachEvent)
                    elementObject.attachEvent("on" + eventName, functionObject);
        }
        function resizefunction()
        {   
            var bodydiv = document.getElementById('divbody');
            var headerdiv = document.getElementById('divheader');
            var footerdiv = document.getElementById('divfooter');
            var parentdiv = document.getElementById('divparent');
            if (parentdiv.offsetParent==document.body)
                document.body.style.height = '100%';

            var parentdivheight = parentdiv.offsetParent.offsetHeight;
           // parentdiv.style.height =  parentdivheight ;
           // try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight ;}catch(e){}
            bodydiv.style.width =  '100%';
            bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
//            alert(bodydiv.style.height +'   ' +parentdivheight+ '   ' +headerdiv.offsetHeight+ '   ' + footerdiv.offsetHeight);

        }
        function SetValues()
        {
            var WFName = document.getElementById('hdnWFName');
            var WID = document.getElementById('hdnWId');
            var EID = document.getElementById('hdnEID');
            var EDtsId = document.getElementById('hndEDtsId');
            var sharepointPath = '<%=csspath%>';
            if (sharepointPath.indexOf('_layouts') > -1) {
                try {
                    var workItemsWindow = parent.parent.document.getElementById('ctl00_PlaceHolderMain_WIframe').contentWindow.document;
                }
                catch (e) {
                }

                WFName.value = workItemsWindow.getElementById('hdnWFNames').value;
                EID.value = workItemsWindow.getElementById('hdnExID').value;
                EDtsId.value = workItemsWindow.getElementById('hdnEDtlsIds').value;
                WID.value = workItemsWindow.getElementById('hdnWorkItemIds').value;
            }
            else {
                WFName.value = window.parent.document.getElementById('hdnWFNames').value;
                WID.value = window.parent.document.getElementById('hdnWorkItemIds').value;
                EID.value = window.parent.document.getElementById('hdnExID').value;
                EDtsId.value = window.parent.document.getElementById('hdnEDtlsIds').value;
            }
        }
      
        
</script>
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
      <link rel="stylesheet" type="text/css" href="<%=csspath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
     <link rel="stylesheet" type="text/css" href="<%=csspath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <div id="divparent" style="height:100%">
    <form id="form1" runat="server" style="height:100%"><link href="<%=csspath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
     <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
     <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <asp:HiddenField ID="hdnWFName" runat="server" />
    <asp:HiddenField ID="hdnWId" runat="server" />
    <asp:HiddenField ID="hdnEID" runat = "server" />
    <asp:HiddenField ID="hndEDtsId" runat="server" />
    <div id="divheader" style="height:15%;padding-bottom:15px;">
        <table style="width:98%;border-width:0;margin:auto;border-spacing:1px;border-collapse:separate" >
            <tr>
                <td id="Td3" colspan="2" class="subtitle">
                    <img src="<%=csspath%>Repository/Site/images/Forward-WorkItems-right.png" align="absmiddle" />&nbsp;&nbsp;
                    <%= GetLangSpecText("Select_User")%>
                </td>

             </tr>
            
        </table>
       </div>
    <div id="divbody" style="height:70%">
        <table id="TMain" style="width:98%;margin:auto;border-width:0;border-spacing:1px;border-collapse:separate"  class="tablebg">
            <tr>
                <td class="lefttdbg" style="width: 45%;padding:7px;vertical-align:top">
                    <span class="description"><%= GetLangSpecText("ForwardDesc")%></span> 
                    <br />
                </td>
                <td class="righttdbg" style="width: 55%">
                     <asp:TextBox ID="usrName" runat="server" CssClass="inputtext" onclick="this.blur()" Width="90%"></asp:TextBox>
                     <input id="Button6" class="userlookup" onclick="selectUsers();" type="button" value=".." name="SiteExplorer" align="absmiddle" alt="User Lookup" />
                      <asp:HiddenField ID="usrNameHidden" EnableViewState="true" runat="server" /> 
                </td>
            </tr>
        </table>
      </div>
    <div id="divfooter" style="height:10%">
                <table style="width:100%;border-width:0"  >
                    <tr>
                    <td style="padding:10px">
                            <img src="<%=csspath%>Repository/Site/images/icon-warnings.png" align="absmiddle" alt="Note" />
                            <span class="note"><%= GetLangSpecText("UserLookupNote")%></span> 
                        </td>
                        <td colspan="2" style="text-align:right">
                             <asp:Button ID="btnForward" runat="server" CssClass="inputbutton" OnClientClick="javascript:return Validate()" OnClick="btnForward_Click" />  
                        </td>
                    </tr>
                </table>
                
           </div>
           <div style="display: none">
              <input type="button" id="SearchUser" value="Open Window" />
              <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" runat="server" Behaviors="Close"  RenderMode="Classic" VisibleStatusbar="false">
                <Windows>
                    <telerik:RadWindow ID="RadWindow1" runat="server" OpenerElementId="SearchUser" NavigateUrl="UserLookup.aspx" Left="" Title="User Lookup" Top="">
                    </telerik:RadWindow>
                </Windows>
               </telerik:RadWindowManager>           
           </div>
    </form>
    </div>
</body>
</html>

