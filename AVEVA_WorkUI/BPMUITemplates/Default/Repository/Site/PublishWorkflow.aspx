<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.Publish" %>

<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<!DOCTYPE html>
<html>
<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
<head id="Head1" runat="server">
    <title><%=publishTitle %></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    
</head>
<body id="Body" onunload="CloseParent();">
    
 <script language="javascript" type="text/javascript">
     var w, h;
   
    var oWindow = GetRadWindow();
    if(oWindow==null) //if it is not from list ie from the process designer
    {
        w = screen.availWidth;   //getMaxWidth();    
        h = screen.availHeight; //getMaxHeight();    
       var winResize ="<%=windowResize%>";
       var  wasWinResizedBefore ="<%=wasWindowResizedBefore%>";
       if(winResize=="False" && wasWinResizedBefore=="False" ) //if the window is not getting resized then only call this
       {
            window.moveTo((w/2)-100,(h/2)-100);//move the windw to the center of the screen
            //set the the window style also.
            document.getElementById('Body').className="validation-bgsmall";
       }
       else
       {
            document.getElementById('Body').className="validation-bg";
       }
     }
     else
     {
        document.getElementById('Body').className="validation-bg";
     }
function GetRadWindow()
{
    var oWindow = null;
    if(window.frameElement!=null)
        oWindow = window.frameElement.radWindow;
    return oWindow;
}
function CloseParent() 
{
    var isFromAA=0; 
    if(window.opener!=null && window.opener!= undefined)
    {
        try
        {        //debugger;      
            if (window.opener.location.pathname.indexOf("AAAssociation.aspx", 0) != -1 && window.name!="resizedWindow") {
                isFromAA=1;
                window.opener.RefreshGrid();
            }
            else if (window.opener.top.opener!=null)
            {
                if (window.opener.top.opener.location.href.indexOf('AAAssociation.aspx') != -1) {
                    isFromAA = 1;
                    window.opener.top.opener.RefreshGrid();
                    if (window.opener.location.href.indexOf('VersionGrid.aspx', 0) != -1) {
                        window.opener.RefreshGrid();
                    }
                    else {
                        window.opener.setTimeout("try{window.top.close();}catch(err){if(window.top.name=='publishdefinition'){window.top.close();}}", 10);
                    }
                }
                else if (window.opener.top.opener.location.href.indexOf('VersionGrid.aspx') != -1)
                {
                    if (window.opener.top.opener.top.opener.location.href.indexOf('AAAssociation.aspx') != -1) {
                        isFromAA = 1;
                        window.opener.top.opener.top.opener.RefreshGrid();
                        window.opener.setTimeout("try{window.top.close();}catch(err){if(window.top.name=='publishdefinition'){window.top.close();}}", 10);
                    }

                }
            }
            else if (window.opener.location.pathname.indexOf("AAAssociation.aspx", 0) != -1) {
                isFromAA = 1;
                window.opener.RefreshGrid();
            }
        }catch(err){}
       try
       {
           if (isFromAA == 0) {
               if (document.getElementById('PublishMessage') != null || document.getElementById('PublishErrMsg') != null) {
                   if (document.getElementById('PublishErrMsg').innerText == "") {
                       //window.opener.setTimeout("try{window.top.opener.location.href=window.top.opener.location.href;window.top.close();}catch(err){if(window.top.name=='publishdefinition'){window.top.close();}}", 10);
                       //window.opener.setTimeout("try{window.top.opener.RefreshGrid();window.top.close();}catch(err){if(window.top.name=='publishdefinition'){window.top.close();}}", 10);
                       window.opener.setTimeout("try{window.top.close();}catch(err){if(window.top.name=='publishdefinition'){window.top.close();}}", 10);
                   }
               }
               else {
                   //window.opener.setTimeout("try{window.top.opener.location.href=window.top.opener.location.href;window.top.close();}catch(err){if(window.top.name=='publishdefinition'){window.top.close();}}", 10);
                   //window.opener.setTimeout("try{window.top.opener.RefreshGrid();window.top.close();}catch(err){if(window.top.name=='publishdefinition'){window.top.close();}}", 10);
                   window.opener.setTimeout("try{window.top.close();}catch(err){if(window.top.name=='publishdefinition'){window.top.close();}}", 10);
               }
           }
       }catch(err){}

       if (window.name == "resizedWindow") return;
       else {
           if (document.getElementById('PublishMessage') != null || document.getElementById('PublishErrMsg') != null) 
           {
               if (document.getElementById('PublishErrMsg').innerText == "") {
                   window.close();
               }
           }
           else
               window.close();
           
       }
    }
}
    

