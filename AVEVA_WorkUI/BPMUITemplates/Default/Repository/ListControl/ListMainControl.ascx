<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ListMainControl" %>
<%@ Register Src="ListHeader.ascx" TagName="ListHeader" TagPrefix="uc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


<script type="text/javascript">
    var ListControlId = '<%=ControlId%>';
    var onclientCalled = null;
    // To pass the ListControlClientId to menu.js for BreadCrumb
    var ListControlClientId = '<%=ListControlClientId %>';
    var parentListId = '<%=mainListId %>';
    // This can be used as dictionary to hold seperate breadcrumb, count and arrays for each listcontrol instance.
    var breadCrumbObject = new Object();
    var breadCrumbArr = new Array(25);
    var breadCrumbTemp = "";
    var cnt = 0;
    var breadCrumbClientId = '';
    var directoryForBreadCrumbImage = '<%=_ListControl.TemplateDirectory %>';
    function getXMLHttpRequest()
    {
        if (window.XMLHttpRequest)
        {
            return new window.XMLHttpRequest;
        }
        else
        {
            try
            {
                return new ActiveXObject("MSXML2.XMLHTTP.3.0");
            }
            catch (ex)
            {
                return null;
            }
        }
    }

    function S4()
    {
        return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    }
    function getguid()
    {
        return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
    }

    function OnClientClose(radWindow)
    {
        if (window.onclientCalled !== null)
        {
            if (onclientCalled == true)
            {
                return;
            }

            onclientCalled = true;
        }

        try
        {

            // this function will get on every close of the radwindow.. this is leveraged for unlock. if the hidfield exist with unlock flag then unlock else ignore unlock and do grid refresh
            var hidItemId = radWindow.get_contentFrame().contentWindow.document.getElementById("hiditemid");
            var hidListId = radWindow.get_contentFrame().contentWindow.document.getElementById("hidlistid");
            var hidunlock = radWindow.get_contentFrame().contentWindow.document.getElementById("hidunlock");

            if (hidItemId == null)// dont consider unlock
            {
                document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
                document.body.scroll = "no";
                document.body.style.overflow = "hidden";
                try 
                {
                    document.body.focus();
                }
                catch (e) 
                {

                }
            }
            else
            {              
                var unlock;
                if (hidItemId != null)// consider unlock
                {
                    var unlock;
                    var itemid = hidItemId.value;
                    var listid = hidListId.value;
                    var tempId = getguid();
                    if (hidunlock == null || hidunlock == "")
                    {
                        unlock = "true";
                    }
                    else
                    {
                        unlock = hidunlock.value;
                        if (unlock == "")
                        {
                            unlock = "true";
                        }
                    }
                    //unlock = "false";
                    if (unlock == "true")
                    {                       
                        
                        var url = "<%=_ListControl.TemplateDirectory %>Repository/Site/UnLock.aspx?listid=" + listid + "&itemid=" + itemid + "&tempid=" + tempId;
                        
                        if (navigator && navigator.sendBeacon)
                        {
                            navigator.sendBeacon(url, null);
                        }
                        else
                        {
                            var oReq = getXMLHttpRequest();
                            oReq.open("GET", url, false);
                            oReq.send(null);
                        }
                    }
                }
                document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
                document.body.scroll = "no";
                document.body.style.overflow = "hidden";
            }
        }
        catch (e)
        {
        }
    }

    function BellybarMessageAlert(displayMsg)
    {
        document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.BellybarMessageAlert(displayMsg);

    }
    function BellybarMessageError(displayMsg)
    {
        document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.BellybarMessageError(displayMsg);

    }

    function GetRadWindowManagerForListControl() {
        return $find("<%=RadWindowManager1.ClientID%>");
    }



</script>
<script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
<link href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
 <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
