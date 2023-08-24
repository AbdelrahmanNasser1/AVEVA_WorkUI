<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master" Inherits="Skelta.Repository.Web.CodeBehind.SynchronizeRole"  %>
<%@ Import Namespace="Workflow.NET" %>
<%@ Import Namespace="Skelta.EntityDataSourceProvider" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
       <%=_WorkItemTitle%>					
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
<link rel="stylesheet" href="<%=cssPath%>Common/StyleSheet/Global.css" type="text/css" />
    <style type="text/css">
        .buttonPadding {
            margin-left :10px;
        }
        .buttonMarginLeft {
              margin-left: 12px;
              vertical-align:bottom !important;
        }
    </style>
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
<tr><td>
<table align="center " border="0" cellpadding="5" cellspacing="1" width="100%">
    <tr>
        <td valign="middle" width="36" >
            <img src="images/icon-synchronize.png" width="36" height="36" align="absmiddle" />
        </td>
        <td>
            <asp:Label CssClass="pagetitle" ID="lblHeading" runat="server">Synchronize Roles</asp:Label>
        </td>
    </tr>
</table>
</td>
</tr>
    <tr>
        <td  align=center>
            
            <table width="96%" border="0" align="center" cellpadding="5" cellspacing="1" class="tablebg">
                <tr>
                    <td width="40%" id="tdSearch" valign="top" class="lefttdbg" style="padding-left:20px;text-align:left;"><span class="subtitle" align="top" runat="server" id="spSearch">
                        Search Roles :</span>
                         <br />
                         <span class="description" runat="server" id="spSearchDesc">Select Roles to be Synchronized with the Cross Domain Role Provider.This will list only those roles
                         which are used in Skelta.</span>  
                        </td>
                    <td width="60%" class="righttdbg" >
                        <asp:TextBox runat="server" ID="txtSearchRole" Width="45%" CssClass="inputtext"
                            MaxLength="150"></asp:TextBox>
                    
                        <asp:Button runat="server" ID="btnSearch" CssClass="inputbutton buttonPadding" Text="Search"
                            OnClick="btnSearch_OnClick" /></td>
                            
                </tr>
                <tr>
                    <td valign="top" id="tdChoose" class="lefttdbg" style="padding-left:20px;text-align:left;"><span class="subtitle" align="top" runat="server" id="spChoose">
                        Choose Roles :</span><br />
                        <span class="description" runat="server" id="spChooseDesc">Select Roles to be Synchronized with the Cross Domain Role Provider.This will list only those roles
                         which are used in Skelta.</span>  
                        </td>
                    <td class="righttdbg" >
                        <asp:ListBox runat="server" ID="lstRoles" Height="120px" Width="45%" CssClass="TextboxStyle"
                            SelectionMode="Multiple"></asp:ListBox>
                     <asp:Button runat="server" ID="btnSynchronize" Text="Synchronize" CssClass="inputbutton buttonMarginLeft"
                            OnClick="btnSynchronize_OnClick" /></td>
                </tr>
                </table>
            <table width="96%" border="0" align="center" cellpadding="5" cellspacing="1"  >
                <tr>
                    <td style="width:40%"></td>
                    <td>
                       
                        <asp:Label ID="LabelRoleMessage" CssClass="successfulmsg" runat="server" />
                        <asp:Label ID="LabelRoleErrorMessage" CssClass="errormsg" runat="server"  />
                        <asp:Label ID="LabelErrorMessage" CssClass="errormsg" runat="server" ForeColor="red" />
                    </td>
                    
                </tr>
                </table>
            <%--<div style="text-align:right;padding-right:25%;">
                       
                 </div>   --%>
        </td>
    </tr>
</table>
</asp:Content>
       


    
 