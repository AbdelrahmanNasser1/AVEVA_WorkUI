<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.WorkflowTasks" %>

<!DOCTYPE html>
<html style="height:100%">
<head id="Head1" runat="server">
    <title>Workflow Options</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
function RefreshGrid()
{
    closeWin();
    //GetRadWindow().BrowserWindow.opener.document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
}

function GetRadWindow()
{
    var oWindow = null;
    if (window.radWindow) oWindow = window.radWindow;
    else if(window.frameElement)
    { 
        if (window.frameElement.radWindow) 
            oWindow = window.frameElement.radWindow;
        else 
            window.location.reload();
    }
    return oWindow;
}

function closeWin(){
        var oWnd = GetRadWindow();
        if(oWnd)
            oWnd.close();
        else
            window.close();
}

function hideWin()
{
 var oWindow = GetRadWindow(); 
 try
 {            
 oWindow.hide();
 }
 catch(e)
 {
    if(oWindow)
        oWindow.close();
    else
        window.close();
 }
}

function openWin(uri){
    var w,h;
            
    if (document.all || document.layers) {
        w = screen.availWidth;
        h = screen.availHeight;
    }

         var winIsResizable = "1";
         var winIsScrollable = "0";

         var winHeight = (h* 85/100);
         var winWidth  = (w* 85/100); 
    
         var winLeft = (w-winWidth)/2;
         var winTop  = (h-winHeight)/2;               

    window.open(uri,'',"left="+winLeft+",top="+winTop+",width="+winWidth+",height="+winHeight+",resizable="+winIsResizable+",scrollbars="+winIsScrollable+"\"");
    hideWin(); // here just hide the window, this will get closed when process designer closed.
}

// for workflowtasks and workflowtasksform the same workflowtasks code behind is attached.. in case of form 
// we are not concerned on lock concept and the hidden field also may not be present
function setunlockhidvalue() {
 if(document.getElementById("hidunlock")!=null)
    document.getElementById("hidunlock").value = "false";
}
</script>
</head>
<body style="height:100%;overflow:hidden;">
    <form id="frmOptions" runat="server" style="height:100%">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />
     <table style="width:100%;margin:auto;border-width:0;height:100%;">
            <tr>
            <td class="pagetitle" style="width:100%;padding:5px">
            <img src="<%=cssPath%>Skeltaforms/Images/form-newwfinitiate.png" alt="" style="vertical-align:middle" />
            <%=_ResManager.GlobalResourceSet.GetString("ec_workflow_tasks")%></td>
            </tr>
           
            <tr>
                            <td style="width:45%;text-align:center" colspan="2" >
                            
                                <%if (confirmationMsg != "")
                          {%>
                               
                                    <span class="successfulmsg" style="vertical-align: middle">
                                        <%=Microsoft.Security.Application.Encoder.HtmlEncode(confirmationMsg) %>
                                    </span>
                               
                                <%} %>
                                <br />
                               </td>
                        </tr>
                         <tr>
            <td class="description" style="text-align:center">
          <%=_ResManager.GlobalResourceSet.GetString("FormFormOptionsOperationsKey")%> '<%=Microsoft.Security.Application.Encoder.HtmlEncode(WorkflowName)%>'
                                    form.
            </td>
            </tr>
            <tr style="vertical-align:top; width:100%;height:90%">
                <td style="width:100%">
                    <table style="width:97%;border-width:0;margin:auto"  class="tablebg" >
                       <tr>
                            <td style="vertical-align:middle;width:50%" class="lefttdbg">
                                <div class="subtitle">
                                     <%=_ResManager.GlobalResourceSet.GetString("FormFormOrdinaryTasks")%></div><br />
                                <div class="description">
                                    <%=_ResManager.GlobalResourceSet.GetString("FormFormOptionsChooseActionKey")%><br />
                                    <%=confirmationMsg2 %>
                                </div>
                            </td>
                            <td class="righttdbg">
                                <span class="description">
                                    <asp:RadioButtonList ID="RadioButtonList1" Font-Size="12px" runat="server" CssClass="inputradio">
                                    </asp:RadioButtonList></span>
                            </td>
                        </tr>
                          <tr id="TrNote" runat="server">
                            <td colspan="2" class="lefttdbg" id="notetd" runat="server">
                                <img id="Img1" runat="server" alt="" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                  style="vertical-align:top"><span class="note">
                                        <%=confirmationMsg2 %>
                                    </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr >
                <td style="text-align:right;vertical-align:middle;height:5%;padding:5px">
                   <input id="Button1" name="AddWorkflow" type="button" value="Finish" class="inputbutton" onclick="document.forms[0].submit()" />
                </td>             
            </tr>
        </table>
    </form>
</body>
</html>
