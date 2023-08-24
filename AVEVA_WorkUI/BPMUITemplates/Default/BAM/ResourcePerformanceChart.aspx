<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.ResourcePerformance" %>

<%@ Register Assembly="ComponentArt.Charting.WebChart" Namespace="ComponentArt.Charting"
    TagPrefix="cc1" %>
<link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/StyleSheet/Global.css" />


<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <style type="text/css">
        html, body
        {
            height:100%;
            overflow:hidden;            
        }
    </style>
</head>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" /> 

     <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>

    <form id="form2" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div style="background-color:white;height:100%">            
            <table border="0" style="vertical-align:top;height:100%;width:100%" >
                <tr>
                    <td style="vertical-align:top;height:2%;">                        
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td align="left" style="height: 19px">                                      
                                    <asp:Label ID="lblChartType" runat="server" CssClass="descriptionSmall" Visible="false" ></asp:Label>
                                     <asp:DropDownList ID="ddlChartType" runat="server" CssClass="inputselectSmall" AutoPostBack="true">
                                    </asp:DropDownList>
                                </td>   
                                <td>
                                    <%if (Request.QueryString["IR"] == null)
                                      {%>
                                    <asp:Label ID="lblViewDirection" runat="server" CssClass="descriptionSmall" ></asp:Label>
                                    <asp:Label ID="lblSpacer" runat="server" CssClass="descriptionSmall" Text=" :" ></asp:Label>
                                    <%--<img src=" <%= cssPath %>BAM/images/spacer.gif" height="1" border="0">--%><%}%>
                                    <asp:Label ID="lblX" runat="server" CssClass="descriptionSmall" ></asp:Label>
                                    <asp:DropDownList ID="ddlViewDirectionX" CssClass="inputselectSmall" runat="server" AutoPostBack="true">
                                    </asp:DropDownList>    
                                    <%--<img src=" <%= cssPath %>BAM/images/spacer.gif" height="1" border="0">--%>
                                    <asp:Label ID="lblY" runat="server" CssClass="descriptionSmall" ></asp:Label>
                                    <asp:DropDownList ID="ddlViewDirectionY" runat="server"  CssClass="inputselectSmall" AutoPostBack="true">
                                    </asp:DropDownList>  
                                    <%--<img src=" <%= cssPath %>BAM/images/spacer.gif" height="1" border="0">--%>
                                    <asp:Label ID="lblZ" runat="server" CssClass="descriptionSmall" ></asp:Label>
                                    <asp:DropDownList ID="ddlViewDirectionZ" runat="server" CssClass="inputselectSmall"  AutoPostBack="true">
                                    </asp:DropDownList>                                         
                                </td>                     
                            </tr>                            
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align:top;height:98%;">
                        <cc1:WebChart ID="WebChart1" runat="server" BackColor="White" ForeColor="ControlText"
                            Height="200px" Width="350px" MainStyle="Pie" RenderingPrecision="0.3" CompositionKind="Concentric"
                            CustomImageFileName="" SafetyMarginsPercentage="10" TextAlignment="Near">
                            <GradientStyles>
                                <cc1:GradientStyle EndColor="79, 126, 0" GradientKind="None" Name="&lt;&lt;TemporaryGradientStyleName&gt;&gt;"
                                    StartColor="79, 126, 0" />
                            </GradientStyles>
                            <LineStyles2D>
                                <cc1:LineStyle2D Name="TwoDObjectBorder" />
                            </LineStyles2D>
                            <View ViewDirection="(10,7,20)" Perspective="50">
                            </View>
                            <Legend BackColor="Transparent" BorderColor="Transparent" Font="Arial, 10pt" FontColor="Transparent"
                                Visible="True"></Legend>
                            <Series>
                                <cc1:Series Depth="100" HasIndependentYAxis="False" MarkerSizePts="0" Name="Count"
                                    StyleName="Pie">
                                    <Labels>
                                        <cc1:SeriesLabels LabelExpression="y" LabelStyleName="InsideRadial" />
                                    </Labels>
                                </cc1:Series>
                            </Series>
                            <Titles>
                                <cc1:ChartTitle Font="Verdana, 12pt" Position="Bottom" Text="Title" TextShadeWidthPts="1" />
                            </Titles>
                            <LabelStyles>
                                <cc1:LabelStyle Font="Verdana, 9.75pt" Name="AxisLabelHeading" />
                            </LabelStyles>
                            <CoordinateSystem>
                                <XAxis>
                                    <AxisAnnotations>
                                        <cc1:AxisAnnotation AlternateAxisOrientation="ZAxis" AxisTitle="Period" AxisTitleOffsetPts="20"
                                            AxisTitleStyleName="AxisLabelHeading" LiftZ="0.2" Name="X@Zmax" PositionKind="AtMaximumValue"
                                            RotationAngle="0" TickMarkStyleName="Default" />
                                    </AxisAnnotations>
                                </XAxis>
                                <YAxis CoordinateStep="2" DefaultCoordinateSetComputation="ByNumberOfPoints,5,2,Day,True,True">
                                </YAxis>
                                <ZAxis CoordinateStep="20" DefaultCoordinateSetComputation="ByNumberOfPoints,5,20,Day,True,True">
                                </ZAxis>
                            </CoordinateSystem>
                        </cc1:WebChart>
                       
                        <!-- Table for the Text -->
                         <table style="width:100%" >
                            <tr>
                                <td style="vertical-align:top;width:100%">
                                    <asp:ImageButton ID="imgDescription" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:BAM/Images/BAMChart.bmp %>"
                                        ImageAlign="AbsMiddle" />
                                    <asp:Label ID="lblDescription" runat="server" Text="Label" CssClass="descriptionsmall"
                                        ></asp:Label>
                                     <asp:Label ID="lblDateRange" runat="server" Text="Label" CssClass="descriptionsmall"
                                        ></asp:Label>
                                </td>
                                
                                 
                            </tr>
                            
                        </table>
                    </td>
                </tr>
                
            </table>
        </div>
    </form>
</body>
</html>


