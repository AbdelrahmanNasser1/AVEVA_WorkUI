<%@ Page Language="C#" AutoEventWireup="true"
    Inherits="Skelta.Repository.Web.CodeBehind.ViewAssociateDetails" %>
 
 <link rel="stylesheet" type="text/css" href="<%=ThemeRelativeUrl%>Common/StyleSheet/Global.css" /> 
<html>
<head id="Head1" runat="server">
    <title><%=_ResManager.GlobalResourceSet.GetString("Association Properties") %></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>


</head>

<script language="javascript" type ="text/javascript" >
    var urlparams = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(urlParams, false)%>";
    
    function GetRadWindow()
    {
        var oWindow = null;

        if (window.radWindow)
            oWindow = window.radWindow;
        else if (window.frameElement.radWindow)
            oWindow = window.frameElement.radWindow;

        return oWindow;
    }
    
    function closeWin()
    {
        var oWindow = GetRadWindow();
        oWindow.close();
    }

function ShowASBAssociationDetails(applicationName, eventBindingId) {

    var l = window.location.toString();
    l = l.replace("ViewAssociateDetails.aspx", "ShowASBAssociation.aspx");
    l += "&eventBindingId=" + encodeURIComponent(eventBindingId);
    l += "&application=" + encodeURIComponent(applicationName);

    var widthOfWindow = 400;
    var heightOfWindow = 200;
    var w, h;
    w = screen.availWidth-500;
    h = screen.availHeight - 300;
    var left = (w / 2) - (widthOfWindow / 2);
    var top = (h / 2) - (heightOfWindow / 2);
    var topValue = 'top=' + top;
    var leftValue = 'left=' + left;

    var winObj = window.open(l, null, "scrollbars=no,titlebar=no,status=no,location=no,resizable=yes," + topValue + ',' + leftValue + "',width='"+widthOfWindow+"',height='"+heightOfWindow+"'");
}


</script>


<script language='JavaScript' src="<%=templateDirectory%>Scripts/menuversion.js"></script>


<body >
    <form id="form1" runat="server">
       <%=System.Web.Helpers.AntiForgery.GetHtml()%>      
       <table  cellpadding="4" cellspacing="1" border="0" width="100%" align="center" >
       <tr>
       <td></td>
       </tr>
       </table>
         <table cellpadding="4" cellspacing="1" border="0" width="100%" align="center" class="tablebg">
         
             <tr>
                 <td class="lefttdbg" width="30%">
                     <span class="subtitle">
                         <%= _ResManager.GlobalResourceSet.GetString("ecm_view_assn_eventname") %>
                     </span>
                 </td>
                 <td class="righttdbg">
                     <asp:Label ID="lbleventname" runat="server" CssClass="description" Text=""></asp:Label>
                 </td>
             </tr>
               
               
                <tr >
                    <td class="lefttdbg" >
                        <span class="subtitle">
                            <%= _ResManager.GlobalResourceSet.GetString("ecm_view_assn_eventdesc") %>
                        </span>
                    </td>
                    <td class="righttdbg" >
                        <asp:Label ID="lbleventdesc" runat="server" CssClass="description" Text=""></asp:Label>
                    </td>
                </tr>
                
                <tr >
                    <td class="lefttdbg" >
                        <span class="subtitle">
                            <%= _ResManager.GlobalResourceSet.GetString("ecm_view_assn_eventtype") %>
                        </span>
                    </td>
                    <td class="righttdbg" >
                        <asp:Label ID="lblEventType" runat="server" CssClass="description" Text=""></asp:Label>
                    </td>
                </tr>
                
                <tr >
                    <td class="lefttdbg" >
                        <span class="subtitle">
                          <%= _ResManager.GlobalResourceSet.GetString("ecm_view_assn_eventprovider") %>
                        </span>
                    </td>
                    <td class="righttdbg" >
                        <asp:Label ID="lbleventprovider" runat="server" CssClass="description" Text=""></asp:Label>
                    </td>
                </tr>
               
                <tr >
                    <td class="lefttdbg" >
                        <span class="subtitle">
                            <%= _ResManager.GlobalResourceSet.GetString("ecm_view_assn_alertwf") %>
                        </span>
                    </td>
                    <td class="righttdbg" >
                        <asp:Label ID="lblworkflow" runat="server" CssClass="description" Text=""></asp:Label>
                    </td>
                </tr>
                
                <tr >
                    <td class="lefttdbg" >
                        <span class="subtitle">
                           <%= _ResManager.GlobalResourceSet.GetString("ecm_view_assn_alertver")%>
                        </span>
                    </td>
                    <td class="righttdbg" >
                        <asp:Label ID="lblversion" runat="server" CssClass="description" Text=""></asp:Label>
                    </td>
                </tr>
               
                <tr>
                    <td class="lefttdbg" >
                        <span class="subtitle">
                          <%= _ResManager.GlobalResourceSet.GetString("ecm_view_assn_processed")%>
                        </span>
                    </td>
                    <td class="righttdbg">
                        <asp:Label ID="lblprocessed" runat="server" CssClass="description" Text=""></asp:Label>
                    </td>
                </tr>
                            
              
                    
            </table>
            <table cellpadding="4" cellspacing="1" border="0" width="100%" align="center">
            <tr>
                    
                    <td align="right" class="lefttdbg" colspan="2" >
                        <asp:Button ID="btnClose" CssClass="inputbutton" runat="server" 
                         OnClick="btnClose_Click" />
                    </td>
                </tr>
            </table>
        
       
    </form>
</body>
</html>