function closeWindow(closeparent) {
    try {
        if (window.name == "resizedWindow") {
            if (window.opener.location.pathname.indexOf("AAAssociation.aspx", 0) != -1) {
                window.opener.RefreshGrid();
            }
        }
        else {
            if (window.parent.opener.parent.top.opener.location.pathname.indexOf("AAAssociation.aspx", 0) != -1) {
                window.parent.opener.parent.top.opener.RefreshGrid();
            }
            else if (window.parent.opener.parent.top.opener.window.parent.location.pathname.indexOf("WFAssociate.aspx", 0) != -1) {
                try {
                    var radWindow = window.parent.opener.parent.top.opener.window.frameElement.radWindow;
                    if (radWindow != null) {
                        radWindow.close();
                    }
                }
                catch (err) {
                }
            }
            else {
                if (window.parent.opener.parent.top.opener.location.pathname.indexOf("AAAssociateExistingWF.aspx", 0) != -1) {
                    window.parent.opener.parent.top.opener.top.opener.RefreshGrid();
                    window.parent.opener.parent.top.opener.close();
                }
            }
        }
    } catch (err) { }       
  var oWindow = GetRadWindow();
  if(oWindow!=null)
    oWindow.close(); // it is a rad window opened form the List
  else
  {
      if (window.opener != null && closeparent) //normal window opened from the process designer.
      {
          if (document.getElementById('PublishMessage') != null || document.getElementById('PublishErrMsg') != null)
           {
               if (document.getElementById('PublishErrMsg').innerText == "") 
              {
                  closeChildandParentWindows();
              }
              else 
              {
                  
                  window.close();
              }

          }
          else
           {
              closeChildandParentWindows();
          }
    }
   
    else
    {        
        window.close();
    }
  }
}
function closeChildandParentWindows()
{
if(window.top.opener.location!=null)
{
    if(window.top.opener.location.href.indexOf("lcsuri") == -1)
    {
    }
    else
    {
        window.opener.setTimeout("try{window.top.close();}catch(err){window.top.close();}", 10); //window.top.opener.location.href=window.top.opener.location.href;
    }
 }
    if (window.top != null) {
        window.opener.setTimeout("try{window.top.close();}catch(err){window.top.close();}", 10); //window.top.opener.location.href=window.top.opener.location.href;
    }
    else
    {
        window.close();
    }

}
function ChangeSize()
{
    try
    {
        var oWindow = GetRadWindow();
        if (oWindow != null) {
           
            oWindow.setSize(600, 500);
            oWindow.center();
            oWindow.show();
           // window.moveTo((screen.availWidth / 2) - 300, (screen.availHeight / 2) - 250);
        }
        else {
            if (IsOpenedFromSkeltaWinControl(window)) {
                if (window.name != "resizedWindow") {
                    if (window.top.opener.location.pathname.indexOf("AAAssociation.aspx", 0) != -1) {
                        var w, h;
                        var winWidth, winHeight;
                        winWidth = 500;
                        winHeight = 450;
                        if (document.all || document.layers) {
                            w = screen.availWidth;
                            h = screen.availHeight;
                        }
                        var winLeft = (w - winWidth) / 2;
                        var winTop = (h - winHeight) / 2;
                        var hrefUrl = window.location.href;
                        var newWin = window.open(hrefUrl, "resizedWindow", "width=" + winWidth + ",height=" + winHeight + ",left=" + winLeft + ",top=" + winTop);
                        newWin.top.opener = window.top.opener;
                        window.close();
                        return newWin;
                    }
                    //below code for processdesigner page. sometime it not loads page.
                    setTimeout("AsyncOpenWindow()", 500);

                    //alert("AsyncOpenWindow('"+hrefUrl+"','resizedWindow','width=" + winWidth + ",height=" + winHeight + ",left=" + winLeft + ",top=" + winTop+"')");
                    //setTimeout("AsyncOpenWindow('"+hrefUrl+"','resizedWindow','width=" + winWidth + ",height=" + winHeight + ",left=" + winLeft + ",top=" + winTop+"')",100);

                    //var newWin=window.open(hrefUrl,"resizedWindow","width=" + winWidth + ",height=" + winHeight + ",left=" + winLeft + ",top=" + winTop);                
                    //newWin.top.opener=window.top.opener;
                    //window.close();
                    //newWin.navigate(hrefUrl);


                    return;
                    //return newWin;
                }
            }
            window.resizeTo(600, 500);
           // alert((w / 2) - 600, (h / 2) - 500);
            //window.moveTo((w / 2) - 600, (h / 2) - 500);
        }
     }catch(err)
    {   
        
    }
}

