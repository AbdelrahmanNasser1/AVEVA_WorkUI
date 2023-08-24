<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.HWS.WorkListChannel.Web.UserControls.ActivityUIDropDownControlClass" %>
<link rel="stylesheet" type="text/css" href="<%:themeTemplateDirectory+"common/StyleSheet/Global.css"%>" />

<style type="text/css">
    #workitemnotesspan > p
    {
        margin: 0 !important;
    }
</style>

<!-- This div gets closed from the code-->
<div id="divworklistui" style="position: relative; visibility: visible; background-color: #ffffff;">
    <div id="divactivityuicommon" style="display: block;">
        <table style="width: 100%; border-spacing: 0px;" class="TableBg" id="tableDivActDrop">
            <tr>
                <td style="vertical-align: top; padding: 5px;" class="lefttdbg">
                    <table style="width: 100%;">
                        <tr>
                            <%if(EnableMoveNextWorkitem || EnableAutoMoveWorkitem ){ %>

                            <td style="height: 100%; vertical-align: top;">

                                <%if (EnableMoveNextWorkitem){ %>
                                <img id="imgPrevious" src="<%:themeTemplateDirectory%>/WorkItemList/images/icon-previous.png" alt="<%=_ResourceManager.GlobalResourceSet.GetString("WIL_Previous")%>" title="<%=_ResourceManager.GlobalResourceSet.GetString("WIL_Previous")%>" onclick="javascript:MovePrevious()" />
                                <img id="imgNext" src="<%:themeTemplateDirectory%>/WorkItemList/images/icon-next.png" alt="<%=_ResourceManager.GlobalResourceSet.GetString("WIL_Next")%>" title="<%=_ResourceManager.GlobalResourceSet.GetString("WIL_Next")%>" onclick="javascript:MoveNext()" />
                                <%} %>
                                <%if(EnableAutoMoveWorkitem){ %>
                                <input type="checkbox" id="chkMoveNext" value="check" onclick="GetMoveNextVal()" checked class="inputcheckbox" />
                                <span class="description">Show next work item on submission</span>
                                <%} %>
                            </td>

                            <%} %>
                            <%if (CommentStart == "") {%>
                            <td style="width: 30%; text-align: right; white-space: nowrap;" class="description">
                                <%=CommentStart %><%=strManageWorkItem%>: (<%=ActivityName%>)<b>:</b>
                                <asp:DropDownList runat="server" CssClass="inputselect" ID="SelectCommonActionType">
                                </asp:DropDownList>
                                <input type="submit" class="inputbutton" name="ButtonGo" value=" <%=strbtnGo%> " onclick="return Go_Submit()" />
                                <%=CommentEnd%>
                            </td>

                            <%} %>
                        </tr>
                        <%if(Subject !="") { %>
                        <tr>
                            <td colspan="2" style="vertical-align: top; text-align: left" class="description">
                                <div id="workitemsubjectdiv" style="overflow: auto;height: 30px; padding-left: 5px;">
                                    <span class="SubjectFont"><%=_ResourceManager.GlobalResourceSet.GetString("Subject")%> : <%=Subject%></span>
                                </div>
                            </td>
                        </tr>
                        <%} %>
                        <%if (Notes != "")
                                { %>
                        <tr>
                            <td colspan="2" style="vertical-align: top; text-align: left" class="description">
                                <div id="workitemnotesspan" style="overflow: auto; height: 30px; padding-left: 5px;"><%=_ResourceManager.GlobalResourceSet.GetString("Body")%> :<%=Notes%></div>
                            </td>
                        </tr>
                        <%} %>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <b><%:errorMessage%></b>
    <%--<div id="workitemnotesdiv" style='display:block;padding-left:15px;'>
        <table style="width:100%;border-collapse:separate;border-spacing:2px;">
		    <tr>
			    <td colspan="3"  style="vertical-align:top;" class="description">
			      			        
                </td>
			</tr>			
		</table>
	</div>--%>


    <% if(CheckActivityType=="Invoke Form") {%>
</div>
<%} %>
<span id="workitemdocviewset" style="visibility: hidden"><%=IsDocumentViewWindowSet%></span>
<script>

    workItemId = "<%=workItemId %>";
    application = "<%=application %>";
    workflow = "<%=workflow %>";
    channel = "<%=channel %>";
    form = "<%=form %>";
    encryptedQueryString = "<%=encryptedQueryString %>";
    templatedirectory = "<%=templatedirectory%>";
    function Go_Submit()
    {
        var sel = document.getElementById("<%=selcontrolname%>_SelectCommonActionType");
        switch (sel.value)
        {
            case "Take Ownership":
                return true;
                break;
            case "Hold":
                return true;
                break;
            case "Reassign":
                //openWorkItemUINewWindow(1,workItemId,application,workflow,channel,form,encryptedQueryString);
                openReassign(templatedirectory, encryptedQueryString);
                return false;
                break;
            case "View All Users":
                openWorkItemUINewWindow(2, workItemId, application, workflow, channel, form, encryptedQueryString);
                return false;
                break;

        }
    }
    var mywindow = "";
    function openReassign(templatedirectory, encryptedQueryString)
    {

        var left = (screen.width / 2) - (680 / 2);
        var top = (screen.availHeight / 2) - (550 / 2);
        var url = templatedirectory + "WorkItemList/ReAssignWorkItem.aspx";
        mywindow = window.open(url + encryptedQueryString + '&openfrom=detview', "ReAssignWorkItem", "location=0, status=0, scrollbars=0, width=680, height=550, resizable=yes,top=" + top + ", left=" + left);
        // mywindow.moveTo(0, 0);
    }
    function RefreshGridfromdetview()
    {

        if (typeof (window.opener) != 'undefined')
        {

            mywindow.close();
            self.close();
            window.opener.parent.RefreshGridfromdetwindow();
        }
        else
        {
            mywindow.close();
            window.parent.RefreshGridfromdetwindow();


        }
        //top.RefreshGridfromdetwindow();
    }

    function GetBrowserversion()
    {
        var app = navigator.userAgent;
        if (app.indexOf("MSIE") > -1)
        {
            return 1;
        }
        else if (app.indexOf("Firefox/1.5") > -1)
        {
            return 2;
        }
        else
        {
            return 3;
        }
    }

    function MoveNext()
    {

        if (typeof (window.opener) != 'undefined' && window.opener != null && window.opener != 'undefined')
        {
            //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to true.
            try
            {
                window.opener.parent.MoveNextWorkItemRecord();
            }
            catch (err)
            {

                if (GetBrowserversion() == 1)
                {
                    if (err.description.indexOf("The RPC server") >= 0 || err.description.indexOf("The interface") >= 0)
                    {
                        alert("<%=strParentWindowClosed%>");
                }
            }
            else
            {
                alert("<%=strParentWindowClosed%>");
            }
        }
    }
    else if (typeof (parent.top.GetRadWindow) != 'undefined' && parent.top.GetRadWindow != 'undefined' && parent.top.GetRadWindow != null)
    {
        //For Invoke Form with ReadingPaneInPopUpWindow is set to true.
        try
        {
            parent.top.MoveNextWorkItemRecord();
        }
        catch (err)
        {
            if (GetBrowserversion() == 1)
            {
                if (err.description.indexOf("The RPC server") >= 0 || err.description.indexOf("The interface") >= 0)
                {
                    alert("<%=strParentWindowClosed%>");
                }
            }
            else
            {
                alert("<%=strParentWindowClosed%>");
            }
        }
    }
    else if (typeof (parent.GetRadWindow) != 'undefined' && parent.GetRadWindow != 'undefined' && parent.GetRadWindow() != 'undefined' && parent.GetRadWindow() != null)
    {
        //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to true.
        try
        {
            parent.MoveNextWorkItemRecord();
        }
        catch (err)
        {
            if (GetBrowserversion() == 1)
            {
                if (err.description.indexOf("The RPC server") >= 0 || err.description.indexOf("The interface") >= 0)
                {
                    alert("<%=strParentWindowClosed%>");
                }
            }
            else
            {
                alert("<%=strParentWindowClosed%>");
            }
        }
    }
    else if (typeof (window.parent.opener) != 'undefined')
    {

        try
        {
            //For Invoke Form Activity with ReadingPaneInPopupWindow is set to true.
            window.parent.opener.MoveNextWorkItemRecord();
        }
        catch (err)
        {

            if (GetBrowserversion() == 1)
            {
                if (err.description.indexOf("The RPC server") >= 0 || err.description.indexOf("The interface") >= 0)
                {
                    alert("<%=strParentWindowClosed%>");
                }
                else
                {
                    //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to false. 
                    window.parent.MoveNextWorkItemRecord();
                }
            }
            else
            {

                if (window.parent.opener == null) //For Invoke form in readingpaneinpopwindow=false
                {

                    if (typeof (window.parent.top.MoveNextWorkItemRecord) == 'undefined')
                    {
                        alert("<%=strParentWindowClosed%>");
                    }
                    else
                    {
                        window.parent.top.MoveNextWorkItemRecord();
                    }
                }
                else
                {
                    window.parent.MoveNextWorkItemRecord();
                }
            }
        }
    }

    else
    {
        try
        {
            //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to false. 
            window.parent.MoveNextWorkItemRecord();
        }
        catch (err)
        {

            //For Invoke Form Activity with ReadingPaneInPopupWindow is set to false.
            window.parent.top.MoveNextWorkItemRecord();
        }
    }
}

