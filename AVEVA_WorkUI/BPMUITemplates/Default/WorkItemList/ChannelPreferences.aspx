<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.WorkItemList.ChannelPreferences" Theme="" StylesheetTheme="" %>
<%@ OutputCache Location="None"  %>
<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title><%=GR.GetString("Work item delivery preferences")%></title>
    <style>
        html,body{height:100%;}
    </style>
    <link rel="stylesheet" type="text/css" href="<%:TemplateDirectory+"common/StyleSheet/Global.css"%>"/>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%:TemplateDirectory+"CommonUXControls/StyleSheet/se.ui.min.css"%>"/>
    <script type="text/javascript">
    window.onresize = Resize;
    window.onload = Resize;
    function Resize()
    {
        var divdetails = document.getElementById("divdetails");
        var mainrow = document.getElementById("mainrow");
        divdetails.style.height = document.body.clientHeight - 156 +'px';
       // mainrow.style.height = document.body.clientHeight - 205;
    }

    se.ui.messageDialog.setGlobalOptions({
        localization: {
            closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>",
                   okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>",
                   cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>",
                   showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>",
                   hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>"
               }
        });
    
    </script>
</head>
<body style="border:none;overflow:-moz-scrollbars-none;overflow:hidden;padding-left:10px;padding-right:10px;" >
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <table style="width:100%;border-spacing:0px;border-collapse:collapse;" >
	<tr class="ListHeaderCss">
		<td style="vertical-align:bottom;padding:3px;">

			<table style="width:100%;border-spacing:0px;border-collapse:collapse;">
			<tr>
				<td style="vertical-align:middle;"><span class="fontheading"><%=GR.GetString("Personal Work item delivery preferences")%></span>
				<br />
				<%--<span class="description"><%=strChannelDesc%></span>--%>
				</td>
			</tr>
		</table>
		</td>
	</tr>
        <tr id="mainrow">
            <td style="padding: 3px;">
                <table style="width: 100%; border-collapse: separate; border-spacing: 1px;">
                    <tr>
                        <td class="lefttdbg" style="vertical-align: top; padding: 3px;">
                            <span class="subtitle"><%=StrChannel%></span>
                            <br />
                            <span class="description"><%=StrHeadingPreferences%><br />
                                <%=GR.GetString("NOTE Workitems will be delivered to only <b>Unchecked</b> channels.")%></span>
                        </td>
                        <td style="text-align: left; padding: 5px;" class="righttdbg">
                            <div id="divdetails" style="width: 100%; height: 100%; overflow: auto;">
                                <table style="width: 100%">
                                    <%  if (Channels != null && Channels.Count > 0)
                                                       {
                                                           foreach (Skelta.HWS.WorkListChannel.IWorkListChannel channel in Channels.Values)
                                                           {
                                                               string channelName = channel.Name;
                                                               if (channel.IsVisible)
                                                               {
                                    %>
                                    <tr style="text-align: left;">
                                        <td style="text-align: left;" class="description">
                                            <%
                                                                        CheckBox checkbox = new CheckBox();
                                                                        checkbox.ID = channelName.Replace(" ","_");
                                                                        checkbox.Text = "&nbsp;" +GR.GetString( channelName );
                                                                        checkbox.Checked = false;
                                                                        checkbox.CssClass = "inputcheckbox";
                                                                        if (!Page.IsPostBack)
                                                                        {                                                                            
                                                                            if (CheckActorPreferredChannels.Count > 0)
                                                                            {
                                                                                if (!CheckActorPreferredChannels.Contains(channelName)) checkbox.Checked = true;                   
                                                                            }  

                                                                        }                                                                             
                                                                        if( SelectedChannels.Contains(channelName) ) checkbox.Checked=true;
                                                                        if (channel.IsMandatory)
                                                                        {
                                                                            checkbox.Checked = false;
                                                                            checkbox.Enabled = false;
                                                                        }                                                                        
                                                                        place1.Controls.Clear();
                                                                        place1.Controls.Add(checkbox);
                                            %>
                                            <asp:PlaceHolder ID="place1" runat="server"></asp:PlaceHolder>
                                        </td>
                                    </tr>
                                    <%}
                                                            }
                                                         }%>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="padding: 3px;">
                            <span class="subtitle"><%=StrCulture%></span><br />
                            <span class="description"><%=StrCultureDesc%></span>
                        </td>
                        <td class="righttdbg" style="padding: 3px;">
                            <asp:DropDownList ID="ddlCulturenames" runat="server" CssClass="inputselect">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
		    <td style="text-align:right;vertical-align:top;padding-top:4px;padding-right:10px;">
                <input type="button" class="inputsecondarybutton" value="<%=StrCancel%>" ID="btnCancel" onClick="window.close();" NAME="btnCancel">
			    
			    <asp:Button ID="btnSetCulture" runat="server" class="inputsecondarybutton" /> 							
			    <asp:Button ID="btnSetPreferences" runat="server" class="inputbutton" /> 
			    <input type="hidden" id="hidSetCulture" />  
		    </td>						
	    </tr>                 
	</table>	
   </form>
</body>
</html>
