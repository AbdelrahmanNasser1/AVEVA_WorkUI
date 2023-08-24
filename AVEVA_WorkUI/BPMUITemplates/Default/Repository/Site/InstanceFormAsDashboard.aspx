<%@ page language="C#" autoeventwireup="true" inherits="InstanceForm" enableviewstate="false"
    masterpagefile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master"
    enableeventvalidation="false" %>

<asp:content id="Content3" contentplaceholderid="MenuTitle" runat="server"> 
    <div>		
         <%=skrm.GlobalResourceSet.GetString(menuTitle)%>							
    </div>
</asp:content>


<asp:content id="Content1" contentplaceholderid="Cont" runat="Server">
    <!DOCTYPE html>    
    <script>
        function GetRadWindow()
        {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement)
            {
                if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow;
                else
                    window.location.reload();
            }
            return oWindow;
        }
        function SizeToFit()
        {
            if (window.radWindow)
            {
                try
                {
                    var oWnd = GetRadWindow();
                    oWnd.setSize(850, 650);
                }
                catch (err)
                {
                }
            }
        }
    </script>
    <body onload="SizeToFit()" bgcolor="#ffffff" style="height: 100%; width: 100%; font-size: 9px;
        border: none; margin: 0px 0px 0px 0px; padding: none;" leftmargin="0px" topmargin="0px"
        rightmargin="0px" bottommargin="0px" scroll="no">
        <script type="text/javascript">
            function OpenDSWindow(controlId)
            {
                var u = _TemplateDirectorySkeltaForms + "Lookuplist.aspx?sfdcontainer=" + escape(controlId);
                var oWindow1 = window.radopen(u, null);
                oWindow1.setSize(parseInt(document.body.clientWidth / 2), parseInt(document.body.clientHeight / 1.5));
                oWindow1.set_left(500);
                return oWindow1;
            }
        </script>
        <div style="height: 100%; width: 100%;">
		    <asp:Panel ID="pnl1" runat="server">
            </asp:Panel>
            <iframe id="frame" runat="server" style="visibility:hidden; display:none;"></iframe>
        </div>
    </body>
    <script type="text/javascript">
        
    try
    {
        document.getElementById("tblMain").style.display = "none";
    }
    catch (ex)
    {

    }


    </script>
</asp:content>