function MovePrevious()
{
    if (typeof (window.opener) != 'undefined' && window.opener != null && window.opener != 'undefined')
    {
        try
        {
            //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to true.
            window.opener.parent.MovePreviousWorkItemRecord();
        }
        catch (err)
        {
            if (GetBrowserversion() == 1)
            {
                if (err.description.indexOf("The RPC server") >= 0 || err.description.indexOf("The interface") >= 0)
                {
                    alert("<%=strParentWindowClosed%>");
                }
            }
            else
            {
                alert("<%=strParentWindowClosed%>");
            }

        }
    }
    else if (typeof (parent.top.GetRadWindow) != 'undefined' && parent.top.GetRadWindow != 'undefined' && parent.top.GetRadWindow != null)
    {
        //For Invoke Form with ReadingPaneInPopUpWindow is set to true.
        try
        {
            parent.top.MovePreviousWorkItemRecord();
        }
        catch (err)
        {
            if (GetBrowserversion() == 1)
            {
                if (err.description.indexOf("The RPC server") >= 0 || err.description.indexOf("The interface") >= 0)
                {
                    alert("<%=strParentWindowClosed%>");
                }
            }
            else
            {
                alert("<%=strParentWindowClosed%>");
            }
        }
    }
    else if (typeof (parent.GetRadWindow) != 'undefined' && parent.GetRadWindow() != 'undefined' && parent.GetRadWindow() != null)
    {
        try
        {
            //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to true.
            parent.MovePreviousWorkItemRecord();
        }
        catch (err)
        {
            if (GetBrowserversion() == 1)
            {
                if (err.description.indexOf("The RPC server") >= 0 || err.description.indexOf("The interface") >= 0)
                {
                    alert("<%=strParentWindowClosed%>");
                }
            }
            else
            {
                alert("<%=strParentWindowClosed%>");
            }

        }
    }
    else if (typeof (window.parent.opener) != 'undefined')
    {
        try
        {
            //For Invoke Form Activity with ReadingPaneInPopupWindow is set to true.      
            window.parent.opener.MovePreviousWorkItemRecord();
        }
        catch (err)
        {
            if (GetBrowserversion() == 1)
            {
                if (err.description.indexOf("The RPC server") >= 0 || err.description.indexOf("The interface") >= 0)
                {
                    alert("<%=strParentWindowClosed%>");
                }
                else
                {
                    //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to false. 
                    window.parent.MovePreviousWorkItemRecord();
                }
            }
            else
            {
                if (window.parent.opener == null)
                {
                    if (typeof (window.parent.top.MovePreviousWorkItemRecord) == 'undefined')
                    {
                        alert("<%=strParentWindowClosed%>");
                    }
                    else
                    {
                        window.parent.top.MovePreviousWorkItemRecord();
                    }
                }
                else
                {
                    window.parent.MovePreviousWorkItemRecord();
                }
            }
        }
    }

    else
    {
        try
        {
            //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to false. 
            window.parent.MovePreviousWorkItemRecord();
        }
        catch (err)
        {
            //For Invoke Form Activity with ReadingPaneInPopupWindow is set to false.
            window.parent.top.MovePreviousWorkItemRecord();
        }
    }

}

