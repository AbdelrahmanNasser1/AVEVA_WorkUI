<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.Lookup.FormLookupUserControl" %>
<link href="<%=csspath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css">

<script src="../../Common/JavaScripts/jquery.min.js"></script>
<script src="../../Common/JavaScripts/AutoLogoff.js"></script>

<script language="javascript">
    function Validate()
    {
           var listitems = document.getElementById('FormsLookup$ctl00$lstselectedforms');
           var isselected = false;
           var count = listitems.length;
           var i=0;
           if(count>0)
           {
               if(listitems.selectedIndex != -1)
                    isselected = true;
               
               if(isselected)
                return true;
               else
               {
                    alert('Please select atleast one item to remove.');
                    return false;
               }
           }
           else
           {
                alert ('Theres is no items to remove');
                return false;
           }
    }
</script>

<div>
    <table width="500" cellspacing="3" cellpadding="3" border="0">
        <tr>
            <td class="subtitle">
                <asp:Image ID="imgSelect" runat="server" align="absmiddle" ImageUrl="<%$ ReplaceTemplateExpn:Repository/ListControl/Images/icon-select-form.png %>" />
                <%=resMgr.GlobalResourceSet.GetString("SelectFormsText") %></td>
        </tr>
        <tr>
            <td>
                <table cellspacing="1" cellpadding="4" border="0" width="100%" align="center" class="tablebg">
                    <tr>
                        <td class="lefttdbg" width="250">
                           <span class="subtitle"><%=strForms %></span>
                        </td>
                        <td width="30" class="lefttdbg">
                            <span class="subtitle"><%=resMgr.GlobalResourceSet.GetString("AddText") %></span>
                        </td>
                        <td class="lefttdbg" width="220">
                            <span class="subtitle"><%=strSelectedForms %></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" valign="top">
                            <table border="0">
                                <tr>
                                    <td class="description">
                                        <asp:Label ID="lblform" runat="server" CssClass="runtext"></asp:Label>
                                    </td>
                                    <td class="description">
                                        <asp:Panel ID="pnllookup" runat="server">
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="description">
                                        <asp:Label ID="lblversion" runat="server"></asp:Label>
                                    </td>
                                    <td class="description">
                                        <asp:Panel ID="pnlversion" runat="server">
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:CheckBox ID="chkOwned" runat="server" CssClass="inputcheckbox" Visible="false" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="lefttdbg">
                            <asp:Button ID="btnAdd" runat="server" Text="  >  " CssClass="inputbutton" Width="35Px"
                                OnClick="btnAdd_Click" /></td>
                        <td class="lefttdbg">
                            <table border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <td class="lefttdbg" rowspan="2">
                                        <asp:ListBox SelectionMode="Multiple" Rows="4" runat="Server" ID="lstselectedforms"
                                            Width="225px" Height="70px"></asp:ListBox>
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="btndelete" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:Repository/ListControl/Images/icons-ribbon/delete.png %>"
                                            OnClientClick="Validate();" OnClick="btndelete_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <asp:ImageButton ID="btndeleteAll" runat="server" ImageUrl="<%$ReplaceTemplateExpn:Repository/ListControl/Images/icons-ribbon/delete-all.png %>"
                                            OnClick="btndeleteAll_Click" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <table width="660" cellspacing="3" cellpadding="3" border="0" >
        <tr>
            <td class="subtitle">
                <asp:Image ID="imgSet" runat="server" align="absmiddle" ImageUrl="<%$ ReplaceTemplateExpn:Repository/ListControl/Images/icon-set-default.png %>" />
                <%=resMgr.GlobalResourceSet.GetString("SetDefaultsText") %></td>
        </tr>
        <tr>
            <td>
                <table cellspacing="1" cellpadding="4" border="0" width="100%" align="center" class="tablebg">
                    <tr>
                        <td class="lefttdbg" width="80">
                          <span class="subtitle"><%=resMgr.GlobalResourceSet.GetString("Formsfor") %></span>
                        </td>
                        <td class="lefttdbg">
                            <span class="subtitle"><%=resMgr.GlobalResourceSet.GetString("FormNameText") %></span>
                        </td>
                        <td  class="lefttdbg">
                           <span class="subtitle"> <%=resMgr.GlobalResourceSet.GetString("Versionheading") %></span>
                        </td>
                        <td  class="lefttdbg">
                           <span class="subtitle"> <%=resMgr.GlobalResourceSet.GetString("SetAsDefault") %></span>
                        </td>
                        <td  class="lefttdbg">
                           <span class="subtitle"> <%=resMgr.GlobalResourceSet.GetString("SelectedFormText") %></span>
                        </td>
                        <td  class="lefttdbg" align="center">
                            <span class="subtitle"><%=resMgr.GlobalResourceSet.GetString("ResetText") %></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg">
                            <span class="description"><%=resMgr.GlobalResourceSet.GetString("OwnedItems") %></span>
                        </td>
                        <td class="lefttdbg">
                            <asp:Panel ID="pnlownedform" runat="server">
                            </asp:Panel>
                        </td>
                        <td class="lefttdbg">
                            <asp:Panel ID="pnlownedverion" CssClass="verwidth" runat="server">
                            </asp:Panel>
                        </td>
                        <td class="lefttdbg" align="center">
                            <asp:Button ID="btnOwneddefault" runat="server" Text="  >  " CssClass="inputbutton" Width="35Px"
                                OnClick="btnOwneddefault_Click" />
                        </td>
                        <td class="lefttdbg">
                            <asp:TextBox ID="txtDefaultOwnedForm" runat="server" ReadOnly="true" CssClass="inputtext"
                                Width="90%"></asp:TextBox>
                            <asp:HiddenField ID="hdnFormId" runat="server" />
                            <asp:HiddenField ID="hdnFormVer" runat="server" />
                            <asp:HiddenField ID="hdnPrevFormId" runat="server" />
                            <asp:HiddenField ID="hdnFormNameOwned" runat="server" />
                            <asp:HiddenField ID="hdnPrevFormVer" runat="server" />
                          
                        </td>
                        <td class="lefttdbg" align="center">
                            <asp:ImageButton ID="btnResetOwned" runat="server" Height="20px" ImageUrl="<%$ ReplaceTemplateExpn:Repository/ListControl/Images/icon-reset.png %>"
                                OnClick="btnResetOwned_Click" />
                        </td>
                    </tr>
                    <tr id="trnondefault" runat="server">
                        <td class="lefttdbg">
                            <span class="description"> <%=resMgr.GlobalResourceSet.GetString("NonOwnedItems") %></span>
                        </td>
                        <td class="lefttdbg">
                            <asp:Panel ID="pnlnonownedform" runat="server">
                            </asp:Panel>
                        </td>
                        <td class="lefttdbg">
                            <asp:Panel ID="pnlnonownedverion" runat="server">
                            </asp:Panel>
                        </td>
                        <td class="lefttdbg" align="center">
                            <asp:Button ID="btnNonOwneddefault" runat="server" Text="  >  " CssClass="inputbutton" Width="35Px"
                                OnClick="btnNonOwneddefault_Click" />
                        </td>
                        <td class="lefttdbg">
                            <asp:TextBox ID="txtDefaultNonOwnedForm" runat="server" ReadOnly="true" CssClass="inputtext"
                                Width="90%"></asp:TextBox>
                            <asp:HiddenField ID="hdnNonFormId" runat="server" />
                            <asp:HiddenField ID="hdnNonFormVer" runat="server" />
                            <asp:HiddenField ID="hdnNonPrevFormId" runat="server" />
                            <asp:HiddenField ID="hdnNonPrevFormName" runat="server" />
                            <asp:HiddenField ID="hdnNonPrevFormVer" runat="server" />
                            
                        </td>
                        <td class="lefttdbg" align="center">
                            <asp:ImageButton ID="btnResetNonOwned" runat="server" Height="20px" ImageUrl="<%$ ReplaceTemplateExpn:Repository/ListControl/Images/icon-reset.png %>"
                                OnClick="btnResetNonOwned_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
