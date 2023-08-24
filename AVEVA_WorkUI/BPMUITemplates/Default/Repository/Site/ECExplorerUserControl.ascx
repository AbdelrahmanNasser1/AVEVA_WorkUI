<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.EC.ECExplorerUserControl" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<link href="<%=objExplorerControl.GetThemeRelativeUrl("Common/StyleSheet/Global.css")%>" rel="stylesheet" type="text/css" />
<link href="<%=objExplorerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css")%>" rel="stylesheet" type="text/css" /> 
<script language="javascript">
     
     function winClose()
        { window.close();}
</script>
<script src="../../Common/JavaScripts/jquery.min.js"></script>
<script src="../../Common/JavaScripts/AutoLogoff.js"></script>
  <table border="0" cellpadding="0" cellspacing="0" width="100%" class="lefttdbg">
    <tr>
        <td colspan="4" valign="top" align="center" style="padding-left:10px;">
            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                <tr>
                    <td align="left" style="width: 5%">
                        <img alt="" src="<%=ImagePath%>icon-EC-Explorer.png" /></td>
                    <td align="left">
                        &nbsp;<asp:Label ID="lblTitle" CssClass="subtitle" runat="server" Text="Enterprise Console List" /></td>
                </tr>
            </table>

        </td>
    </tr>
    
    <tr>
        <td colspan="3" style="width: 100%; height: 6px;" valign="middle" align="left">
        </td>
    </tr>
    <tr>
        <td style="width: 460px; height: 280px;" colspan="4" align="left"  >
            <table cellpadding="0" cellspacing="1"  id="TABLE1"  style="width:100%">
                <tr>
                    <td style="height: 19px; width: 100%;"  >
                           <table border="0" cellpadding="2" style="width: 100%" cellspacing="0">
                            <tr>
                                <td style="width: 100%; height: 199px;padding-left:10px;" valign="top">
                                    <div  style="overflow:auto; height:212px;width:500px;">
                                    <telerik:RadTreeView  ID="ExplorerTreeView" runat="server" OnNodeExpand="ExplorerTreeView_NodeExpand" SingleExpandPath="true" Height="100%" Width="100%"  Skin="AWTTreeView" RenderMode="Classic" EnableEmbeddedSkins="false">
                                    </telerik:RadTreeView>                                                                      
                                     </div>           
                </td>
                                    
                                    <input type="hidden" runat=server id="hidECId"/>
                                    
                                </td>
                            </tr>
                        </table>
                    </td>
                    <!--  </div> -->
                </tr>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" width="98%" align="center">
                <tr>
                    <td colspan="4">
                        <div >
                            <asp:Label ID="lblMessage" runat="server" CssClass="errormsg"></asp:Label>&nbsp;</div>
                    </td>
                </tr>
                <tr>
                    <!-- <td colspan="4" align="center" style="height: 67px;"> -->
                    <td colspan="4" width="100%" align="center">
                        <div>
                            <table cellpadding="0" cellspacing="1" width="100%" border="0" >
                                <tr>
                                    <td style="height: 50px;padding-left:10px;">
                                        <span style="padding-right: 5px">
                                            <img alt="" src="<%=objExplorerControl.GetThemeRelativeUrl("common/images/icon-note.png")%>" style="vertical-align: middle" />&nbsp;<asp:Label
                                                ID="lblHelp" runat="server" CssClass="note" Text="Help"></asp:Label>
                                        </span><span style="padding-right: 5px"></span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table cellpadding="4" cellspacing="0" width="100%" border="0">
                            <tr>
                                <td align="right">
                                    <input type="button" class="inputsecondarybutton" id="btnCancel" value="<%=CancelText%>" onclick="winClose()" />
                                    <asp:Button ID="btnSelect" runat="server" Text="Select" CssClass="inputbutton" OnClick="btnSelect_Click"/><br />
                                </td>
                            </tr>
                        </table>
                        
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
