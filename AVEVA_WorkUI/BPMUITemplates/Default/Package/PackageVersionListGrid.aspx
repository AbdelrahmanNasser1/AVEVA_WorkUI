<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.PackageVersionListGrid" %>
<!DOCTYPE html >
<html>
<head id="Head1" runat="server">
    <title></title>
    <style>
        html, body {
            height: 100%;
        }
    </style>
      <script type="text/javascript" src="../CommonUXControls/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="../CommonUXControls/scripts/jquery.easing.1.3.js"></script>  
    <script type="text/javascript" src="../CommonUXControls/scripts/ActionBar/actionbar.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
      <body>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <form id="form2" runat="server" style="height:100%">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link rel="stylesheet" type="text/css" href="<%=themeDirectory%>CommonUXControls/StyleSheet/UXControls.css">
       <div style="width: 100%; height: 100%;margin:0px;overflow:hidden;" id="ribbondiv">
                 <div id="divRibbonBar" style="overflow:hidden;">
                    <asp:Panel ID="panel1" runat="server" Width="100%" Height="100%">
                    </asp:Panel>
                </div>
                <div id="divgridpage">
                    <iframe id="gridframe" src="<%=GetPagePath("PackageVersionGrid.aspx")%>" visible=true
                     style="height:100%;width:100%;padding-right:0px;
                     padding-left: 0px; padding-bottom: 0px; margin: 0px; border-style:none;border-top-style:none;
                     padding-top: 0px; border-right-style: none; border-left-style: none; border-bottom-style:none;overflow:hidden;"></iframe>
                </div>
          </div>
    </form>

    <script  type="text/javascript">
        try {
            if (navigator.userAgent.toLowerCase().indexOf('msie') > 0)
                document.getElementById("divgridpage").style.height = document.getElementById("ribbondiv").scrollHeight - document.getElementById("divRibbonBar").scrollHeight - 35 + 'px';
            else
                document.getElementById("divgridpage").style.height = document.getElementById("ribbondiv").scrollHeight - document.getElementById("divRibbonBar").scrollHeight + 'px';
            document.getElementById("divRibbonBar").style.width = document.getElementById("<%=panel1.ClientID%>").scrollWidth + 'px';
            document.getElementById("gridframe").style.width = document.getElementById("<%=panel1.ClientID%>").scrollWidth + 'px';
        }
        catch (e) {

        }
    </script>

</body>
</html>