<body style="margin: 0; margin-top: 0; margin-left: 0; margin-right: 0; height: 100%;">

    <asp:Panel ID="Panel2" runat="server" Height="100%" Width="100%">
        <table style="height: 100%; width: 100%; border-width: 0; border-spacing: 0">
            <tr style="width: 100%;">
                <td style="width: 100%; height: 3%; padding-top: 0px;">
                    <asp:Panel ID="Panel1" runat="server" Width="100%" Visible="false" style="overflow:auto;">
                    </asp:Panel>
                </td>
            </tr>
            <tr style="width: 100%;">
                <td id="mainframtd" runat="server" style="height: 100%; width: 100%; vertical-align: top;padding:0px;">
                    <iframe id="mainframe" name="mainframe" src="<%=GetSecureUrl("ListGridPage.aspx")%>"
                        width="100%" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; border-top-style: none; padding-top: 0px; border-right-style: none; border-left-style: none; border-bottom-style: none; height: 100%; overflow-y: hidden;"></iframe>
                    <%--scrolling="auto" In Firefox, it is giving unnecessary vertical scrollbars--%>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <script type="text/javascript">

        //Setting up the main frame under which the List data (Grid) will come
        var hgt = screen.availHeight;
        var wdt = screen.availWidth;
        var clientHeight = '<%=ListControlHeight%>';
        
        var panelClientID = "<%=Panel2.ClientID %>";
      
        if (parseInt(clientHeight) == 0)
        {
            if (panelClientID.indexOf("WebPartManager", 0) == -1)
            { // If it is in web part page, it should not set default page size
                if (navigator.appName == 'Netscape')
                {
                    if (parentListId == "00000000-0000-0000-0000-000000000000")
                    {
                        document.getElementById(panelClientID).style.height = hgt - 88;  //118;
                    }
                    else
                    {
                        document.getElementById(panelClientID).style.height = hgt - 288;
                    }
                }
                else
                    document.getElementById(panelClientID).style.height = hgt - 60;
            }

            document.getElementById(panelClientID).scrolling = "no";
        }
        else
        {
            if (clientHeight > 15)
            {
                document.getElementById(panelClientID).style.height = clientHeight - 12;
            }
        }
        
        function listControlHeightInPercentage()
        {
            var controlHeight = '<%=ListControlHeight%>';
            if (parseInt(controlHeight) > 0)
            {
                document.getElementById("<%=Panel2.ClientID %>").style.height = document.body.clientHeight * controlHeight / 100;
            }
        }

        function GetFrame(frameTd)
        {
            // In firefox, firstChild is returning some space. In firefox it is the second child instead, but in IE it is the first child
            var frame = frameTd.firstChild;
            if (frame.id == "mainframe")
                return frame;
            for (var i = 0; i < frameTd.childNodes.length; i++)
            {

                if (frameTd.childNodes[i] != null || frameTd.childNodes[i] != 'undefined')
                {
                    if (frameTd.childNodes[i].id == "mainframe")
                    {
                        frame = frameTd.childNodes[i];
                        return frame;
                    }
                }
            }
        }

        // This function will be called if ShowListView property is false
        function OnLoad_<%=_ListControl.ClientID%>_View(viewName, CanEditView)
        {
            var frameTd = document.getElementById('<%=mainframtd.ClientID %>');
            var frame = GetFrame(frameTd);
            if (frame != null)
            {
                var src = frame.attributes['src'].value;
                var gridString = src.split('&')[0];
                frame.attributes['src'].value = gridString + '&vn=' + viewName;
            }
        }

        function LoadView_<%=_ListControl.ClientID%>(dropDownId)
        {
            try 
            {

                var frameTd = document.getElementById('<%=mainframtd.ClientID %>');
                var frame = GetFrame(frameTd);
                var dd = window.document.getElementById(dropDownId);
                var viewId = dd.value;

                if (viewId == 'nv')
                    document.getElementById('btnGo').style.visibility = 'hidden';
                else
                    document.getElementById('btnGo').style.visibility = 'visible';
                if (viewId != 'cv') 
                {
                    var vn = dd[dd.selectedIndex].text;
                    if (frame != null) 
                    {
                        var src = frame.attributes['src'].value;
                        var gridString = src.split('&')[0];
                        var dynamicListQueryString = parent.location.search;
                        var queryString = '';
                        //Checking for whether it is IDE or not
                        var isIde = false;
                        try
                        {
                            if (window.parent.parent.location.href.indexOf('FromArchestrA') != -1)
                            {
                                isIde = true;
                            }
                        }
                        catch (ex)
                        { }

                        // For User lists; a seperate querystring for the main page is provided
                        if ((dynamicListQueryString == null || dynamicListQueryString == '' || dynamicListQueryString == 'undefined') && (gridString == null || gridString == '' || gridString == 'undefined'))
                        {
                            queryString = '?vn=' + vn;
                        }
                        else
                        {
                            if (dynamicListQueryString.indexOf('&') > 0) 
                            {
                                var finalQString = dynamicListQueryString.split('&')[0];
                                queryString = finalQString + '&vn=' + vn;
                            }
                            else if (dynamicListQueryString.indexOf('wcuri') > 0 || dynamicListQueryString.indexOf('ListName') > 0)
                            {
                                queryString = dynamicListQueryString + '&vn=' + vn;
                            }
                            else if (gridString.indexOf('lcsuri') > 0) // This is required for web parts, otherwise it will throw exception
                            {
                                queryString = '&vn=' + vn;
                            }
                            else
                            {
                                queryString = '?vn=' + vn;
                            }
                        }


                        //For handling the passing of Archestra flag based on the environment
                        if (isIde)
                            queryString = queryString + '&FromArchestrA=true';

                        if (frameTd.id.indexOf("WebPartManager", 0) !== -1) 
                        {
                            // If it is in web part page, it should not set default page size
                            frame.attributes['src'].value = gridString + queryString;
                        }
                        else
                        {
                            parent.location.search = queryString;
                        }

                        frame.contentWindow.document.getElementById('gridframe').contentWindow.ResetBreadCrumbVariables();
                    }
                }

            } catch (e) { }
        }
    </script>    

    <telerik:RadWindowManager ID="RadWindowManager1"  Skin="AWTWindow" EnableEmbeddedSkins="false" 
         runat="server" RenderMode="Classic" VisibleStatusbar="false" OnClientClose="OnClientClose" ShowOnTopWhenMaximized="false"> 
        <Windows>
            <telerik:RadWindow ID="ECWindow" runat="server" Behaviors="Minimize,Close,Maximize,Reload" ReloadOnShow="false" ShowContentDuringLoad="false" >
            </telerik:RadWindow>
            <telerik:RadWindow ID="WindowCloseBehaviour" runat="server" Behaviors="Close" ReloadOnShow="false" ShowContentDuringLoad="false" ShowOnTopWhenMaximized="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="ChildWindow" runat="server" Behaviors="Close" ReloadOnShow="false" ShowContentDuringLoad="false">
            </telerik:RadWindow>
        </Windows>
      </telerik:RadWindowManager>
</body>
