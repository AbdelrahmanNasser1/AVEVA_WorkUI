<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.FormVersionListGrid" %>
<!DOCTYPE html >
  <html>
<head runat="server">
    <title></title>
    <style>
        html, body {
            height: 100%;
        }
    </style>
     <script type="text/javascript" src="../../CommonUXControls/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="../../CommonUXControls/scripts/jquery.easing.1.3.js"></script>  
    <script type="text/javascript" src="../../CommonUXControls/scripts/ActionBar/actionbar.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>
      <body>
    <form id="form2" runat="server" style="height:100%">
        <link rel="stylesheet" type="text/css" href="<%=themeDirectory%>CommonUXControls/StyleSheet/UXControls.css"> 
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
       <div style="width: 100%; height: 100%;margin:0px;overflow:hidden;" id="ribbondiv">
                 <div id="divRibbonBar" style="overflow:hidden;">
                    <asp:Panel ID="Panel1" runat="server" Width="100%" Height="100%">
                    </asp:Panel>
                </div>
                <div id="divgridpage">
                    <iframe id="gridframe" src="<%:GetSecureUrl("FormVersionGrid.aspx")%>" visible=true
                     style="height:100%;width:100%;  padding-right: 0px;
                     padding-left: 0px; padding-bottom: 0px; margin: 0px; border-style:none;border-top-style: none;
                     padding-top: 0px; border-right-style: none; border-left-style: none; border-bottom-style: none;overflow:hidden;"></iframe>
                </div>
          </div>
    </form>

    <script  type="text/javascript">
        try {
            if (navigator.userAgent.toLowerCase().indexOf('msie') > 0)
                document.getElementById("divgridpage").style.height = document.getElementById("ribbondiv").scrollHeight - document.getElementById("divRibbonBar").scrollHeight - 35 + 'px';
            else
                document.getElementById("divgridpage").style.height = document.getElementById("ribbondiv").scrollHeight - document.getElementById("divRibbonBar").scrollHeight + 'px';
            document.getElementById("divRibbonBar").style.width = document.getElementById("<%=Panel1.ClientID%>").scrollWidth + 'px';
            document.getElementById("gridframe").style.width = document.getElementById("<%=Panel1.ClientID%>").scrollWidth + 'px';
        }
        catch (e) {

        }
    </script>

</body>
</html>