function GetMoveNextVal()
{
    if (typeof (window.opener) != 'undefined' && window.opener != null && window.opener != 'undefined')
    {
        //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to true.
        if (document.getElementById("chkMoveNext").checked)
        {
            window.opener.document.getElementById("hidMoveNextCheckValue").value = "true";
        }
        else
        {
            window.opener.document.getElementById("hidMoveNextCheckValue").value = "false";
        }
    }
    else if (typeof (parent.top.GetRadWindow) != 'undefined' && parent.top.GetRadWindow != 'undefined' && parent.top.GetRadWindow != null)
    {
        if (document.getElementById("chkMoveNext").checked)
        {
            parent.top.document.getElementById("hidMoveNextCheckValue").value = "true";
        }
        else
        {
            parent.top.document.getElementById("hidMoveNextCheckValue").value = "false";
        }
    }
    else if (typeof (parent.GetRadWindow) != 'undefined' && parent.GetRadWindow() != 'undefined' && parent.GetRadWindow() != null)
    {
        //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to true.
        if (document.getElementById("chkMoveNext").checked)
        {
            parent.document.getElementById("hidMoveNextCheckValue").value = "true";
        }
        else
        {
            parent.document.getElementById("hidMoveNextCheckValue").value = "false";
        }
    }
    else if (typeof (window.parent.opener) != 'undefined')
    {
        if (document.getElementById("chkMoveNext").checked)
        {
            try
            {
                //For Invoke Form Activity with ReadingPaneInPopupWindow is set to true.              
                window.parent.opener.document.getElementById("hidMoveNextCheckValue").value = "true";
            }
            catch (err)
            {
                //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to false. 
                window.parent.document.getElementById("hidMoveNextCheckValue").value = "true";
            }
        }
        else
        {
            try
            {

                //For Invoke Form Activity with ReadingPaneInPopupWindow is set to true.                     
                window.parent.opener.document.getElementById("hidMoveNextCheckValue").value = "false";
            }
            catch (err)
            {

                //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to false. 
                window.parent.document.getElementById("hidMoveNextCheckValue").value = "false";
            }
        }
    }
    else
    {
        if (document.getElementById("chkMoveNext").checked)
        {
            try
            {
                //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to false. 
                window.parent.document.getElementById("hidMoveNextCheckValue").value = "true";
            }
            catch (err)
            {
                //For Invoke Form Activity with ReadingPaneInPopupWindow is set to false.
                window.parent.top.document.getElementById("hidMoveNextCheckValue").value = "true";
            }
        }
        else
        {
            try
            {
                //For Human Activities except Invoke Form with ReadingPaneInPopUpWindow is set to false. 
                window.parent.document.getElementById("hidMoveNextCheckValue").value = "false";
            }
            catch (err)
            {
                //For Invoke Form Activity with ReadingPaneInPopupWindow is set to false.
                window.parent.top.document.getElementById("hidMoveNextCheckValue").value = "false";
            }

        }


    }

}

</script>
