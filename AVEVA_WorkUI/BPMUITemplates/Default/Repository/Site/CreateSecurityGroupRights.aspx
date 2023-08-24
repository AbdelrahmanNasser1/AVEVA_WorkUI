<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.CreateSecurityGroupRights" %>

<%@ Register Src="../RightsControls/RightsMappingGrid.ascx" TagName="RightsMappingGrid"
    TagPrefix="uc2" %>
    
<html>
<head>
    <title>
        <%=_ResManager.GlobalResourceSet.GetString("ec_sg_title") %>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <link href="<%=cssPath%>/Global.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
        function trim(str) {
        a = str.replace(/^\s+/, '');
        return a.replace(/\s+$/, '');
    };
        function Validate()
        {
            document.getElementById('txtSecurityGroup').value = trim(document.getElementById('txtSecurityGroup').value);
            var sgText = document.getElementById('txtSecurityGroup').value;
            if (sgText == "")
            {
                se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_sg_title") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_sg_sgname_required") %>');
                document.getElementById('hdnIsValid').value = false;
            }   
            else
                document.getElementById('hdnIsValid').value = true;
        }
        function displaynone()
        {
           if(document.getElementById('hdnclick').value=='')
            {
                document.getElementById('sgname').style.display='none';
                document.getElementById('sgdescription').style.display='none';
                //document.getElementById('sgrights').style.display='none';tableRights
                document.getElementById('tableRights').style.display='none';
                document.getElementById('sgsave').style.display='none';
//                document.getElementById('divTableHeader').style.display='none';
            }
            else
            {
                hideOptions();
            }
            resizefunction();
        }
        function displaySGroups()
        {
             if(navigator.appName =='Microsoft Internet Explorer')
             {
                document.getElementById('sgroups').style.display ='block';
             }
             else
             {
                document.getElementById('sgroups').style.display ='table-row';
             }
           // document.getElementById('optcontinue').style.display='block';
            displaynone();
        }
        function hideSGroups()
        {
            document.getElementById('sgroups').style.display ='none';
           // document.getElementById('optcontinue').style.display='none';
            displaynone();
        }
        function hideOptions()
        {
            if(navigator.appName =='Microsoft Internet Explorer')
            {
                document.getElementById('sgname').style.display='block';
                document.getElementById('sgdescription').style.display='block';
                document.getElementById('sgsave').style.display='block';
//                document.getElementById('divTableHeader').style.display='block';
                document.getElementById('options').style.display ='none';
            }
            else
            {
                document.getElementById('sgname').style.display='table-row';
                document.getElementById('sgdescription').style.display='table-row';
                document.getElementById('sgsave').style.display='table-row';
//                document.getElementById('divTableHeader').style.display='table-row';
                document.getElementById('options').style.display ='none'; 
            }
        }
        function displaycontinue()
        {
             if(navigator.appName =='Microsoft Internet Explorer')
             {
                document.getElementById('optcontinue').style.display='block';
             }
             else
             {
                document.getElementById('optcontinue').style.display='table-row';
             }
        }
        

       
    </script>

    <script type="text/javascript" language="javascript">
        function GetRadWindow()
        {
            var oWindow = null;
             oWindow = window.frameElement.radWindow;
            return oWindow;
        } 

        function closeWindow()
        {
          var oWindow = GetRadWindow();
          se.ui.messageDialog.showAlert('<%=_ResManager.GlobalResourceSet.GetString("ec_sg_title") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_sg_create_success") %>', function () { oWindow.close(); });
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
            if(bodydiv == null)
            return;
            try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight;}catch(e){}
            bodydiv.style.width =  '100px';
            bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
        
        function validateCopy()
        {
            try
            {   
                var rdo_checked;

                for (var i=0; i<document.form1.rblChoice.length; i++)  { 
                    if (document.form1.rblChoice[i].checked)  {
                        rdo_checked = document.form1.rblChoice[i].value
                    } 
                } 
                
                var sgvalue = document.getElementById('ddlSG').value;
                if(rdo_checked == 'Copy' && sgvalue == 0) {
                    se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_sg_title") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_newsecuritygroup_select_SG_desc") %>');
                    return false;
                }
                else
                    return true;
            }
            catch(e)
            {
                return true;
            }
        }
        function SecurityGroupLength(source, args) {
            var element = document.getElementById('<%=txtSecurityGroup.ClientID %>');
            if (element.value.length < 251) // you can also write args.Value
            {
                args.IsValid = true; 
            } else {
                args.IsValid = false;
                se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_sg_title") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_newsecuritygroup_length_validate") %>');
            }
        }
    </script>

