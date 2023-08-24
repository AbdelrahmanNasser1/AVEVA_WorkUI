<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.SOA.CodeBehind.Repository.SOAObjectListAdd" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html style="height:98%">
<head id="Head1" runat="server">
    <title>
        <%=GR.GetString("soa_objectList")%>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <link rel="stylesheet" type="text/css" href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" /> 
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%$ ReplaceTemplateExpn:CommonUXControls/StyleSheet/se.ui.min.css%>"  rel="stylesheet" type="text/css" /> 
    <link href="<%$ ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css%>" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function GetRadWindow()
        {
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function closeWindow()
        {
            var oWindow = GetRadWindow();
            oWindow.close();
        }
    </script>
</head>
<body style="border: none;height:100%; margin: 2px; padding: none; overflow:auto">
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

        
</script>
    <form id="form1" runat="server" style="height:100%">
         <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <div  id="divparent" runat="server" style="height:100%">
            <div id="divheader" style="height:12%">
                <table style= "width:100%;margin:auto;border-width:0">
                    <tr>
                        <td class="pagetitle ">
                            <img alt="" id="imgTitle" src="<%=templateThemeDirectory%>SOA/images/icon-select-new-assembly.png" 
                               style="vertical-align:middle"/>
                             <label runat="server" id="pageTitle">
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td class="description" style="padding-left:19px;">
                            &nbsp;&nbsp;<label runat="server" id="pageDescription">
                            </label>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divbody" style="height:83%;overflow:hidden">
                <table style="width:99%;margin:0px auto; border-width:1px;height:100%;border-color:Black;border-style:solid" class="fieldset" >
                    <tr>
                        <td style="width:50%;vertical-align:top;padding:5px" runat="server" id="tdTreeView"  class="lefttdbg">
                            <table  style="border-width:0;overflow:auto" class="lefttdbg" >
                                <tr id="trFilter" runat="server" visible="false" >
                                    <td style="text-align:right;padding:5px;">
                                        <label id="idFilter" class="description" runat="server">
                                        </label>
                                        <asp:ImageButton ID="btnFilter" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:SOA/images/filteralias.gif%>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lefttdb" style="padding:5px;">
                                        <telerik:RadAjaxPanel ID="TreeAjax" runat="server" EnableAJAX="true">
                                            <telerik:RadTreeView ID="RadTreeView1" runat="server"  RetainScrollPosition="true"  EnableViewState="true" Height="290px" Width="300px" 
                                             OnClientNodeClicked="AfterClickHandler"  ViewStateMode="Enabled"  CheckBoxes="true" OnNodeCheck="RadTreeView1_NodeCheck" EnableEmbeddedSkins="false" Skin="AWTTreeView">
                                            </telerik:RadTreeView>
                                           <telerik:RadTreeView ID="treeSummary" runat="server"  RetainScrollPosition="true" EnableViewState="true" Height="100%" Width="300px" Visible="false" EnableEmbeddedSkins="false" Skin="AWTTreeView">
                                            </telerik:RadTreeView>
                                            <telerik:RadTreeView ID="treeAlias" runat="server"  RetainScrollPosition="true" CheckBoxes="true" Height="100%" Width="320px" Visible="false"  OnClientNodeChecked="AfterCheck" EnableEmbeddedSkins="false" Skin="AWTTreeView">
                                            </telerik:RadTreeView>
                                        </telerik:RadAjaxPanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width:50%;vertical-align:top" runat="server" id="tdDetails" class="lefttdbg">
                        
                            <table  cellpadding="4" style="width: 98%;border-width:0;margin:auto;border-spacing:1px;border-width:0" class="tablebg" id="tblDetails" runat="server">
                                 <tr>
                                    <td class="lefttdbg" style="vertical-align:middle">
                                    
                                        <asp:Label runat="server" ID="lblTitle" CssClass="subtitle"></asp:Label>
                                    </td>
                                    <td class="righttdbg" style="vertical-align:middle">
                                         <asp:TextBox ID="txtTitle" CssClass="inputtext" runat="server" MaxLength="50" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>                            
                                <tr>
                                    <td class="lefttdbg" colspan="2" style="text-align:left;">
                                        <asp:Label runat="server" ID="lblDetails" CssClass="subtitle"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lefttdbg" style="vertical-align:middle">
                                        <asp:Label runat="server" ID="lblAssemblyName" CssClass="description"></asp:Label>
                                    </td>
                                    <td class="righttdbg" style="vertical-align:middle">
                                        <asp:Label runat="server" ID="lblAssemblyNameValue" CssClass="description"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lefttdbg" style="vertical-align:middle">
                                        <asp:Label runat="server" ID="lblNamespace" CssClass="description"></asp:Label>
                                    </td>
                                    <td class="righttdbg" style="vertical-align:middle">
                                        <asp:Label runat="server" ID="lblNamespaceValue" CssClass="description"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lefttdbg" style="vertical-align:middle">
                                        <asp:Label runat="server" ID="lblClassName" CssClass="description"></asp:Label>
                                    </td>
                                    <td class="righttdbg"  style="vertical-align:middle">
                                        <asp:Label runat="server" ID="lblClassNameValue" CssClass="description" ></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lefttdbg" style="vertical-align:middle">
                                        <asp:Label ID="lblMethodName" runat="server" CssClass="description"> </asp:Label></td>
                                    <td  class="righttdbg" style="vertical-align:middle">
                                        <asp:Label runat="server" ID="lblMethodNameValue" CssClass="description"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td  class="lefttdbg" style="width:250px;vertical-align:middle">
                                        <asp:Label runat="server" ID="lblAliasLabel"  CssClass="description"></asp:Label></td>
                                    <td style="width:50%;vertical-align:middle" class="righttdbg">
                                        <asp:TextBox ID="txtAliasName" CssClass="inputtext" runat="server" MaxLength="50" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr class="lefttdbg">
                                    <td style="text-align:right;" colspan="2" >
                                        <asp:Button ID="btnOk" runat="server" CssClass="inputbutton" Enabled="false"  />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
  
            <div id="divfooter" style="height:10%;vertical-align:bottom;overflow:hidden;padding-top:20px;padding-right:5px;">
                <table style="width:100%;border-width:0;margin:auto">
                
                    <tr>
                        <td  style="text-align:right">
                            <asp:Button runat="server" ID="btnBack" OnClick="btnBack_Click" Visible="false" CssClass="inputbutton"
                                Width="60px" />
                        </td>
                        <tr>
                            
                                <td style="text-align:right;width:99%;">
                                <input id="btnCancel" type="button" class="inputsecondarybutton" onclick="javascript:closeWindow();"
                                     runat="server" />
                                <asp:HiddenField ID="hdnArgument" runat="server" />
                                <input id="hidVersion" type="hidden" runat="server" />
                                <input id="hidAssemblyName" type="hidden" runat="server" />
                                <input id="hidAssemblyFullPath" type="hidden" runat="server" />
                                <asp:Label ID="InjectScript" runat="server"></asp:Label></td>
                                <td style="text-align:right; ">
                                    <asp:Button ID="btnSave" runat="server" CssClass="inputbutton" OnClick="btnSave_Click" width="160px" />
                                  </td>
                        </tr>
                </table>
            </div>
        </div>
        <div  id="divchild" style="display: none;" runat="server">
            <div id="divHeaderError">
                <table style="width:100%;margin:auto;border-width:0">
                    <tr>
                        <td class="pagetitle ">
                            <img id="img1" src="../../SOA/images/icon-select-new-assembly.png" alt="" hspace="4" align="absmiddle"
                                runat="server" />
                            <asp:Label runat="server" ID="lblError"></asp:Label>                           
                        </td>
                    </tr>
                    <tr>
                        <td class="description">
                            <asp:Label runat="server" ID="lblErrorDescription"></asp:Label>                                 
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divBodyError">
                <table style="width:94%;margin:auto;border-width:1;border-style: solid; height: 80%;">
                    <tr>
                        <td style="width:100%;vertical-align:top" id="td1">
                            <ISWebGrid:Webgrid id="WebGrid1" Visible="false" runat="server" HorizontalAlign="NotSet" AllowAutoDataCaching="false"
                                DataCacheStorage="PageCache"  Height="100%"
                                width="100%" DisableFileSystemChecking="true" EnableWebResources="never">
                                <layoutsettings alternatingcolors="True" cellpaddingdefault="2" gridlinestyle="Solid"
                                    gridlinecolor="224, 224, 224" rowheightdefault="23px" autofitcolumns="false"
                                    autowidth="false" autoheight="false" allowsorting="Yes" allowcolumnsizing="Yes"
                                    alwaysshowhelpbutton="false">                                                   
                                  <HeaderStyle Wrap="false" Height="20px" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                                     CssClass="GridHeaderStyle"
                                    CustomRules="border-bottom: Gray 1px solid"></HeaderStyle>
                                <FocusCellStyle CssClass="GridFocusCellStyle" />
                                <PreviewRowStyle ForeColor="#0000C0"></PreviewRowStyle>
                                <StatusBarCommandStyle>
                                    <Active BackColor="RoyalBlue" BaseStyle="Over">
                                    </Active>
                                    <Over BackColor="CornflowerBlue" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px">
                                    </Over>
                                    <Normal>
                                        <Padding Bottom="1px" Left="1px" Right="1px" Top="1px" />
                                    </Normal>
                                </StatusBarCommandStyle>                                          
                                 <GroupRowInfoStyle BackColor="#F1EFE2" BorderColor="White" BorderStyle="Solid" BorderWidth="1px"
                                    Font-Names="Verdana" Font-Size="8pt">
                                    <BorderSettings>
                                        <Bottom Color="Silver" />
                                        <Right Color="Silver" />
                                    </BorderSettings>
                                </GroupRowInfoStyle>
                                <GroupByBox>
                                    <LabelStyle BackColor="White" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px"
                                        Font-Names="Verdana" Font-Size="8pt" />
                                    <Style BackColor="Gray"></Style>
                                </GroupByBox>                                 
                                <EditTextboxStyle BorderStyle="None" BorderWidth="0px" Font-Names="Verdana" Font-Size="8pt">
                                </EditTextboxStyle>
                                <FrameStyle  CssClass="GridFrameStyle"></FrameStyle>
                                <SelectedRowStyle CssClass="GridSelectedRowStyle" />                                                
                               <StatusBarStyle CssClass="GridStatusBarStyle">
                                    <Padding Bottom="2px" Left="2px" Right="2px" Top="2px" />
                               </StatusBarStyle>
                                 <RowStyle CssClass="GridRowStyle" Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden"
                                    CustomRules="text-overflow: ellipsis; overflow-x: hidden"  />
                                <NewRowStyle CssClass="GridNewRowStyle">
                                </NewRowStyle>
                                <ScrollBarStyle ArrowColor="255, 192, 192" />
                                <TextSettings Language="UseCulture">
                                </TextSettings>
                            </layoutsettings>
                                <roottable gridlinestyle="NotSet">
                            </roottable>
                            </ISWebGrid:Webgrid>
                            <div id="divError" class="description" runat="server" style="height:100%;width:100%;display:none;"></div>                           
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divFooterError">
                <table style="width:100%; border-width:0">
                    <tr>
                        <td style="text-align:right">
                            <input id="btnCancelError" type="button"  value="Close" class="inputsecondarybutton" onclick="javascript:closeWindow();"
                                width="60px" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</body>
</html>

<script type="text/javascript">    
            
            
        AddEventHandler(window,'resize', resizefunction);
        AddEventHandler(window,'load', resizefunction);
            
        function AddEventHandler(elementObject, eventName, functionObject)
        {
            if(document.addEventListener)
                elementObject.addEventListener(eventName, functionObject, false);
            else
                if(document.attachEvent)
                    elementObject.attachEvent("on" + eventName, functionObject);
        }
        
        function AfterCheck(node)
        {
            UpdateAllChildren(node.Nodes, node.Checked);
            CheckParents(node);
        }            
        
        //Checks/UnChecks all the children nodes
        function UpdateAllChildren(nodes, checked)
        {
            var i;
            for (i=0; i<nodes.length; i++)
            {
                if (checked)
                {
                    nodes[i].Check();
                }
                else
                {
                    nodes[i].UnCheck();
                }
                if (nodes[i].Nodes.length > 0)
                {
                    UpdateAllChildren(nodes[i].Nodes, checked);
                }
            }
        }
        
         // It unchecks the parent nodes
        function CheckParents(node)
        {
            if (node.Checked)
            {
                while(node.Parent != null)
                {
                    node.Parent.Check();//To uncheck parents use UnCheck() function
                    node = node.Parent;
                }
            }
        }            
        
        function resizefunction()
        {   
            var bodydiv = document.getElementById('divbody');
            var headerdiv = document.getElementById('divheader');
            var footerdiv = document.getElementById('divfooter');
            var parentdiv = document.getElementById('divparent');
            if (parentdiv.offsetParent==document.body)
                document.body.style.height = '100%';
            
            var parentdivheight = parentdiv.offsetParent.offsetHeight;
            parentdiv.style.height =  parentdivheight ;
            try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight  +'px';}catch(e){}//headerdiv.offsetHeight -
            bodydiv.style.width =  '100%';
            bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';        
        }
        
    function AfterClickHandler(sender, eventArgs) {
        var txtAliasName = document.getElementById('txtAliasName');
        var node = eventArgs.get_node();
        txtAliasName.value = "";
        if (node.get_level() == 0) {
            node.Selected = true;
            var AssemblyValue = node.get_value().split("~");
            var Assembly = AssemblyValue[0].split("^");
            document.getElementById('lblAssemblyNameValue').innerText = Assembly[1];
            txtAliasName.value = node.get_text();

            document.getElementById('lblNamespaceValue').innerText = "";
            document.getElementById('lblClassNameValue').innerText = "";
            document.getElementById('lblMethodNameValue').innerText = "";
            document.getElementById('lblAliasLabel').innerText = "";
            document.getElementById('btnOk').disabled = true;
        }

        if (node.get_level() == 1) {
            node.Selected = true;

            var NameSpaceValue = node.get_value().split("~");
            var Assembly = NameSpaceValue[0].split("^");
            var NameSpace = NameSpaceValue[1].split("^");

            document.getElementById('lblAssemblyNameValue').innerText = Assembly[1];
            document.getElementById('lblNamespaceValue').innerHTML = NameSpace[1];
            document.getElementById('lblAliasLabel').innerHTML = '<%=GR.GetString("soa_EnterAliasFor")%>' + " '" + NameSpace[1] + "'";
            txtAliasName.value = node.get_text();

            document.getElementById('lblClassNameValue').innerText = "";
            document.getElementById('lblMethodNameValue').innerText = "";
            document.getElementById('btnOk').disabled = false;
        }

        if (node.get_level() == 2) {
            node.Selected = true;

            var NameSpaceValue = node.get_value().split("~");
            var Assembly = NameSpaceValue[0].split("^");
            var NameSpace = NameSpaceValue[1].split("^");
            var Class = NameSpaceValue[2].split("^");

            document.getElementById('lblAssemblyNameValue').innerText = Assembly[1];
            document.getElementById('lblNamespaceValue').innerHTML = NameSpace[1];
            document.getElementById('lblClassNameValue').innerHTML = Class[1];
            document.getElementById('lblAliasLabel').innerHTML = '<%=GR.GetString("soa_EnterAliasFor")%>' + " '" + Class[1] + "'";
            txtAliasName.value = node.get_text();

            document.getElementById('lblMethodNameValue').innerText = "";
            document.getElementById('btnOk').disabled = false;
        }
        if (node.get_level() == 3) {
            node.Selected = true;
            document.getElementById('lblAssemblyNameValue').innerText = "";
            document.getElementById('lblNamespaceValue').innerText = ""
            document.getElementById('lblClassNameValue').innerText = "";
            document.getElementById('lblMethodNameValue').innerText = "";
            document.getElementById('lblAliasLabel').innerText = "";
            document.getElementById('btnOk').disabled = true;
            txtAliasName.value = "";
        }

        if (node.get_level() == 4) {

            node.Selected = true;

            var NameSpaceValue = node.get_value().split("~");
            var Assembly = NameSpaceValue[0].split("^");
            var NameSpace = NameSpaceValue[1].split("^");
            var Class = NameSpaceValue[2].split("^");
            var Method = NameSpaceValue[4].split("^");

            //Find whether the clicked node is Method or not.                    
            //If it is method then split it based on the method name
            var intIndex = node.get_text().indexOf('(');
            var MethodName = "";
            if (intIndex > -1) {
                MethodName = node.get_text().substring(0, intIndex);
            }
            else {
                MethodName = node.get_text();
            }

            document.getElementById('lblAssemblyNameValue').innerText = Assembly[1];
            //To fix the issue :-In mozilla all these innertext was not displaying.                  
            document.getElementById('lblNamespaceValue').innerHTML = NameSpace[1];
            document.getElementById('lblClassNameValue').innerHTML = Class[1];
            document.getElementById('lblMethodNameValue').innerHTML = Method[1];
            document.getElementById('lblAliasLabel').innerHTML = '<%=GR.GetString("soa_EnterAliasFor")%>' + " '" + Method[1] + "'";

            txtAliasName.value = MethodName;
            document.getElementById('btnOk').disabled = false;
        }
          }          
</script>

