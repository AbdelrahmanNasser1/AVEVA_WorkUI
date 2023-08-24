<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ListGridPage" %>
<!DOCTYPE html >
<html>
<head runat="server">

    <title></title>
    <style>
       html, body
        {
            height: 100%;
        }

    </style>

    <script type="text/javascript" src="../../CommonUXControls/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="../../CommonUXControls/scripts/jquery.easing.1.3.js"></script>  
    <script type="text/javascript" src="../../CommonUXControls/scripts/ActionBar/actionbar.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
      
      
</head>
    
<body style="margin:0px">
    <form id="form1" runat="server" style="height: 100%">   
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link rel="stylesheet" type="text/css" href="<%=themeDir%>CommonUXControls/StyleSheet/UXControls.css"> 
        <div style="width: 100%; height: 100%;margin:0px;overflow-x:auto; overflow-y:hidden;" id="ribbondiv">
            <div id="divRibbonBar"  >                
                <asp:Panel ID="Panel1" runat="server" Width="100%" Height="15%">
                </asp:Panel>                 
            </div>
           
            <div id="divgridpage"> 
                <iframe id="gridframe" src="<%=GetSecureUrl("Grid.aspx")%>" visible="true" 
                    style="height:100%;width:100%; padding-right: 0px;
                    padding-left: 0px; padding-bottom: 0px; margin: 0px; border-style:none;border-top-style: none;
                    padding-top: 0px; border-right-style: none; border-left-style: none; border-bottom-style: none;overflow:hidden;" >
                </iframe>
                <asp:HiddenField ID="hdnListId" EnableViewState="true" runat="server" />
            </div>
        </div>
        
        
    <script type="text/javascript">



        if (window.parent.location.href.indexOf('ViewWorkflowAssociations.aspx') > 0) {
            document.body.scroll = 'no';
        }

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

        //SetGridHeight();
        function SetGridHeight() {
            if (navigator.appName == "Microsoft Internet Explorer")
            {                
                document.getElementById("gridframe").style.height = "90%";
            }
            else {

                document.getElementById("ribbondiv").style.marginBottom = "5px";
                document.getElementById("griddiv").style.marginTop = "5px";
                document.getElementById("gridframe").style.height = "99%";              

            }
        }


        function getMaxHeight() {
            var h = 0;
            if (parent.window.document.innerHeight > h)
                h = parent.window.document.innerHeight;
            if (parent.window.document.documentElement.clientHeight > h)

                h = parent.window.document.documentElement.clientHeight;
            if (parent.window.document.body.clientHeight > h)
                h = parent.window.document.body.clientHeight;
            return h;
        }

        // Returns the current ListId 
        function getListId() {
            return document.getElementById("hdnListId").value;
            //        return document.getElementById("mainframe").contentWindow.document.getElementById("hdnListId").Value;
        }





    </script>
    </form>
</body>
</html>
