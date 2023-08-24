<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.NewListLink" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html >
<head runat="server">
    <title><%=strTitle%></title>
   <style type="text/css">
       html,body {height:100%;}
   </style>    
</head>
<script language="javascript" type="text/javascript">
        function GetRadWindow(){
          var oWindow = null;

          if (window.radWindow) 
	        oWindow = window.radWindow;
          else if (window.frameElement.radWindow) 
	        oWindow = window.frameElement.radWindow;
        	
          return oWindow;
        }

        function closeWin(message) {
            var oWindow = GetRadWindow();
            resizefunction();
            se.ui.messageDialog.showAlert('<%=GetLangSpecText("ec_newlistlink_tilte") %>', message, function () { oWindow.close(); });
        }

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
            parentdiv.style.height =  parentdivheight ;
            try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight +'px' ;}catch(e){}
           // bodydiv.style.width =  '100px';
            bodydiv.style.width =  parentdiv.clientWidth +'px';
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
        function Validate() {
            var title = document.getElementById('txtName');
            if (title.value == '') {
                resizefunction();
                se.ui.messageDialog.showError('<%=GetLangSpecText("ec_newlistlink_tilte") %>', '<%=GetLangSpecText("ec_nav_formlink_title_reqd") %>');
                return false;
            }
            return true;
        }
        function ShowMsg(message) {
            resizefunction();
            se.ui.messageDialog.showError('<%=GetLangSpecText("ec_newlistlink_tilte") %>', message);
            return false;
        }
</script>


<body style="margin: 0; overflow: hidden;">
<script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
<script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
<script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=ThemePath %>CommonUXControls/StyleSheet/se.ui.min.css" />    
    <link href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
       <link href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
<script>
    se.ui.messageDialog.setGlobalOptions({
        localization: {
            closeButtonCaption: '<%=GetLangSpecText("se_ui_messagedialog_close_caption") %>',
            okButtonCaption: '<%=GetLangSpecText("se_ui_messagedialog_ok_caption") %>',
            cancelButtonCaption: '<%=GetLangSpecText("se_ui_messagedialog_cancel_caption") %>',
            showDetailsCaption: '<%=GetLangSpecText("se_ui_messagedialog_showdetails_caption") %>',
            hideDetailsCaption: '<%=GetLangSpecText("se_ui_messagedialog_hidedetails_caption") %>',
        }
    });
</script>

    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <link  rel="stylesheet" href="<%=ThemePath%>Common/StyleSheet/Global.css" type="text/css" />
        <div id="divparent">
            <asp:Panel ID="Panel1" runat="server">
                <div id="divheader">
                <table width="98%" border="0" cellspacing="1" cellpadding="5" align="center">
                    <tr style="height: 40px">
                        <td colspan="2" class="pagetitle">
                        <img src="<%=ThemePath%>Repository/Site/images/add-list-link.png" align="absmiddle" />&nbsp;&nbsp; 
                            <%=strHeader %>
                        </td>
                    </tr>
                    <tr><td class="description"><%=strDesc %></td></tr>
                </table>
                </div>
                <div id="divbody">
                    <table width="99%" align="center" border="0" cellpadding="10" cellspacing="1" class="tablebg">
                        <tr>
                            <td class="lefttdbg" valign="top" style="width: 45%">
                                <span class="subtitle">
                                    <%=GetLangSpecText("ec_newlistlink_name") %> <span style=" color:Red"> *</span>
                                    </span>
                                <br />
                                <span class="description">
                                <%=GetLangSpecText("ec_newlistlink_name_desc") %>
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <asp:TextBox ID="txtName" CssClass="inputtext" runat="server" Width="80%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" valign="top" style="width: 45%">
                                <span class="subtitle">
                                    <%=GetLangSpecText("ec_newlistlink_desc") %>
                                    </span>
                                <br />
                                <span class="description">
                                <%=GetLangSpecText("ec_newlistlink_desc_desc") %>
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <asp:TextBox ID="txtDesc" CssClass="inputtext" runat="server" TextMode="multiLine" Width="80%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" valign="top" style="width: 45%">
                                <span class="subtitle">
                                    <%=GetLangSpecText("ec_newlistlink_list_name") %> <span style=" color:Red"> *</span>
                                    </span><br />
                                    <span class="description">
                                <%=GetLangSpecText("ec_newlistlink_list_name_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <asp:PlaceHolder ID="phlist" runat="server"></asp:PlaceHolder>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" valign="top" style="width: 45%">
                                <span class="subtitle">
                                    <%=GetLangSpecText("ec_newlistlink_image") %>
                                    </span>
                                <br />
                                <span class="description">
                                <%=GetLangSpecText("ec_newlistlink_image_desc") %>
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <asp:TextBox ID="txtImage" CssClass="inputtext" runat="server" Width="80%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" valign="top" style="width: 45%">
                               <span class="subtitle">
                                    <%=GetLangSpecText("ec_newnavigation_menuposition")%>
                                </span>
                                <br />
                                <span class="description">
                                    <%=GetLangSpecText("ec_newnavigation_menuposition_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <asp:TextBox ID="txtMenuOrder" CssClass="inputtext" runat="server" Width="80%" MaxLength="9"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divfooter">
                    <table width="100%" border="0" cellspacing="1" cellpadding="10" align="center">
                        <tr>
                            <td colspan="2" align="right">
                                <asp:Button ID="btnsave" CssClass="inputbutton"  runat="server" OnClientClick="javascript:return Validate()" OnClick="btnsave_Click" />&nbsp;
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