function AsyncOpenWindow()
{  
    var w,h;                  
    var winWidth, winHeight;
    winWidth=500;
    winHeight=450;
    if (document.all || document.layers) 
    {
        w = screen.availWidth;
        h = screen.availHeight;
    }  
    var winLeft = (w-winWidth)/2;
    var winTop  = (h-winHeight)/2; 
    var hrefUrl=window.location.href;
    
    var openerWindow = window.top.opener;
    setTimeout("CloseWindow()",100);
    //var newWin=window.open(hrefUrl,windowName,windowStyle); 
    var newWin=openerWindow.open(hrefUrl,"resizedWindow","width=" + winWidth + ",height=" + winHeight + ",left=" + winLeft + ",top=" + winTop);                              
    //newWin.top.opener=window.top.opener;
    
}

function CloseWindow()
{
    window.close();
}

function IsOpenedFromSkeltaWinControl(wndw)
{
    var strE=wndw.external;    
    var isFromWin;
    isFromWin=false;    
    if(strE!=null)
    {   
        try
        {
            if(strE.toString().substring(0,6)=="Skelta")
                isFromWin=true;            
        }
        catch(e)
        {
            isFromWin=false;
        }
    }    
    return isFromWin;    
}

function grd1_Init(gridId) 
 {
   var grid = wgGetGridById(gridId);
   grid.HidePadColumn = true; // never show pad column eventhough vertical scrollbar is shown, nicer UI when autofitcolumn is used.
}
function WebGrid1_OnRowContextMenu(gridId, rowType, rowEl, rowMenu,location)
 {   
      var i;
      if (rowType != "Record") return true;   
      if(rowType =="Record")
      {
            // hide the default context menu
            for (i=0;i<=43;i++)
            { 
             rowMenu.items[i].Hide();
            }
        }
 }
    </script>
     <form id="form1" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
    <div id="div1">
        <table id="publishMessageTable" style="border-spacing: 0; border-width: 0; margin: auto;padding-top:5px;">
            <tr>
                <td style="text-align: left; padding: 15px;">
                    <div id="innerMessage" style="height:80px;overflow:auto;">
                        <asp:Label ID="PublishMessage" runat="server" Text="" CssClass="successfulmsg"></asp:Label>
                        
                        <asp:Label ID="PublishErrMsg" runat="server" Text="" CssClass="errormsg"></asp:Label>
                    </div>
                </td>
            </tr>
        </table>
        <asp:Panel ID="ReportPanel" runat="server" Width="100%">
            <table style="width: 99%; border-width: 0; margin: auto;">
                <tr>
                    <td class="lefttdbg">
                        <table style="width: 100%; border-width: 0; margin: auto; border-spacing: 0">
                           <%-- <tr>
                                <td>
                                    <img alt="" src="<%=themePath%>SkeltaForms/images/spacer.gif" width="1" height="1" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <img alt="" src="<%=themePath%>SkeltaForms/images/spacer.gif" width="1" height="1" />
                                </td>
                            </tr>--%>
                            <tr>
                                <td style="height:65px">
                                    <table style="width:100%;border-width:0;border-spacing:0">
                                        <tr>
                                            <td class="description" style="padding:15px">
                                                <br />
                                                <%=resumeDesc %>
                                                <br />
                                                <br />
                                                <span class="note"><strong>
                                                    <%=publishNote %>
                                                    :</strong></span><span class="description">
                                                        <%=resumeNoteDesc %></span>
                                            </td>
                                            <td style="width:30%;padding:15px">
                                                <asp:Button ID="ResumeButton" runat="server" Text="" OnClick="ResumeButton_Click"
                                                    CssClass="inputbutton"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <%--<tr>
                                <td>
                                    <img src="<%=themePath%>SkeltaForms/images/spacer.gif" alt="" width="1" height="1" />
                                </td>
                            </tr>--%>
                            <tr>
                                <td style="height:65px">
                                    <table style="width:100%;border-width:0;border-spacing:0">
                                        <tr>
                                            <td style="padding:15px">
                                                <span class="subtitle" >
                                                    <%=donotresumeHeader %>
                                                    : </span>
                                                <br />
                                                <span class="description">
                                                    <%=donotresumeDesc %></span>
                                                <br />
                                                <br />
                                                <span class="note"><strong>
                                                    <%=publishNote %>:</strong>
                                                    <%=donotresumeNoteDesc %></span>
                                            </td>
                                            <td style="width:28%">
                                                <asp:Button ID="DontResume" runat="server" Text="" OnClick="DontResume_Click" CssClass="inputbutton"
                                                   />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <%--<tr>
                                <td>
                                    <img src="<%=themePath%>SkeltaForms/images/spacer.gif"  alt="" width="1" height="1" />
                                </td>
                            </tr>--%>
                            <tr>
                                <td  style="height:65px">
                                    <table style="width:100%; border-width:0;border-spacing:0" >
                                        <tr>
                                            <td style="padding:15px">
                                                <span class="subtitle">
                                                    <%=cancelHeader %>: </span>
                                                <br />
                                                <span class="description">
                                                    <%=cancelDesc %></span>
                                            <td style="width:30%;padding-left:15px">
                                                <asp:Button ID="Cancel" runat="server" Text="" OnClientClick="javascript:closeWindow(true);return false;"
                                                    CssClass="inputsecondarybutton" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="ErrorsPanel" runat="server" Visible="false">
           
            <table style="height: 410; width: 100%;border-width:0;border-spacing:1;vertical-align:top" >
                <tr>
                    <td  style="vertical-align:top">
                        <ISWebGrid:WebGrid ID="ErrorDetailsView" runat="server" Height="410px" Width="100%"
                            HorizontalAlign="NotSet" AllowAutoDataCaching="false" DataCacheStorage="PageCache"
                            DisableFileSystemChecking="true" EnableWebResources="never">
                            <LayoutSettings StatusBarVisible="false" AlternatingColors="True" CellPaddingDefault="2"
                                GridLineColor="221, 236, 254" AlwaysShowHelpButton="False" AllowFilter="Yes"
                                AllowGrouping="Yes" AutoFitColumns="true" GridLineStyle="Solid" RowHeightDefault="20px"
                                AllowColumnSizing="Yes" Hierarchical="True" GridLines="Vertical" AllowColumnMove="Yes"
                                AllowExport="Yes" AllowSelectColumns="yes" FilterBarVisible="False">
                                <ClientSideEvents OnInitialize="grd1_Init" OnRowContextMenu="WebGrid1_OnRowContextMenu" />
                                <HeaderStyle CssClass="GridHeaderStyle" CustomRules="border-bottom: #73A1E4 1px solid; -moz-boz-flex: 0"
                                    Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" Wrap="False"></HeaderStyle>
                                <FocusCellStyle CssClass="GridFocusCellStyle" />
                                <StatusBarCommandStyle>
                                    <Active BackColor="RoyalBlue" BaseStyle="Over">
                                    </Active>
                                    <Over BackColor="#FBE9B8" BorderColor="#002D96" BorderStyle="Solid" BorderWidth="1px">
                                    </Over>
                                    <Normal>
                                        <Padding Bottom="1px" Left="1px" Right="1px" Top="1px" />
                                    </Normal>
                                </StatusBarCommandStyle>
                                <GroupRowInfoStyle BorderColor="Black" BorderStyle="None" Font-Names="Verdana" Font-Size="8pt"
                                    BackgroundImage="<%$ ReplaceTemplateExpn:hws/Images/ColBk.gif%>" CustomRules="border-bottom: #73A1E4 1px solid">
                                </GroupRowInfoStyle>
                                <GroupByBox>
                                    <LabelStyle BackColor="White" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px"
                                        Font-Names="Verdana" Font-Size="8pt" />
                                    <Style BackColor="Gray"></Style>
                                </GroupByBox>
                                <EditTextboxStyle BorderStyle="None" BorderWidth="0px" Font-Names="Verdana" Font-Size="8pt">
                                </EditTextboxStyle>
                                <FrameStyle CssClass="GridFrameStyle">
                                </FrameStyle>
                                <SelectedRowStyle CssClass="GridSelectedRowStyle" />
                                <AlternatingRowStyle CssClass="GridAlternatingRowStyle" CustomRules="text-overflow: clip; "
                                    Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" Wrap="False" />
                                <StatusBarStyle CssClass="GridStatusBarStyle">
                                    <Padding Bottom="2px" Left="2px" Right="2px" Top="2px" />
                                </StatusBarStyle>
                                <RowStyle CssClass="GridRowStyle" CustomRules="text-overflow: clip;" Overflow="Hidden"
                                    OverflowX="Hidden" OverflowY="Hidden" Wrap="False" />
                                <NewRowStyle CssClass="GridNewRowStyle">
                                </NewRowStyle>
                                <EditFocusCellStyle CssClass="GridEditFocusCellStyle">
                                </EditFocusCellStyle>
                                <TextSettings Language="UseCulture">
                                </TextSettings>
                            </LayoutSettings>
                            <RootTable GridLineStyle="NotSet" HeaderClickAction="SortSingle" AllowGrouping="Yes">
                            </RootTable>
                        </ISWebGrid:WebGrid>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        
    </div>
         <table style="border-width:0;border-spacing:0;width:100%">
            <tr>
                <td style="text-align:right;padding-top: 13px;padding-right:10px;">
                    <asp:Button ID="CloseButton" runat="server" Text="" OnClick="CloseButton_Click" Visible="false"
                        CssClass="inputbutton"/>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
