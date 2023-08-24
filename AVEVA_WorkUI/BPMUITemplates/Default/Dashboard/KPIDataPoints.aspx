<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.DashBoard.KPIDataPoints" Theme="" StylesheetTheme="" %>
<%@ Register Src="PeriodSlot.ascx" TagName="PeriodSlot" TagPrefix="uc2" %>
<%@ Register Src="ThresholdInput.ascx" TagName="ThresholdInput" TagPrefix="uc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ OutputCache Location="None"  %>
<html>
<head id="Head1" runat="server">
</head>
   
   <script src="../Common/JavaScripts/jquery.min.js"></script>
   <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript">
        window.onresize = Resize;
        window.onload = Resize;

        function Resize() {
            var divdetails = document.getElementById("divdetails");
            var mainrow = document.getElementById("mainrow");
            //divdetails.style.height = document.body.clientHeight - 82;       
        }

        // check for ie11 condition
        function isIE11() {
            return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
        }


        function ShowDataPointFrame(id) {
            var w = 900;
            var h = 528;
            var ww = document.body.clientWidth;
            var wh = document.body.clientHeight;
            var l = (ww - w) / 2;
            var t = (wh - h) / 2;

            var frameel = document.getElementById("datapointframe");
            frameel.style.left = l;
            frameel.style.top = t;
            frameel.style.width = w;
            frameel.style.height = h;
            frameel.style.display = "block";

            var loc = window.location.toString();
            loc = loc.replace("KPIDataPoints.aspx", "DataPoint.aspx");
            if (id)
                loc = loc + "&id=" + escape(id);
            frameel.src = loc;

        }

        function CloseDataPointFrameAndRefresh() {

            var frameel = document.getElementById("datapointframe");
            //frameel.style.display = "none";
            frameel.style.visibility = 'hidden';
            if (window.navigator.userAgent.indexOf('MSIE') > 0 || isIE11())
                window.location.reload();
            else
                window.location.assign(window.location.toString());
        }
    </script>
    <style type="text/css">
        .mainheading {
            font-family: Roboto;
            font-size: 11px;
            font-weight: bold;
        }

        .subheadingtitle {
            font-family: Roboto;
            font-size: 10px;
            font-weight: bold;
        }

        .subheading {
            font-family: Roboto;
            font-size: 10px;
            font-weight: bold;
        }

        .notepaddingleft {
            padding-right: 720px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>Common/StyleSheet/Global.css" />
<body class="lefttdbg"  style="border: none; margin: none; padding: none;overflow:-moz-scrollbars-none;" leftmargin="2px" topmargin="2px" rightmargin="2px" bottommargin="2px" scroll="no">
    
    <form id="form1" runat="server">
        <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
        <link href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" /> 
        <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTGrid/Grid.AWTGrid.css">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <script>
            se.ui.messageDialog.setGlobalOptions({
                localization: {
                    closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>",
                    okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>",
                    cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>",
                    showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>",
                    hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>"
                }
            });


            function DisplayErrorMessage(message) {

                se.ui.messageDialog.showAlert("<%=GR.GetString("Security_Rights_comn_Alert_for_list")%>", message);
            }

        </script>
        <script>
            function Check() {
                var oManager;
                try {
                    oManager = parent.parent.parent.parent.GetRadWindowManagerForListControl();
                }
                catch (e) { }
                if (oManager == null || oManager == 'undefined') {
                    // If it is list inside another list
                    var oManager;
                    try {
                        oManager = parent.parent.parent.GetRadWindowManagerForListControl();
                    }
                    catch (e) { }
                }
                if (oManager == null || oManager == 'undefined')
                    oManager = parent.parent.GetRadWindowManagerForListControl();
                var oWnd = oManager.getWindowByName("WindowCloseBehaviour");
                oWnd.close();
            }

        </script>
        
    <table width="100%" height="98%" cellspacing="0" cellpadding="0" border="0" class="lefttdbg">
	<tr>
		<td valign="bottom" height="25" >
			<table border="0" cellspacing="1" cellpadding="2" width="100%" height="25px" style="table-layout:fixed;">
						    <tr >
						        <td align="left"  style="height: 35px;padding-left:17px;padding-top: 13px" class="subtitle"><span class="subtitle"><%=GR.GetString("KPI Data Point(s)")%></span> 
						        </td>
						    </tr>
			            </table>  
		</td>
	</tr>	
		<tr id="mainrow">
	    <td style="padding-right:30px;height:88%;">
		    <table  style="border:0px;width:98%;height:95%; text-align:center;padding-left: 14px">
		        <tr>
				    <td class="lefttdbg" colspan="2" style="height:100%" >                        									
	                    <div id="divdetails" style="width:100%;height:100%;overflow:auto;" >
                            <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" HorizontalAlign="NotSet" Height="99%"
                            RenderMode="Classic" Skin="AWTGrid" EnableEmbeddedSkins="false" ImagesPath="<%$ ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTGrid/Grid%>">
                            <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="True" />
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False">
                                    <EditFormSettings>
                                        <EditColumn  
                                                 UniqueName="EditCommandColumn">
                                            </EditColumn>
                                     </EditFormSettings>
                                    <Columns>
                                        <telerik:GridHyperLinkColumn DataTextField="Name" HeaderText="KPI Data Points" DataNavigateUrlFields="Id" DataNavigateUrlFormatString="javascript:ShowDataPointFrame('{0}')">
                                        <ItemStyle Width="600px" />
                                        </telerik:GridHyperLinkColumn>
                                        <telerik:GridBoundColumn DataField="Id" HeaderText="ID" UniqueName="Id" Display="false">
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                     <ExpandCollapseColumn ButtonType="ImageButton" UniqueName="ExpandColumn" Visible="False">
                                        <HeaderStyle Width="19px" />
                                    </ExpandCollapseColumn>
                                    <RowIndicatorColumn UniqueName="RowIndicator" Visible="False">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                </MasterTableView>
                                <SelectedItemStyle BackColor="DarkOrange" ForeColor="White" />
                                <FilterMenu HoverBackColor="LightSteelBlue" HoverBorderColor="Navy"  NotSelectedImageUrl="NotSelectedMenu.gif"
                                    SelectColumnBackColor="Control" SelectedImageUrl="SelectedMenu.gif"
                                    TextColumnBackColor="Window"></FilterMenu>
                            </telerik:RadGrid>                           
                            <script type="text/javascript">
                                function OpenRow(index) {
                                    var row = this.Rows[index];
                                    var id = row.Control.children[1].innerHTML;
                                    ShowDataPointFrame(id);
                                }
                            </script>                            
                        </div>
				    </td>
			    </tr>
			</table>
	    </td>
	</tr>
	<tr>
        <td style="height: 10px">
        </td>
    </tr>
	<tr>
        <td >
		    <TABLE width="100%" border="0" cellspacing="0" cellpadding="2" >
			    <tr>
			        <td height=2 colspan=2>
			        </td>
			    </tr>
				<TR>
				    <TD>
					</TD>
					<td width="10"></td>
				</TR>
    		</TABLE>
		</td>
	</tr>		
</table>
<div style="bottom: 0;right: 0;position: fixed;padding-right: 60px;padding-bottom: 5px;">
             <span class="note notepaddingleft"><%= GR.GetString("double click on any of the row to edit or delete a KPI Data Point")%></span>  
    <input type="button" class="inputsecondarybutton" value="<%=GR.GetString("Cancel")%>" name="btncancel"
           onclick="Check();" id="Button3">						
    <input type="button" class="inputbutton" value="<%=GR.GetString("New KPI Data Point") %>"New" name="btnok" onClick="ShowDataPointFrame();" ID="Button2" <%--title="<%= GR.GetString("double click on any of the row to edit or delete a KPI Data Point")%>"--%>>
 </div>
<iframe id="datapointframe" style="position: absolute; display: none; border: solid 1px black;" src="blank.htm"></iframe>
</form>
</body>
</html>
