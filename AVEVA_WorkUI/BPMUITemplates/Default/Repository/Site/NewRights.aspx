<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.NewRights" %>
<link href="<%=cssPath%>/Global.css" rel="stylesheet" type="text/css" />

<html>
<head>
    <title><%=_ResManager.GlobalResourceSet.GetString("ec_rights_new_title") %></title>

    <script type="text/javascript" language="javascript">
        function GetRadWindow()
        {
            var oWindow = null;
             oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function closeWindow(message) {
            resizefunction();
            var oWindow = GetRadWindow();
            se.ui.messageDialog.showAlert('<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_securityright_new") %>', message, function () { oWindow.close(); });
        }
        
        function showErrorMessage(message)
        {
            resizefunction(); 
            se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_securityright_new") %>', message);
        }

    </script>

    <script type="text/javascript" language="javascript">
        // It will not display Right and Follower Specific Rights
        function displaynone()
        {
            document.getElementById('ValueType').style.display='none';
            document.getElementById('IsApplicableToChild').style.display='none';
            document.getElementById('ChildValueType').style.display='none';
            document.getElementById('Rights').style.display='none';
        }
        // It will display both Rights as well as Follower Specific Rights
        function displaybothrights()
        {
            var rdbtn = document.getElementsByName("rdoIsApplicableToChild");
            if (navigator.appName == 'Netscape')
            {
                document.getElementById('ValueType').style.display='table-row';
                document.getElementById('IsApplicableToChild').style.display='table-row';
               if (rdbtn[0].checked)
                    document.getElementById('ChildValueType').style.display='table-row';
                else
                    document.getElementById('ChildValueType').style.display='none';
                
                var scope = document.getElementById('cboRightsLevel').value;
                if(scope.indexOf('ListSpecific')==-1)
                {
                    document.getElementById('Rights').style.display='none';
                }
                else
                {
                     document.getElementById('Rights').style.display='table-row';
                     document.getElementById('trEmpty').style.display='none';
                }
            }
            else
            {
                document.getElementById('ValueType').style.display='block';
                document.getElementById('IsApplicableToChild').style.display='block';
                if (rdbtn[0].checked)
                    document.getElementById('ChildValueType').style.display='block';
                else
                    document.getElementById('ChildValueType').style.display='none';
                
                var scope = document.getElementById('cboRightsLevel').value;
                if(scope.indexOf('ListSpecific')==-1)
                {
                    document.getElementById('Rights').style.display='none';
                }
                else
                {
                     document.getElementById('Rights').style.display='block';
                     document.getElementById('trEmpty').style.display='none';
                }
            }
           
            document.getElementById('tdNote').style.display = 'block';
        }
        // It will display only Rights
        function displayonlyrights()
        {
            if(navigator.userAgent.indexOf("MSIE")==-1)
            {
                document.getElementById('ValueType').style.display='table-row';
                document.getElementById('IsApplicableToChild').style.display='none';
                document.getElementById('ChildValueType').style.display='none';
                document.getElementById('Rights').style.display='none';
            }
            else
            {
                document.getElementById('ValueType').style.display='block';
                document.getElementById('IsApplicableToChild').style.display='none';
                document.getElementById('ChildValueType').style.display='none';
                document.getElementById('Rights').style.display='none';
            }
        }
        // It will display only Follower Specific Rights
        function displayonlyfollowerrights()
        {
            var rdbtn = document.getElementsByName("rdoIsApplicableToChild");
            if (navigator.userAgent.indexOf("MSIE") == -1)
            {
                document.getElementById('ValueType').style.display='none';
                document.getElementById('IsApplicableToChild').style.display='table-row';
             
                if (rdbtn[0].checked)
                document.getElementById('ChildValueType').style.display = 'table-row';
                else
                    document.getElementById('ChildValueType').style.display='none';
            }
            else
            {
                 document.getElementById('ValueType').style.display='none';
                document.getElementById('IsApplicableToChild').style.display='block';
             
                if (rdbtn[0].checked)
                    document.getElementById('ChildValueType').style.display='block';
                else
                    document.getElementById('ChildValueType').style.display='none';
            }
        }
        function showFollower()
        {
            if(navigator.userAgent.indexOf("MSIE")==-1)
                document.getElementById('ChildValueType').style.display='table-row';
            else
                document.getElementById('ChildValueType').style.display='block';
                
            
        }
        function validate()
        {
            var rdbtn = document.getElementsByName("rdoIsApplicableToChild");
            var defaultValue = "--Select--";
            if (document.getElementById('txtRightsName').value == "")
            {
                se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_securityright_new") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_rights_edit_validate_rightname") %>');
                document.getElementById('hdnvalidate').value = "true";
                return;
            }
            if (document.getElementById('txtRightsCode').value == "")
            {
                se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_securityright_new") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_rights_edit_validate_rightcode") %>');
                document.getElementById('hdnvalidate').value = "true";
                
                return;
            }
            if (document.getElementById('cboRightsLevel').value == defaultValue || document.getElementById('cboRightsLevel').value == 0)
            {
                se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_securityright_new") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_rights_edit_validate_scope") %>');
                document.getElementById('hdnvalidate').value = "true";
                return;
            }
            // If Follower specific Rights only are allowed then it should be commented, it should not be validated
            if (document.getElementById('cboType').value == defaultValue || document.getElementById('cboType').value == 0)
            {
                se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_securityright_new") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_rights_edit_validate_type") %>');
                document.getElementById('hdnvalidate').value = "true";
                return;
            }

          
            if (rdbtn[0].checked)
            {
                if (document.getElementById('cboChildValueType').value == defaultValue || document.getElementById('cboChildValueType').value == 0)
                {
                    se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_securityright_new") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_rights_edit_validate_followertype") %>');
                    document.getElementById('hdnvalidate').value = "true";
                    return;
                }
            }// If JS has contains function I should implement it.
            if (document.getElementById('cboRightsLevel').value.indexOf('ListSpecific') != -1)// == 'List Specific' || document.getElementById('cboRightsLevel').value == 4)
            {
                var i, count = document.getElementById('chkRights').rows.length;
                // CheckBoxList is rendered in form html table, it is to get the table object
                var tableBody = document.getElementById('<%=chkRights.ClientID%>').childNodes[0]; 
                var isAnyListChecked = false;
                for(i = 0; i < count; i++)
                {
                //alert(tableBody.childNodes[i]);
                    // it is to get the currentTd 
                    //var currentTd = tableBody.childNodes[i].childNodes[0]; // In FireFox causing problem
                   // var currentTd = document.getElementById('chkRights_'+i)
                    // it is to get the current checkbox
                    var listControl = document.getElementById('chkRights_'+i); //currentTd.childNodes[0]; // In FireFox causing problem

                    if ( listControl.checked )
                    {
                        isAnyListChecked = true;
                        break;
                    }
                }
                if(isAnyListChecked == false)
                {
                    se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_securityright_new") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_rights_edit_validate_lists") %>');
                    document.getElementById('hdnvalidate').value = "true";
                    return;
                }
            }
            document.getElementById('hdnvalidate').value = "false";
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
            parentdiv.style.height =  parentdivheight ;
            try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight ;}catch(e){}//headerdiv.offsetHeight -
            bodydiv.style.width =  '100px';
            bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
        
    </script>

