<%@ Page Language="C#" AutoEventWireup="true" Debug="true" Inherits="Skelta.Forms.Web.Codebehind.SkeltaAttachment" %>

<link rel="stylesheet" type="text/css" href="<%=ThemePath %>SkeltaForms/StyleSheet/Designer.css" />
<link rel="stylesheet" type="text/css" href="<%=ThemePath %>SkeltaForms/StyleSheet/SkeltaForm.css" />
<html>
<head runat="server">
    <title>Attach</title>

    <script type="text/javascript">
        /* This is to Update the File name in the hidden field */
        function UpdateFileToHiddenField() {

            var hiddenValue = document.getElementById('hdnValue');
            var hdnActualPath = document.getElementById('hdnActualPath');
            var fileUploadControl = document.getElementById('fileUpload');
            var txtWebUrl = document.getElementById('txtWebUrl');
            var rblUploadType = document.getElementById('rbUploadType');

            if (hdnActualPath.value == '') {
                if (fileUploadControl != null) {
                    hdnActualPath.value = fileUploadControl.value;
                    hiddenValue.value = fileUploadControl.value;
                }
                else {
                    hdnActualPath.value = txtWebUrl.value;
                    hiddenValue.value = txtWebUrl.value;
                }
            }

            if (fileUploadControl != null) {
                if (hdnActualPath.value != fileUploadControl.value) {                    
                    hiddenValue.value = fileUploadControl.value;
                    hdnActualPath.value = fileUploadControl.value;                  
                }
            }
            else {
                if (hdnActualPath.value != txtWebUrl.value) {
                    hiddenValue.value = fileUploadControl.value;
                    hdnActualPath.value = fileUploadControl.value;                         
                }
            }
        }
        
     function iUploadFrameLoad() 
     {   
        document.getElementById('hdnData').value =  Query("WebId")+","+Query("rname");
        document.getElementById('hdnFileType').value = Query("extns");
        if (document.getElementById('hdnValue').value != '') 
        {
            window.parent.document.getElementById(window.parent._skidmap[Query("HdnID")]).value = document.getElementById('hdnValue').value;
            document.getElementById('hdnValue').value = '';         
            window.parent.document.getElementById(window.parent._skidmap[Query("BtnId")]).click();
        }
        else 
        {
            window.parent.document.getElementById(window.parent._skidmap[Query("HdnID")]).value = '';
        }      
    }
    
    function Query(key)
    {
        var qs=window.location.search.substring(1);
        arr=qs.split('&');
        for(var i=0;i<arr.length;i++)
        {
            param=arr[i].split('=');
            if(param[0]==key)
            {
                return param[1];
            }
            else
            {
                continue;
            }
        }
        return '';        
    }
    function CloseFrame()
    {
        for(var i=0;i< window.parent.dhtmlwindow.tobjects.length ; i++)
        window.parent.dhtmlwindow.tobjects[i].hide();
        window.parent.sf_attachmentClose();      
    }
    </script>

</head>
<body style="overflow:hidden" leftmargin="0px" topmargin="0px" rightmargin="0px" bottommargin="0px" scroll="no" onload="iUploadFrameLoad()">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=ThemePath %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: { 
                closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", 
                cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", 
                hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" 
            }
        });
    </script>
    <form id="frmAttachment" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <table  style="width:100%;" >            
            <tr align="left">
                <td valign="top" align="left" style="font-family: Segoe UI; font-size: 12px;color: #000000">
                    <ul>
                        <li>
                            <%= resManager.GlobalResourceSet.GetString("FormAttachmentHelp1")%>
                        </li>
                        <li>
                            <%= resManager.GlobalResourceSet.GetString("FormAttachmentHelp2")%>
                        </li>
                        <li>
                            <%= resManager.GlobalResourceSet.GetString("FormAttachmentHelp3")%>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td style="padding-left: 15px; margin-bottom:5px;">
                    <table cellpadding="0" cellspacing="0"  >
                        <tr>
                            <td colspan="3" align="left">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="images/attachmentcontrolimage.png" id="attachimg" />
                            </td>
                            <td valign="top" style="padding-left:4px;padding-top:4px;">                            
                                <asp:FileUpload ID="fileUpload" Width="280" CssClass="inputs" runat="server" />
                                <asp:TextBox ID="txtWebUrl" CssClass="inputs" runat="server" Visible="false"></asp:TextBox>
                            </td>
                            <td valign="top">
                                &nbsp;
                                
                            </td>
                            <td  style="text-align:right;padding-bottom:8px;">
                                 <asp:Button ID="btnUpload"  OnClientClick="UpdateFileToHiddenField();"
                                                OnClick="btn_Upload" CssClass="sf-inputsBox" runat="server" />
                                <input type="hidden" id="hdnValue" runat="server" />
                                <input type="hidden" id="hdnData" runat="server" />
                                <input type="hidden" id="hdnActualPath" runat="server" />
                                <input type="hidden" id="hdnFileType" runat="server" />
                        </td>
                           
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                

            </tr>
        </table>
    
    <asp:RadioButtonList ID="rbUploadType" Visible="false" CssClass="sf-attachradio" AutoPostBack="true" RepeatDirection="Horizontal"
                                runat="server">
                                <asp:ListItem Text="Physical path" Selected="True" Value="PhysicalPath">Physical Path</asp:ListItem>
                                <asp:ListItem Text="Web url" Value="WebUrl">Web Url</asp:ListItem>
                            </asp:RadioButtonList>
    </form>
</body>
</html>
