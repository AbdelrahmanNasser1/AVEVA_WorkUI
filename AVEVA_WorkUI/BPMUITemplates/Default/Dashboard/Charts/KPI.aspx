<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.DashBoard.KPICodeBehind" %>

<%@ Register Assembly="ComponentArt.Charting.WebChart" Namespace="ComponentArt.Charting"
    TagPrefix="cc1" %>


<html>
<head runat="server">
    <title>Untitled Page</title>
</head>
<body style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;border-style:none;">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
        <cc1:WebChart ID="Chart" runat="server"  BackColor="Transparent" BackGradientEndingColor="Transparent"
            BackGradientKind="Vertical" ForeColor="ControlText" Height="270px" MainStyle="Pie"
            RenderingPrecision="0.3" SelectedPaletteName="Default" Width="350px" CompositionKind="Concentric">
            <GradientStyles>
                <cc1:GradientStyle EndColor="79, 126, 0" GradientKind="None" Name="&lt;&lt;TemporaryGradientStyleName&gt;&gt;"
                    StartColor="79, 126, 0" />
            </GradientStyles>
            <LineStyles2D>
                <cc1:LineStyle2D Name="TwoDObjectBorder" />
            </LineStyles2D>
            <View ViewDirection="(3.48504099876669,19.2396552121143,12.9108542148023)" Perspective="50">
            </View>
            <Legend BackColor="Transparent" BorderColor="Transparent" Font="Arial, 10pt" FontColor="Transparent"
                Visible="True"></Legend>
            <Series>
                <cc1:Series Depth="100" Name="Count" StyleName="Pie">
                    <Labels>
                        <cc1:SeriesLabels LabelExpression="y" LabelStyleName="InsideRadial" />
                    </Labels>
                </cc1:Series>
            </Series>
            <Titles>
                <cc1:ChartTitle Font="Roboto, 12pt" Position="Bottom" Text="Title" TextShadeWidthPts="1" />
            </Titles>
            <LabelStyles>
                <cc1:LabelStyle Font="Roboto, 9.75pt" Name="AxisLabelHeading" />
            </LabelStyles>
            <CoordinateSystem>
                <XAxis>
                    <AxisAnnotations>
                        <cc1:AxisAnnotation AlternateAxisOrientation="ZAxis" AxisTitle="Period" AxisTitleOffsetPts="20"
                            AxisTitleStyleName="AxisLabelHeading" LiftZ="0.2" Name="X@Zmax" PositionKind="AtMaximumValue"
                            TickMarkStyleName="Default" />
                    </AxisAnnotations>
                </XAxis>
            </CoordinateSystem>
        </cc1:WebChart>
        <cc1:WebChart ID="WebChart1" runat="server"  BackColor="Transparent" BackGradientEndingColor="Transparent"
            BackGradientKind="Vertical" ForeColor="ControlText" Height="270px" MainStyle="Cylinder"
            RenderingPrecision="0.3" SelectedPaletteName="Organic" Width="350px">
            <GradientStyles>
                <cc1:GradientStyle EndColor="79, 126, 0" GradientKind="None" Name="&lt;&lt;TemporaryGradientStyleName&gt;&gt;"
                    StartColor="79, 126, 0" />
            </GradientStyles>
            <LineStyles2D>
                <cc1:LineStyle2D Name="TwoDObjectBorder" />
            </LineStyles2D>
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
            </Titles>
            <LabelStyles>
                <cc1:LabelStyle Font="Roboto, 9.75pt" Name="AxisLabelHeading" />
            </LabelStyles>
            <CoordinateSystem>
                <XAxis>
                    <AxisAnnotations>
                        <cc1:AxisAnnotation AlternateAxisOrientation="ZAxis" AxisTitle="Period" AxisTitleOffsetPts="20"
                            AxisTitleStyleName="AxisLabelHeading" LiftZ="0.2" Name="X@Zmax" PositionKind="AtMaximumValue"
                            TickMarkStyleName="Default" />
                    </AxisAnnotations>
                </XAxis>
            </CoordinateSystem>
       
        </cc1:WebChart>
    
    </div>
    </form>
</body>
</html>