</head>
<body id="Body" scroll="no" style="overflow: hidden;">
     <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=ThemeURL %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", 
                cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" 
            }
        });
    </script>
    <div id="divparent">
        <form id="form1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <div id="divheader">
                <table width="98%" border="0" cellspacing="1" cellpadding="5" align="center">
                    <tr>
                        <td colspan="2" class="pagetitle">
                            <img src="<%=ThemeURL%>Repository/Site/images/new-security-popup.png" align="absmiddle" />&nbsp;&nbsp;
                            <%= _ResManager.GlobalResourceSet.GetString("ec_rights_title")%>
                        </td>
                    </tr>
                    <tr>
                        <td class="description">
                            &nbsp;&nbsp;
                            <%= _ResManager.GlobalResourceSet.GetString("ec_rights_title_desc")%>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divbody" style="overflow: hidden;">
                <table id="TMain" width="98%" align="center" border="0" cellpadding="7" cellspacing="1"
                    height="100%" class="tablebg">
                    <tr style="height: 30px">
                        <td class="lefttdbg" valign="top" style="width: 45%">
                            <span class="subtitle">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_name")%>
                            </span>
                            <br />
                            <span class="description">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_neme_desc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 55%">
                            <asp:TextBox ID="txtRightsName" CssClass="inputtext" runat="server" Width="200px" />
                        </td>
                    </tr>
                    <tr style="height: 30px">
                        <td class="lefttdbg" valign="top" style="width: 45%">
                            <span class="subtitle">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_code")%>
                            </span>
                            <br />
                            <span class="description">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_code_desc")%>
                                <br />
                                <%= _ResManager.GlobalResourceSet.GetString("ed_rights_code_eg")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 55%">
                            <asp:TextBox ID="txtRightsCode" CssClass="inputtext" runat="server" Width="200px" />
                        </td>
                    </tr>
                    <tr style="height: 30px">
                        <td class="lefttdbg" valign="top" style="width: 45%">
                            <span class="subtitle">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_scope")%>
                            </span>
                            <br />
                            <span class="description">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_scope_desc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 55%">
                            <asp:DropDownList ID="cboRightsLevel" runat="server" OnSelectedIndexChanged="cboRightsLevel_SelectedIndexChanged"
                                AutoPostBack="true" CssClass="inputselect" Width="60%">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="ValueType" style="height: 30px">
                        <td class="lefttdbg" valign="top" style="width: 45%">
                            <span class="subtitle">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_parentvalue")%>
                            </span>
                            <br />
                            <span class="description">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_parentvalue_desc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 55%">
                            <asp:DropDownList ID="cboType" runat="server" CssClass="inputselect" Width="90%">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="IsApplicableToChild" style="height: 30px">
                        <td class="lefttdbg" valign="top" style="width: 45%">
                            <span class="subtitle">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_applicabletochild")%>
                            </span>
                            <br />
                            <span class="description"></span>
                        </td>
                        <td class="righttdbg" style="width: 55%">
                            <asp:RadioButtonList ID="rdoIsApplicableToChild" runat="server" RepeatDirection="Horizontal"
                                CssClass="inputradio">
                                <asp:ListItem Text="True" onclick="showFollower();">Yes</asp:ListItem>
                                <asp:ListItem Selected="true" Text="False" onclick="document.getElementById('ChildValueType').style.display='none';">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr id='ChildValueType' style="height: 30px">
                        <td class="lefttdbg" valign="top" style="width: 45%">
                            <span class="subtitle">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_childvalue")%>
                            </span>
                            <br />
                            <span class="description">(<%= _ResManager.GlobalResourceSet.GetString("ec_rights_childvalue_description")%>)
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 55%">
                            <asp:DropDownList ID="cboChildValueType" CssClass="inputselect" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="trEmpty" style="height: 100%" class="lefttdbg">
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr id="Rights" style="height: 100%">
                        <td class="lefttdbg" valign="top" style="width: 45%">
                            <span class="subtitle">
                                <asp:Label ID="lblListNames" runat="server" CssClass="subtitle"> <%= _ResManager.GlobalResourceSet.GetString("ec_rights_listnames")%></asp:Label>
                            </span>
                            <br />
                            <span class="description">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_listnamesdescription")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 55%">
                            <div id="divLists" style="overflow: auto; height: 100%">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td class="righttdbg">
                                            <asp:CheckBoxList ID="chkRights" name="chkRights" runat="server" CellPadding="5"
                                                CellSpacing="0" CssClass="inputcheckbox">
                                            </asp:CheckBoxList>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divfooter">
                <table border="0" cellpadding="10" cellspacing="0" width="100%">
                    <tr>
                        <td id="tdNote" style="display: none">
                            <span class="note">
                                <img src="<%=ThemeURL%>Repository/Site/images/icon-warnings.png" align="absmiddle" />&nbsp;&nbsp;
                                    <%= _ResManager.GlobalResourceSet.GetString("ec_rights_applicabletochild_description")%>
                                </span>
                        </td>
                        <td align="right" colspan="2">
                            <asp:Button ID="btnSaveRights" runat="server" CssClass="inputbutton" OnClientClick="validate()" OnClick="btnSaveRights_Click" />
                        </td>
                    </tr>
                </table>
            </div>
            <asp:HiddenField ID="hdnvalidate" runat="server" Value="false" />
        </form>
    </div>
</body>
</html>
