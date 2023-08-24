<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewRights" %>
<link href="<%=cssPath%>/Global.css" rel="stylesheet" type="text/css" />

<!DOCTYPE HTML>
<html>
<head>
    <title><%= _ResManager.GlobalResourceSet.GetString("ed_rights_view_title")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style>
        html,body{height:100%;}
    </style>
    <script type="text/javascript" >
        function GetRadWindow()
        {
            var oWindow = null;
             oWindow = window.frameElement.radWindow;
            return oWindow;
        } 
        function closeWindow()
        {
          var oWindow = GetRadWindow();
          oWindow.close();
        }
   
        
        function DisplayFollower()
        {
            
            if (document.forms[0].rdoIsApplicableToChild[0].checked)
            { 
                if(navigator.appName!='Microsoft Internet Explorer')
                {
                    document.getElementById('ChildValueType').style.display='table-row';
                }
                else
                {
                    document.getElementById('ChildValueType').style.display='block';
                }
                //document.getElementById('tdNote').style.display = 'block';
            }
        }  
        
        function ListSpecific()
        {
            if(navigator.appName!='Microsoft Internet Explorer')
            {
                document.getElementById('IsApplicableToChild').style.display='table-row';
                document.getElementById('trrights').style.display='table-row';
            }
            else
            {
                document.getElementById('IsApplicableToChild').style.display='block';
                document.getElementById('trrights').style.display='block';    
            }
            document.getElementById('trEmpty').style.display='none';                   
        }     
        
        function Repository()
        {
            if(navigator.appName!='Microsoft Internet Explorer'){
                document.getElementById('IsApplicableToChild').style.display='table-row'; }
                    else{document.getElementById('IsApplicableToChild').style.display='block';}
        }
        
        function FollowerFlag()
        {
            if(navigator.appName!='Microsoft Internet Explorer'){
            document.getElementById('ChildValueType').style.display='table-row';}
                else{document.getElementById('ChildValueType').style.display='block';}
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
<body id="Body" style="overflow: hidden">
    <div id="divparent" style="height:100%;">
        <form id="form1" runat="server" style="height:100%;">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <div id="divheader">
                <table style="width:98%;border-spacing:1px;border-collapse:separate;margin:0px auto;" >
                    <tr style="height:40px">
                        <td colspan="2" class="pagetitle" style="padding:5px;">
                            <img src="<%=ThemeURL%>Repository/Site/images/new-security-popup.png" align="absmiddle" />&nbsp;&nbsp;
                            <%= _ResManager.GlobalResourceSet.GetString("ed_rights_view_header")%>
                        </td>
                    </tr>
                    <tr>
                        <td class="description" style="padding:5px;">
                        &nbsp;&nbsp;
                            <%= _ResManager.GlobalResourceSet.GetString("ed_rights_view_title_desc")%>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divbody">
                <table id="TMain" style="width:98%;margin:0px auto;border-collapse:separate;border-spacing:1px;height:100%;" cellpadding="7" class="tablebg">
                    <tr style="height: 30px">
                        <td class="lefttdbg" valign="top" style="width: 45%;padding:7px;">
                            <span class="subtitle"><%= _ResManager.GlobalResourceSet.GetString("ec_rights_name")%>
                            </span>
                            <br />
                            <span class="description">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_neme_desc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 50%;padding:7px;">
                            <asp:TextBox ID="txtRightsName" CssClass="inputtext" runat="server" Width="300px" Enabled="false" />
                        </td>
                    </tr>
                    <tr style="height: 30px">
                        <td class="lefttdbg" style="width: 45%;padding:7px;vertical-align:top;">
                            <span class="subtitle"><%= _ResManager.GlobalResourceSet.GetString("ec_rights_code")%>
                            </span>
                            <br />
                            <span class="description">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_code_desc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 50%;padding:7px;">
                            <asp:TextBox ID="txtRightsCode" CssClass="inputtext" runat="server" Enabled="false"
                                Width="300px" />
                        </td>
                    </tr>
                    <tr style="height: 30px">
                        <td class="lefttdbg" style="width: 45%;padding:7px;vertical-align:top;">
                            <span class="subtitle"><%= _ResManager.GlobalResourceSet.GetString("ec_rights_scope")%>
                            </span>
                            <br />
                            <span class="description">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_scope_desc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 50%;padding:7px;">
                            <asp:DropDownList ID="cboRightsLevel" runat="server" CssClass="inputselect" AutoPostBack="true"
                                Enabled="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="height: 30px">
                        <td class="lefttdbg"  style="width: 45%;padding:7px;vertical-align:top;">
                            <span class="subtitle"><%= _ResManager.GlobalResourceSet.GetString("ec_rights_parentvalue")%>
                            </span>
                            <br />
                            <span class="description">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_parentvalue_desc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 50%;padding:7px;">
                            <asp:DropDownList ID="cboType" CssClass="inputselect" runat="server" Enabled="false">
                                <asp:ListItem Selected="true" Text="Select">--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="IsApplicableToChild" style="height: 30px; display: none;padding:7px;">
                        <td class="lefttdbg" valign="top" style="width: 45%">
                            <span class="subtitle"><%= _ResManager.GlobalResourceSet.GetString("ec_rights_applicabletochild")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 50%;padding:7px;">
                            <asp:RadioButtonList ID="rdoIsApplicableToChild" runat="server" CssClass="inputradio"
                                RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Text="True">Yes</asp:ListItem>
                                <asp:ListItem Selected="true" Text="False">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr id='ChildValueType' style="height: 30px; display: none;" runat="server">
                        <td class="lefttdbg" style="width: 45%;padding:7px;vertical-align:top;">
                            <span class="subtitle"><%= _ResManager.GlobalResourceSet.GetString("ec_rights_childvalue")%>
                            </span>
                            <br />
                            <span class="description">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_childvalue_description")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 50%;padding:7px;">
                            <asp:DropDownList ID="cboChildValueType" CssClass="inputselect" runat="server" Enabled="false">
                                <asp:ListItem Selected="true" Text="Select">--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="trEmpty" style="height: 100%" class="lefttdbg">
                        <td style="padding:7px;">
                        </td>
                        <td style="padding:7px;">
                        </td>
                    </tr>
                    <tr id="trrights" style="display: none; height: 100%">
                        <td id="listrights" class="lefttdbg"  style="width: 45%;vertical-align:top;padding:7px;">
                            <span class="subtitle"><asp:Label ID="lblListNames" runat="server"
                                CssClass="subtitle" Visible="false"><%= _ResManager.GlobalResourceSet.GetString("ec_rights_listnames")%></asp:Label>
                            </span>
                            <br />
                            <span class="description">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_rights_listnamesdescription")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 50%;padding:7px;">
                            <div id="divLists" style="overflow: auto; height: 100%">
                                <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                                    <tr>
                                        <td class="righttdbg">
                                            <asp:CheckBoxList ID="chkRights" runat="server" Visible="false" CssClass="inputcheckbox"
                                                Enabled="false">
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
                <table style="width:100%;border-spacing:0px;border-collapse:collapse;" cellpadding="10">
                    <tr>
                    <td id="tdNote" style="padding:10px;">
                            <span class="note">
                                &nbsp;&nbsp;&nbsp;<img src="<%=ThemeURL%>Repository/Site/images/icon-warnings.png" align="absmiddle" />&nbsp;&nbsp;
                                    <%= _ResManager.GlobalResourceSet.GetString("ec_rights_applicabletochild_description")%>
                                </span>
                        </td>
                        <td style="padding:10px;text-align:right;" colspan="2">
                            <asp:Button ID="btnClose" runat="server" CssClass="inputbutton"  OnClientClick="closeWindow();" />
                        </td>
                    </tr>
                </table>
            </div>
            <asp:HiddenField ID="hdnvalidate" runat="server" Value="false" />
            <asp:HiddenField ID="hdnSecurityRightsId" runat="server" Value="false" />
        </form>
    </div>
</body>
</html>