</head>
<body scroll="no" onload="displaynone();" style="overflow:hidden;">
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=ThemeURL %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <div id="divparent" style="height: 100%;">
        <form id="form1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <div id="divheader" style="vertical-align: top; width: 98%">
                <asp:HiddenField ID="hdnclick" runat="server" />
                <table width="100%" border="0" cellspacing="0" cellpadding="5">
                    <tr>
                        <td colspan="2" class="pagetitle ">
                            &nbsp;&nbsp;
                            <img src="<%=ThemeURL%>Repository/Site/images/new-security-group.png" align="absmiddle" />&nbsp;&nbsp;
                            <%= _ResManager.GlobalResourceSet.GetString("ec_sg_header")%>
                        </td>
                    </tr>
                    <tr id="options">
                        <td align="center">
                            <table width="98%" border="0" cellspacing="1" cellpadding="5" align="center">
                                <tr>
                                    <td>
                                        <span class="description">
                                            <%=_ResManager.GlobalResourceSet.GetString("ec_newsecuritygroup_help")%>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                            <table width="95%" border="0" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
                                <tr style="width: 30px">
                                    <td align="left" class="lefttdbg" valign="top" style="width: 60%">
                                        <span class="subtitle">
                                            <%=_ResManager.GlobalResourceSet.GetString("ec_newsecuritygroup_select_option")%>
                                        </span>
                                        <br />
                                        <br />
                                        <span class="description">
                                            <%=_ResManager.GlobalResourceSet.GetString("ec_newsecuritygroup_select_option_desc")%>
                                        </span>
                                    </td>
                                    <td align="left" class="righttdbg" style="width: 40%">
                                        <asp:RadioButtonList ID="rblChoice" CssClass="inputradio" runat="server">
                                            <asp:ListItem Value="New" Selected="true" onclick="hideSGroups();"></asp:ListItem>
                                            <asp:ListItem Value="Copy" onclick="displaySGroups();"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr id="sgroups" style="display: none;">
                                    <td align="left" valign="top" class="lefttdbg" style="width: 27%">
                                        <span class="subtitle">
                                            <%=_ResManager.GlobalResourceSet.GetString("ec_newsecuritygroup_select_SG")%>
                                        </span>
                                        <br />
                                        <span class="description">
                                            <%=_ResManager.GlobalResourceSet.GetString("ec_newsecuritygroup_select_SG_desc")%>
                                        </span>
                                    </td>
                                    <td align="left" class="righttdbg" style="width: 55%">
                                        <asp:DropDownList ID="ddlSG" CssClass="inputselect" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td1" class="lefttdbg" colspan="2">
                                        <table border="0" cellpadding="5" cellspacing="0">
                                            <tr>
                                                <td style="width: 10;" valign="top">
                                                    <span class="note">
                                                        <img src="<%=ThemeURL%>Repository/Site/images/icon-warnings.png" alt="plese note"
                                                            align="absmiddle" /></span></td>
                                                <td class="lefttdbg">
                                                    <span class="note">
                                                        <%= _ResManager.GlobalResourceSet.GetString("ec_newsecuritygroup_note")%>
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top" bgcolor="#FFFFFF" class="leftnav" colspan="2">
                                        <asp:Button ID="btnContinue" CssClass="inputbutton" OnClientClick="return validateCopy();" OnClick="btnContinue_Click"
                                            runat="server"  />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="sgdescription" style="width: 30px">
                        <td>
                            <table width="98%" border="0" cellspacing="1" cellpadding="0" align="center">
                                <tr>
                                    <td valign="top"  class="description" style="width: 91%"
                                        colspan="2">
                                        &nbsp;&nbsp;
                                        <%=_ResManager.GlobalResourceSet.GetString("ec_sg_header_description")%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="sgname">
                        <td align="center">
                            <table width="94%" border="0" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
                                <tr style="width: 30px">
                                    <td class="lefttdbg" valign="top" style="width: 45%">
                                        <span class="subtitle">
                                            <%=_ResManager.GlobalResourceSet.GetString("ec_sg_sgTitle") %>
                                        </span>
                                        <br />
                                        <span class="description">
                                            <%=_ResManager.GlobalResourceSet.GetString("ec_sg_sg_title_desc")%>
                                        </span>
                                    </td>
                                    <td class="righttdbg" style="width: 55%">
                                        <asp:TextBox ID="txtSecurityGroup" CssClass="inputtext" runat="server" Width="300px"></asp:TextBox><br />
                                        <asp:CustomValidator ControlToValidate="txtSecurityGroup" class="description" runat="server" ValidateEmptyText="True" ClientValidationFunction="SecurityGroupLength" SetFocusOnError="true" ></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lefttdbg" valign="top" style="width: 45%">
                                        <span class="subtitle">
                                            <%=_ResManager.GlobalResourceSet.GetString("ec_sg_description") %>
                                        </span>
                                        <br />
                                        <span class="description">
                                            <%=_ResManager.GlobalResourceSet.GetString("ec_sg_desc_description")%>
                                        </span>
                                    </td>
                                    <td class="righttdbg" style="width: 55%">
                                        <textarea id="txtDescription" rows="3" cols="30" runat="server" class="inputtextarea" style="width: 300px"></textarea>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divbody" style="vertical-align: top;">
                <table width="100%" width="99%" border="0" cellspacing="0" cellpadding="5">
                    <tr>
                        <td>
                            <table id="tableRights" width="96%" align="center" border="0" cellspacing="1" cellpadding="3">
                                <tr id="sgrights" align="center">
                                    <td align="center">
                                        <uc2:RightsMappingGrid ID="RightsMappingGrid1" Visible="false" runat="server"></uc2:RightsMappingGrid>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divfooter">
                <table border="0" cellpadding="10" cellspacing="0" width="100%" align="center">
                    <tr id="sgsave">
                        <td align="right" colspan="2">
                            <asp:Button ID="Button1" CssClass="inputbutton" runat="server" OnClientClick="Validate();"
                                OnClick="Button1_Click"  />
                            <asp:HiddenField ID="hdnRights" runat="server" Value="" />
                            <asp:HiddenField ID="hdnIsValid" runat="server" Value="False" />
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>
