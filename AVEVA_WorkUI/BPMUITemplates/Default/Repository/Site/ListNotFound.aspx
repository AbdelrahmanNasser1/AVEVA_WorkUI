<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master" AutoEventWireup="true" CodeFile="ListNotFound.aspx.cs"
    Inherits="BPMUITemplates_Default_Repository_Site_CreateDListTableHelp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
            <table border="0" width="100%" height="100%">                
                <tr height="8%">
                    <td width="5%" height="50" align="center" valign="middle" style="height: 50px">
                        <img src="<%=ThemePath%>Repository/ListControl/images/skelta-DLItem-Item.png" alt="" />
                    </td>
                    <td width="91%">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td  width="20%">
                            <span class="pagetitle"><%=ListNotFoundTitle%></span>
                          </td>
                          <td id="bcrumb" >
                          </td>
                        </tr>                    
                    </table>
                    </td>
                </tr> 
                <tr height="10%" valign=top>                
                    <td colspan=2>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="2%"></td>  
                              <td  >                    
                                <span class="description"><%=resManager.GlobalResourceSet.GetString("List_DynamicListDeletedMsg")%></span>
                              </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr height=70%>
                    <td></td>
                </tr>                                               
            </table>
</asp:Content>