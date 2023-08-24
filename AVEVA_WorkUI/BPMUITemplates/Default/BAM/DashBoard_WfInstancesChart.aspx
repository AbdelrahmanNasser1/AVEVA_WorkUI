<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.SkeltaTemplates_Default_BAM_DashBoard_WfInstances"
    Theme="" StylesheetTheme="" %>
<%@ Register Assembly="ComponentArt.Charting.WebChart" Namespace="ComponentArt.Charting"
    TagPrefix="cc1" %>

<link rel="stylesheet" type="text/css" href="<%:cssPath %>Common/StyleSheet/Global.css" />
<!DOCTYPE HTML>
<html>
<head>
    <title>Untitled Page</title>
     <style type="text/css">
        html, body
        {
            height:98%;
            overflow:hidden;
        }
     </style>
</head>
<body >
    <form id="form1" runat="server" style="height:100%;">   
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <table style="width:100%;height:5%">
            <tr id="IdAxis" runat ="server">
                <td>
                      <%if (Request.QueryString["IR"] == null) {%>
                    <asp:Label ID="lblViewDirection" runat="server" CssClass="description" ></asp:Label>
                    <asp:Label ID="lblSpacer" runat="server" CssClass="description" Text=" :" ></asp:Label>&nbsp;
                    &nbsp; <%}%><asp:Label ID="lblX" runat="server" CssClass="descriptionsmall" ></asp:Label>
                    <asp:DropDownList ID="ddlViewDirectionX" runat="server" CssClass="inputselectSmall" AutoPostBack="true">
                    </asp:DropDownList>    
                    &nbsp;
                    <asp:Label ID="lblY" runat="server" CssClass="descriptionsmall" ></asp:Label>
                    <asp:DropDownList ID="ddlViewDirectionY" runat="server" CssClass="inputselectSmall" AutoPostBack="true">
                    </asp:DropDownList>  
                    &nbsp;
                    <asp:Label ID="lblZ" runat="server" CssClass="descriptionsmall" ></asp:Label>
                    <asp:DropDownList ID="ddlViewDirectionZ" runat="server" CssClass="inputselectSmall" AutoPostBack="true">
                    </asp:DropDownList>     
                    &nbsp;                                    
                </td>
            </tr>
        </table>
        
           <div style="width:100%;height:95%;vertical-align:top;">           
           
                        <cc1:WebChart ID="ChartInstance" runat="server" BackColor="White" BackGradientEndingColor="Transparent"
                            BackGradientKind="Vertical" ForeColor="ControlText" Height="250px" width="350px" MainStyle="Cylinder"
                            RenderingPrecision="0.3" SelectedPaletteName="Organic">
                            <gradientstyles>
                                <cc1:GradientStyle EndColor="79, 126, 0" GradientKind="None" Name="&lt;&lt;TemporaryGradientStyleName&gt;&gt;"
                                    StartColor="79, 126, 0" />
                            </gradientstyles>
                           <View Kind="ParallelProjection" ViewDirection="(10,7,20)">
                            </View>                        
                            <series>
                                <cc1:Series Name="Instance" Transparency="10">
                                <Labels>
                                     <cc1:SeriesLabels LabelExpression="y" LabelStyleName="AboveHorizontal" />
                                </Labels>
                                </cc1:Series>                
                            </series>                            
                         <CoordinateSystem>
                            <XAxis>
                            <AxisAnnotations>
                                <cc1:AxisAnnotation AlternateAxisOrientation="ZAxis" AxisTitleOffsetPts="20"
                                    AxisTitleStyleName="AxisLabelHeading" LiftZ="0.2" Name="X@Zmax" PositionKind="AtMaximumValue"
                                    TickMarkStyleName="Default" />
                                <cc1:AxisAnnotation AlternateAxisOrientation="YAxis" LiftZ="0.2" Name="X@Ymin" PositionKind="AtMinimumValue"
                                    TickMarkStyleName="Default" Visible="False" />
                            </AxisAnnotations>
                        </XAxis>
                        <YAxis>
                            <AxisAnnotations>
                                <cc1:AxisAnnotation AlternateAxisOrientation="ZAxis" LiftZ="0.2" Name="Y@Zmax" PositionKind="AtMaximumValue"
                                    TickMarkStyleName="Default" />
                            </AxisAnnotations>
                        </YAxis>
                        <ZAxis>
                            <AxisAnnotations>
                                <cc1:AxisAnnotation AlternateAxisOrientation="XAxis" AxisTitleStyleName="AxisYLableHeading"
                                    LabelStyleName="AxisYLableHeading" LiftZ="0.2" Name="Z@Xmax" PositionKind="AtMaximumValue"
                                    TickMarkStyleName="Default" />
                                <cc1:AxisAnnotation AlternateAxisOrientation="YAxis" LiftZ="0.2" Name="Z@Ymax" PositionKind="AtMaximumValue"
                                    TickMarkStyleName="Default" Visible="False" />
                            </AxisAnnotations>
                        </ZAxis>
            </CoordinateSystem>
                          
                            
                            <linestyles2d>
                                <cc1:LineStyle2D Name="TwoDObjectBorder" />
                            </linestyles2d>
                            <labelstyles>
                                <cc1:LabelStyle LiftZ="0.5" Name="Default" />
                                <cc1:LabelStyle Font="Verdana, 9.75pt" Name="AxisLabelHeading" />
                                <cc1:LabelStyle Font="Verdana, 9.75pt"  HorizontalDirection="(0,0,-1)"
                                    Name="AxisYLableHeading" Orientation=YXOrientation ReferencePoint="Center"
                                    VerticalDirection="(-1,0,0)" />
                            </labelstyles>
                        </cc1:WebChart>
               <%=Message%> 
                   </div>  
                
            
       
    </form>
</body>
</html>
