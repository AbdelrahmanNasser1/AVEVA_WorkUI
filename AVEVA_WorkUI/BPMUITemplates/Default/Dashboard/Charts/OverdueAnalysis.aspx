<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.DashBoard.OverdueAnalysis" Theme="" %>

<%@ Register Assembly="ComponentArt.Charting.WebChart" Namespace="ComponentArt.Charting"   TagPrefix="cc1" %>
<link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/StyleSheet/Global.css" />
<!DOCTYPE html>
<html>
<head >
    <title>Overdue Analysis</title>
    <style type="text/css">
        html, body
        {
            height:98%;            
        }
    </style>
    
</head>
<body >
    <form id="form1" runat="server" style="height:100%;">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <div style="background-color:white;height:100%;">
       
        <table>
            <tr id="IdAxis" runat ="server">
                <td>
                     <%if(string.IsNullOrEmpty(Request["IR"])) { %>
                    <asp:Label ID="lblViewDirection" runat="server" CssClass="description" ></asp:Label>
                    <asp:Label ID="lblSpacer" runat="server" CssClass="description" Text=" :" ></asp:Label>&nbsp;
                    &nbsp;<% } %>
                    <asp:Label ID="lblX" runat="server" CssClass="descriptionSmall" ></asp:Label>
                    <asp:DropDownList ID="ddlViewDirectionX" runat="server" CssClass="inputselectSmall" AutoPostBack="true">
                    </asp:DropDownList>    
                    &nbsp;
                    <asp:Label ID="lblY" runat="server" CssClass="descriptionSmall" ></asp:Label>
                    <asp:DropDownList ID="ddlViewDirectionY" runat="server" CssClass="inputselectSmall" AutoPostBack="true">
                    </asp:DropDownList>  
                    &nbsp;
                    <asp:Label ID="lblZ" runat="server" CssClass="descriptionSmall" ></asp:Label>
                    <asp:DropDownList ID="ddlViewDirectionZ" runat="server" CssClass="inputselectSmall" AutoPostBack="true">
                    </asp:DropDownList>     
                    &nbsp;                                    
                </td>
            </tr>
        </table>              
       
       
        <cc1:WebChart ID="Chart" runat="server"  BackColor="White" BackGradientEndingColor="Transparent"
            BackGradientKind="Vertical" ForeColor="ControlText" Height="270px" MainStyle="Cylinder"
            RenderingPrecision="0.3" SelectedPaletteName="Organic" Width="350px">
            <GradientStyles>
                <cc1:GradientStyle EndColor="79, 126, 0" GradientKind="None" Name="&lt;&lt;TemporaryGradientStyleName&gt;&gt;"
                    StartColor="79, 126, 0" />
            </GradientStyles>
             <View Kind="ParallelProjection" ViewDirection="(10,7,20)">
            </View>
            <Legend BackColor="Transparent" BorderColor="Transparent" Font="Arial, 10pt" FontColor="Transparent"
                Visible="True"></Legend>
            <Series>
                <cc1:Series Name="Threshold">
                    <Labels>
                        <cc1:SeriesLabels LabelExpression="y" LabelStyleName="AboveHorizontal" />
                    </Labels>
                </cc1:Series>
                <cc1:Series Name="Count" Transparency="10">
                    <Labels>
                        <cc1:SeriesLabels LabelExpression="y" LabelStyleName="AboveHorizontal" />
                    </Labels>
                </cc1:Series>
            </Series>
            <Titles>
                <cc1:ChartTitle Font="Roboto, 12pt" Position="Bottom" Text="Title" TextShadeWidthPts="1" />               
                <cc1:ChartTitle Font="Roboto, 6pt" Position="RightUpwards"  Text="Title" TextShadeWidthPts="0" />               
            </Titles>
            <CoordinateSystem>
                <XAxis>
                    <AxisAnnotations>
                        <cc1:AxisAnnotation AlternateAxisOrientation="ZAxis" AxisTitle="Period" AxisTitleOffsetPts="20"
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
            <LineStyles2D>
                <cc1:LineStyle2D Name="TwoDObjectBorder" />
            </LineStyles2D>
            <LabelStyles>
                <cc1:LabelStyle LiftZ="0.5" Name="Default" />
                <cc1:LabelStyle Font="Roboto, 9.75pt" Name="AxisLabelHeading" />
                <cc1:LabelStyle Font="Roboto, 9.75pt"  HorizontalDirection="(0,0,-1)"
                    Name="AxisYLableHeading" Orientation=YXOrientation ReferencePoint="Center"
                    VerticalDirection="(-1,0,0)" />
            </LabelStyles>
       
        </cc1:WebChart>
    
    </div>
    
    </form>
</body>
</html>
