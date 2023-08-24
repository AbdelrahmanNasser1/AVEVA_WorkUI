<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" Inherits="Skelta.SOA.CodeBehind.ProcessDesigner.SOAProperty" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


<html>
<head id="Head1" runat="server">

    <title>
        <%=GR.GetString("soa_Instance")%>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    
</head>
<body>
    
    <script language="javascript">
        function ShowOnError()
        {
            var DivTree = document.getElementById("<%=divError.ClientID%>");       
            DivTree.style.display = "block";                      
            DivTree.style.position="absolute";     
            DivTree.style.left = 5 + 'px';
            DivTree.style.bottom = 5 + 'px';      
            DivTree.style.height=150+'px';
        }
        
        function ShowOnMapVariableOnEdit() {
            var x = document.getElementById("<%=hdnX.ClientID%>").value + 'px';
            var y = document.getElementById("<%=hdnY.ClientID%>").value + 'px';
            var DivVariables = document.getElementById("<%=variablesDiv.ClientID%>");
            DivVariables.style.display = "block";
            DivVariables.style.position = "absolute";
            DivVariables.style.left = x;
            DivVariables.style.top = y;
            DivVariables.style.height = 125 + 'px';
        }
        
        function ShowOnMapVariable(x, y) {
            if (document.getElementById("<%=hdnX.ClientID%>").value != '' && x=='0px')
                x = document.getElementById("<%=hdnX.ClientID%>").value + 'px';

            if (document.getElementById("<%=hdnY.ClientID%>").value != '' && y == '0px')
                y = document.getElementById("<%=hdnY.ClientID%>").value + 'px';
           
            var DivVariables = document.getElementById("<%=variablesDiv.ClientID%>");
            DivVariables.style.display = "block";
            DivVariables.style.position = "absolute";
            DivVariables.style.left = x;
            DivVariables.style.top = y;
            DivVariables.style.height = 125 + 'px';
        }
        
        function CloseVariableDiv() {
            var DivVariables = document.getElementById("<%=variablesDiv.ClientID%>");
            DivVariables.style.display = "none";
        }
        
        function EnableDisableDeleteButton(enabled) {
            var btnDelete = document.getElementById("<%=btnDelete.ClientID%>");
            if(btnDelete != null)
            {
                if (enabled == 'false') {
                    btnDelete.style.display = "none";
                }
                else {
                    btnDelete.style.display = "block";
                }
            }
        }
        
        function ToggleCode() {            
            var divError = document.getElementById("<%=divErrorText.ClientID%>");
            var divCode = document.getElementById("<%=divCodeText.ClientID%>");

            if (divError.style.display == "block") {               
                divError.style.display = "none";
                divCode.style.display = "block";
                divCode.innerHTML = "";
                divCode.innerText = "";
                document.getElementById("<%=toggleLink.ClientID%>").innerHTML = "<img id=\"imgToggleCodeImage\" src=\"<%: templateThemeDirectory%>Expression/Images/icon-error.png\" border=\"0\" align=\"absmiddle\" /> <span class=\"subtitle\" id=\"spanCode\"><%=GR.GetString("SoaObject_Errors")%></span>";
            }
            else {
                divError.style.display = "block";
                divCode.style.display = "none";
                document.getElementById("<%=toggleLink.ClientID%>").innerHTML = "<img id=\"imgToggleCodeImage\" src=\"<%: templateThemeDirectory%>Expression/Images/icon-compile-code.png\" border=\"0\" align=\"absmiddle\" /> <span class=\"subtitle\" id=\"spanCode\"><%=GR.GetString("SoaObject_CompiledCode")%></span>";
           }
        }
        
        function InputBox(inputBoxID)
        {
	        this.ID = inputBoxID;
	        this.Expression=new Expression('','','','','','','');
	        this.pageURL="";
	        this.AssociatedControlID="";
	        this.LoadIframeShim="";
	        this.iframeObj=null;
	        this.IsExpression=false;
        }
        
        function Expression(DisplayExpressionString,ActualExprtessionString,MethodParameterList,HtmlVerexpString,ReferenceList,ReferencedFunctionList,nodeinfo)
        {
	        this.DisplayExpressionString=DisplayExpressionString;
	        this.ActualExprtessionString=ActualExprtessionString;
	        this.MethodParameterList=MethodParameterList;
	        this.HtmlVerexpString=HtmlVerexpString;
	        this.ReferenceList = ReferenceList;
	        this.ReferencedFunctionList = ReferencedFunctionList;
	        this.NodeInfo  = nodeinfo;
        }

        function GetInputBox(inputBoxClientID) {

	        var ipbox = null;
	        ipbox = eval(inputBoxClientID);
	        return ipbox;
        }       
    
    </script>   
    
     
    <form id="form1" runat="server">
        <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>        
        <link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetCommonRelativeUrl("Stylesheet/Global.css")%>" />
        <link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTSplitter/Splitter.AWTSplitter.css")%>" />
         <link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css")%>" />
        </telerik:RadScriptBlock>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
             </telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="radAjaxManager" runat="server"  EnableAJAX="true"></telerik:RadAjaxManager>  
         <telerik:RadCodeBlock runat="server" ID="RadCodeBlock9">
        <div id="divError"  class="description" style="height: 110px; width: 95%; display: none; border:1px solid #256194; background-color:White;"
                runat="server">          
            <table style="width: 100%" cellpadding=3; cellspacing=0>
                <tr class="header">                      
                    <td colspan="2" align="right" style="width: 100%">
                        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
                        <a href="#" class="a" id="toggleLink" runat="server" onclick="ToggleCode()">
                            <img id="imgToggleCodeImage" src="<%: templateThemeDirectory%>Expression/Images/icon-compile-code.png" border="0" align="absmiddle" /> <span class="subtitle" runat="server" id="spanCode"><%=GR.GetString("SoaObject_CompiledCode")%></span></a>&nbsp;&nbsp;
                            <a href="#" id="aCloseDiv" onclick="CloseDiv()">
                                <img style="border: 0" src="<%: templateThemeDirectory%>Common/Images/close.gif" /></a>

                            </telerik:RadCodeBlock>
                    </td>

                </tr>
                <tr>
                    <td align="left" style="width: 5%">
                        &nbsp;
                    </td>
                    <td style="width: 95%; height: 100%;">
                        <table id="tblError" runat="server" style="width: 100%; height: 100%;">
                            <tr>
                                <td>
                                    <div id="divErrorText" style="height:150px;display:block;overflow:auto;" class="errormsg" runat="server">
                                    </div>                                        
                                     <div id="divCodeText" style="height:150px;display:none;overflow:auto;" class="description" runat="server">
                                    </div>
                                    
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>     
            </telerik:RadCodeBlock>
         <telerik:RadCodeBlock runat="server" ID="RadCodeBlock10">
        <div id="variablesDiv" class="description" style="width: 375px; display: none; border:1px solid #256194; background-color:White;"
                runat="server">
            <div id="divMapVariable" runat="server">
                    <table width="100%" cellpadding=3; cellspacing=0>
                        <tr class="header">
                            <td>
                                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock2">
                                <span class="subtitle"><%=GR.GetString("SoaObject_MapToAVariable")%></span>
                                    </telerik:RadCodeBlock>
                            </td>
                            <td align="right">                        
                                <a href="#" id="a1" onclick="CloseVariableDiv()">
                                    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock3">
                                    <img style="border: 0" src="<%: templateThemeDirectory%>Common/Images/close.gif" />
                                        </telerik:RadCodeBlock>
                                </a>
                                        
                            </td>                    
                        </tr
                        <tr>
                            <td class="description" colspan="2">
                                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock4">
                                <ul id="uList" runat="server">                                    
                                   <li><%=GR.GetString("SoaObject_MapDescription1")%></li>                                   
                                   <li><%=GR.GetString("SoaObject_MapDescription2")%></li>
                                   <li><%=GR.GetString("SoaObject_MapDescription3")%></li>
                                    
                                </ul>      
                                </telerik:RadCodeBlock>
                            </td>
                        </tr>
                        <tr>
                            <td class="description" align="center"> 
                                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock5">
                                <%=GR.GetString("SoaObject_SelectVariable")%>:
                                    </telerik:RadCodeBlock>
                            </td>
                            <td>
                                 <asp:DropDownList Width="175px" CssClass="inputselect" ID="ddlVariables" runat="server"></asp:DropDownList>
                            </td>
                        </tr>                      
                        <tr>
                            <td align="right" colspan="2" class="footer"> 
                                <input type="button" runat="server" class="inputButton" onclick="CreateVariableWindow();" id="btnCreateVariable" />
                                <input type="button" runat="server" class="inputButton" onclick="ClearVariable();" id="btnClearVariable" />
                                <input type="button" runat="server" class="inputButton" onclick="MapVariable();" id="btnMapVariable" />
                                <input type="hidden" id="hdnX" runat="server" /> 
                                <input type="hidden" id="hdnY" runat="server" /> 
                            </td>
                        </tr>
                    </table>  
                </div>
            <telerik:RadCodeBlock runat="server" ID="RadCodeBlock6">
            <div id="divCreateVariable" runat="server" style="display:none;">
                        <table width="100%" cellpadding=3; cellspacing=0>
                            <tr class="header">
                                <td>
                                    <span class="subtitle"><%=GR.GetString("SoaObject_CreateVariable")%></span>
                                </td>
                                <td align="right">                        
                                    <a href="#" id="a2" onclick="CloseVariableDiv()">
                                        <img style="border: 0" src="<%:templateThemeDirectory%>Common/Images/close.gif" /></a>
                                </td>                    
                            </tr>
                            <tr>
                                <td class="description" colspan="2">                               
                                    <ul id="uL1" runat="server">                                
                                       <li><%=GR.GetString("SoaObject_VariableDescription1")%></li>                                   
                                       <li><%=GR.GetString("SoaObject_VariableDescription2")%></li>
                                       <li><%=GR.GetString("SoaObject_VariableDescription3")%></li>
                                    </ul>                                
                                </td>
                            </tr>
                            <tr>
                                <td class="description" align="center">  
                                    <%=GR.GetString("SoaObject_VariableName")%>:
                                </td>
                                <td>
                                    <asp:TextBox Width="175px" CssClass="inputtext" ID="txtVariableName" MaxLength="100" runat="server"></asp:TextBox>
                                </td>
                            </tr>                            
                            <tr>
                                <td align="right" colspan="2" class="footer"> 
                                    <asp:Button ID="btnCreate" CssClass="inputButton" runat="server" />                            
                                    <input type="button" runat="server" class="inputButton" onclick="CancelVariableWindow()" id="btnCancelVariable" />
                                </td>
                            </tr>
                        </table>  
                </div>
            </telerik:RadCodeBlock>
        </div>
        </telerik:RadCodeBlock>
        <asp:Label ID="lblScript" runat="server"></asp:Label>
        
        <table width="100%" style="height: 100%;" cellpadding="0" cellspacing="0"
                border="0">
            <tr valign="top" align="left">
                <td valign="bottom" height="25">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                        <tr class="header"> 
                            <td valign="middle"  style="height: 25px">
                            <span class="pagetitle">
                                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock34">
                                <%=GR.GetString("soa_Instance")%>
                                    </telerik:RadCodeBlock>
                                    </span>
                            </td>
                            <td valign="middle" width="70%" align="right">
                                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock35">
                                    <a href="#" onclick="javascript:window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(ProcessDesignerControl.GetHelpPageUrl(), false)%>HowToCreateObjectInstance.html','newwin','width=600,height=500,scrollbars=1,resizable=yes')">                                    
                                    <img border="0" src="<%:ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%>"
                                        align="right" style="cursor: pointer" alt="<%=GR.GetString("HelpIconToolTip")%>" />
                                    </a>
                                 </telerik:RadCodeBlock>
                            </td>
                            <td valign="top" align="right" style="height: 25px">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>              
            <tr>
                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock29">
            <td style="height: 100%;" valign="middle">
                <telerik:RadSplitter ID="Radsplitbar1" runat="server" Width="100%" Height="100%" Skin="AWTSplitter" ResizeWithParentPane="false"  EnableEmbeddedSkins="false" SplitBarsSize="5PX">
                        <telerik:RadPane ID="Radpane1" runat="server" Width="30%" Scrolling="Y">
                    <table style="width: 100%; height: 100%;">
                        <tr valign="top" align="left">
                            <td>
                                <input type="hidden" id="hdnMappedVariable" runat="server" />
                                <telerik:RadPanelBar ID="RadPanelbar1" runat="server" Width="100%">
                                    <Items>
                                        <telerik:RadPanelItem runat="server" Text="SOA Object Instances" Selected="true" Expanded="true">
                                            <Items>
                                                <telerik:RadPanelItem runat="server" Value="TemplatedItem3">
                                                    <ItemTemplate>
                                                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" EnableAJAX="false" runat="server" Height="100%"
                                                            Width="100%" Style="overflow: auto">                                                            
                                                            <telerik:RadTreeView ID="TreeViewInstnaces" EnableEmbeddedSkins="false" runat="server"  EnableViewState="true" Skin="AWTTreeView" Width="100%" AutoPostBack="true">
                                                            </telerik:RadTreeView> 

                                                     </telerik:RadAjaxPanel>
                                                    </ItemTemplate>
                                                </telerik:RadPanelItem>
                                            </Items>
                                        </telerik:RadPanelItem>
                                        <telerik:RadPanelItem runat="server" Text="SOA Object"  Expanded="true" Style="overflow:auto">
                                            <Items>
                                                <telerik:RadPanelItem runat="server" Value="TemplatedItem1">
                                                    <ItemTemplate>
                                                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Height="100%" Width="100%" Style="overflow:auto"
                                                            EnableAJAX="false">
                                                             <telerik:RadTreeView ID="TreeViewSOA"  EnableEmbeddedSkins="false" runat="server" EnableViewState="true" Skin="AWTTreeView" OnClientNodeClicked="AfterClickSOA" Width="100%" AutoPostBack="true">
                                                            </telerik:RadTreeView>                                                               
                                                            
                                                        </telerik:RadAjaxPanel>
                                                    </ItemTemplate>
                                                </telerik:RadPanelItem>
                                            </Items>
                                        </telerik:RadPanelItem>                                      
                                    </Items>
                                </telerik:RadPanelBar>
                            </td>
                        </tr>
                    </table>
                </telerik:RadPane>
                <telerik:RadSplitBar ID="Radsplitbar2" runat="server" CollapseMode="Forward" />
                <telerik:RadPane ID="Radpane2" runat="server" Width="70%">
                    <table>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>      
                    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock28">
                    <table class="tablebg" cellpadding="3" cellspacing="1" border="0" width="96%" align="center" >
                        <tr>
                            <td class="lefttdbg" style="width:30%">
                                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock12">
                                 <span class="description"><%=GR.GetString("soaObject_AssemblyName")%>:</span>
                                    </telerik:RadCodeBlock>
                            </td>
                            <td class="lefttdbg">
                                <div class="description" id="divAssembly" enableviewstate="true" style="display:block;" runat="server"></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" style="width:30%">
                                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock13">
                                 <span class="description"><%=GR.GetString("soaObject_NameSpaceName")%>:</span>
                                    </telerik:RadCodeBlock>
                            </td>
                            <td class="lefttdbg">
                            <div class="description"  style="display:block;" enableviewstate="true"  id="divNameSpace" runat="server"></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" style="width:30%"> 
                                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock14">
                                 <span class="description"><%=GR.GetString("soaObject_Class")%>:</span>
                                    </telerik:RadCodeBlock>
                            </td>
                            <td class="lefttdbg">
                            <div class="description"  style="display:block;" enableviewstate="true"  id="divClass" runat="server"></div>
                            </td>
                        </tr>
                    </table>    
                        </telerik:RadCodeBlock>
                        <table>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table> 
                     <telerik:RadCodeBlock runat="server" ID="RadCodeBlock27">         
                    <table class="tablebg" cellpadding="6" cellspacing="1" border="0" width="96%" align="center" >
                        <tr valign="top" class="lefttdbg">
                            <td valign="top" style="width:30%">
                                    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock15">
                                <span class="subtitle">
                                
                                    <%=GR.GetString("soa_InstanceName")%></span>
                                        </telerik:RadCodeBlock>
                                
                            </td>
                            <td class="righttdbg">
                                <asp:TextBox ID="tbName" CssClass="inputtext" Width="80%" runat="server"></asp:TextBox>                                           <telerik:RadCodeBlock runat="server" ID="RadCodeBlock16">                                                                                                             
                                <asp:RequiredFieldValidator ID="InstanceValidator" ValidationGroup="SOA" runat="server" Display="Dynamic" SetFocusOnError="true" ControlToValidate="tbName" CssClass="errortext" ><img id="imgListError" alt="<%:GR.GetString("soa_InstanceValidation")%>" src="<%:templateThemeDirectory%>skeltaforms/Images/erroricon.png" hspace="2" align="top" />
                                </asp:RequiredFieldValidator>   
                                    </telerik:RadCodeBlock>
                            </td>
                        </tr>
                        <tr valign="top" class="lefttdbg">
                            <td valign="top" style="width:30%">
                                        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock17">
                                <span class="subtitle">                                
                                    <%=GR.GetString("soa_Description")%></span>
                                </telerik:RadCodeBlock>
                            </td>
                            <td class="righttdbg" style="width:80%"> 
                                 <asp:TextBox ID="tbDescription" TextMode="MultiLine" Rows="4" CssClass="inputtext" Width="80%" runat="server"></asp:TextBox>
                             </td> 
                        </tr>
                        <tr valign="top" class="lefttdbg">
                            <td style="width:30%">
                                        
                               <span class="subtitle">
                                   <telerik:RadCodeBlock runat="server" ID="RadCodeBlock18">
                                    <%=GR.GetString("Expression")%></telerik:RadCodeBlock></span>
                                            
                            </td>
                            <td class="righttdbg">
                                 <table>
                                    <tr>
                                        <td>
                                                    
                                            <span>
                                                <a href="#" class="sectionitem" onclick="OpenExpressionBuilder();" id="setExpression" runat="server" >
                                                    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock19">
                                               <img id="Img4" runat="server" src="<%$ ReplaceTemplateExpn:/Common/images/new-row.gif  %>"
                                                   align="absmiddle" border=0 />
                                                        </telerik:RadCodeBlock>
                                                    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock30">
                                                       <%=GR.GetString("soaObject_SetExpression")%> </telerik:RadCodeBlock>&nbsp;&nbsp;&nbsp;</a></span>                                                         
                                        
                                        </td>
                                        <td>
                                                    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock20">
                                                        <img id="Img6" runat="server" src="<%$ ReplaceTemplateExpn:/Common/images/divider-for-icons.gif  %>"
                                                   align="absmiddle" border=0 />
                                             &nbsp;&nbsp;&nbsp;
                                                        </telerik:RadCodeBlock>
                                           
                                        </td>
                                        <td>
                                                    
                                            <span>
                                                <a href="#" class="sectionitem" onclick="ClearExpression();" id="clearExpression" runat="server" >
                                                    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock21">
                                                        <img id="Img5" runat="server" src="<%$ ReplaceTemplateExpn:/Common/images/remove-selected-icon.gif  %>"
                                                   align="absmiddle" border=0 /> 
                                                </telerik:RadCodeBlock>
                                                        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock31"> <%=GR.GetString("soaObject_ClearExpression")%></telerik:RadCodeBlock></a></span>  
                                                        
                                                        </td>
                                        
                                    </tr>                                    
                                 </table>                             
                                <asp:TextBox ID="tbExpression" CssClass="inputtext" runat="server" Rows="8"   Width="80%" TextMode="MultiLine"></asp:TextBox>
                                    
                                <asp:RequiredFieldValidator ID="ExpressionValidator" ValidationGroup="SOA" runat="server" Display="Dynamic" SetFocusOnError="true" ControlToValidate="tbExpression" CssClass="errortext" >
                                        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock22">
                                            <img id="img1" alt="<%:GR.GetString("soaObject_ValidateExpression")%>" src="<%:templateThemeDirectory%>skeltaforms/Images/erroricon.png" hspace="2" align="top" />
                                    </telerik:RadCodeBlock>
                                </asp:RequiredFieldValidator>                                               
                                <input type="hidden" runat="server" id="hdnActualExpression" />                   
                             </td>                
                        </tr>  
                        <tr valign="top" runat="server">
                            <td style="width:30%" class="lefttdbg">
                                        
                                <span Visible="false" class="subtitle">
                                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock23">
                                    <%=GR.GetString("SoaObject_MappedVariable")%></telerik:RadCodeBlock>
                                </span>
                                            
                            </td>
                            <td class="righttdbg" Width="70%" valign="top" >                             
                                <div id="divMappedVariable" runat="server" style="vertical-align:top;width:100%;">
                                    <table style="width:100%">
                                        <tr>
                                            <td style="width:18%">
                                                        
                                                 <span>
                                                    <a href="#" class="sectionitem" onclick="ShowOnMapVariable('320px', '350px');" id="mapHref" runat="server" >
                                                        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock24">
                                                            <img id="Img3" runat="server" src="<%$ ReplaceTemplateExpn:/SOA/images/icon-variable-constructor.png%>"
                                                            align="absmiddle" border=0 />
                                                       </telerik:RadCodeBlock>
                                                        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock32">
                                                           <%=GR.GetString("SoaObject_Map")%> </telerik:RadCodeBlock></a>
                                                </span>
                                                            
                                            </td>
                                            <td style="width:82%" align="left">
                                                <asp:TextBox  ID="txtMappedVariable" Width="75%" ReadOnly="true" CssClass="inputtext" runat="server"></asp:TextBox>  
                                            </td>
                                        </tr>
                                    </table>                                                
                                </div>     
                                <div id="divMappedVariableInfo" runat="server" style="vertical-align:top;width:100%;">
                                     <table style="width:100%">
                                        <tr>
                                            <td style="width:100%">
                                                        
                                                 <span class="note">
                                                     <telerik:RadCodeBlock runat="server" ID="RadCodeBlock25">
                                                                                                     <%=GR.GetString("soaObject_NotSerializable")%>
                                                          </telerik:RadCodeBlock>
                                                </span>    
                                                           
                                            </td>                                            
                                        </tr>
                                    </table>            
                                </div>                                                   
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" colspan="2">
                                        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock26">
                                 <img id="Img2" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                    align="absmiddle" /></telerik:RadCodeBlock>
                                     <span class="note"> <telerik:RadCodeBlock runat="server" ID="RadCodeBlock33">                                       
                                    <%= GR.GetString("soaObject_MapVariableDescription")%></telerik:RadCodeBlock>
                                   </span>     
                                            
                            </td>                                
                        </tr>                   
                        <tr valign="top" align="right" >                           
                            <td class="lefttdbg" colspan="2">                                                                           
                                <table>
                                    <tr>
                                        <td >
                                           <input type="button" class="inputsecondarybutton"  id="btnClear"
                                            runat="server" />&nbsp;           
                                        </td>
                                        <td style="padding-top:20px">
                                            <asp:Button ID="btnUpdate" ValidationGroup="SOA" CssClass="inputbutton" OnClick="btnUpdate_Click" runat="server"/>&nbsp;
                                        </td>
                                        <td>
                                         <div id="divDelete" runat="server">
                                                <asp:Button ID="btnDelete" CssClass="inputbutton" runat="server" 
                                                    OnClientClick="return confirmDelete();" />                                                  
                                           </div>
                                        </td>
                                    </tr>
                                </table>                                
                            </td>
                        </tr>                                                                           
                    </table>    
                         </telerik:RadCodeBlock>
                </telerik:RadPane>
            </telerik:RadSplitter>
            </td>
            </telerik:RadCodeBlock>        
            </tr>
            <tr width="100%;">
                    <td style="height: 25px; vertical-align: bottom;" width="100%;">
                        <table width="100%">
                            <tr width="100%;" >
                                <td width="100%;" align="right">
                                    &nbsp;                                      
                                    <asp:Button ID="btnHidden" Visible="false" CssClass="inputbutton" runat="server" />                                   
                                    <input type="hidden" id="hidAssemblyName" runat="server" />
                                    <input type="hidden" id="hidNameSpaceName" runat="server" />
                                    <input type="hidden" id="hidClassName" runat="server" />
                                    <input type="hidden" id="hidConstructor" runat="server" />    
                                    <input type="hidden" id="hidNodeValue" runat="server" />                                                                                   
                                </td>                               
                                <td>
                                    <asp:Button ID="btnCancel" CssClass="inputsecondarybutton" runat="server"
                                    OnClientClick="window.close();" />                                    
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
        </table>
        
        <div id="bubbleDiv" style="overflow: auto; cursor: text; font-family: Verdana, Arial, Helvetica, sans-serif;
                font-size: 12px; text-align: center; border-right: #9FBDDC thin solid; border-top: #9FBDDC thin solid;
                border-left: #9FBDDC thin solid; border-bottom: #9FBDDC thin solid;" />     
       <asp:Panel ID="expressionPanel" runat="server" style="display:none;"></asp:Panel>  
    </form>    
</body>
</html>

<script language="javascript">                
        var divXPos = 0;
        var divYPos = 0;
        var newNodeValue = "";
        var newNodeActualValue = "";
        var browserCode = GetBrowserversion();            
        var sourceParentParentValue= "";
        var sourceParentParentParentText = "";            
        var sourceParentParentValue = "";
        var sourceParentValue = "";
        var sourceValue = "";            
       
        function OpenExpressionBuilder() {
            var hdnActualExpression = document.getElementById("<%=hdnActualExpression.ClientID%>");
            var tbExpression = document.getElementById("<%=tbExpression.ClientID%>");           
            //Backward Compatibility
            if ((hdnActualExpression.value == "") && (tbExpression.value != "")) {
                var hidConstructor = document.getElementById("<%=hidConstructor.ClientID%>");
                var hidNodeValue = document.getElementById("<%=hidNodeValue.ClientID%>");
                hidNodeValue.value = hidConstructor.value;
            }
            var urlString = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(expbuilderURl, false)%>';    
            
            var left = (screen.width / 2) - (850 / 2);
            var top = (screen.height / 2) - (500 / 2);

            //mywindow = window.open(url + urlparameters, "GetNextQueueItem", "location=0, status=0, scrollbars=0, width=340, height=200, resizable=yes, top=" + top + ", left=" + left);

            var expressionWindow = window.open(urlString, "Expression", "status=0,toolbar=0,resizable=1,width=850,height=500,top=" + top + ", left=" + left);
            //expressionWindow.moveTo(300, 300);
        }

        function AfterClickSOA(node, events) {
            return;
            EnableDisableDeleteButton('false');
            var divbubbleObj= document.getElementById("bubbleDiv");     
            var hidAssemblyName = document.getElementById("<%=hidAssemblyName.ClientID%>");

            if (node.Level == 4) {
                sourceParentParentValue = "";
                sourceParentParentParentText = "";
                sourceParentParentValue = "";
                sourceParentValue = "";
                sourceValue = "";
                newNodeValue = "";
                newNodeActualValue = "";
                divbubbleObj.style.visibility = "hidden";
                divbubbleObj.style.display = "none";
                divbubbleObj.innerHTML = "";
                CloseVariableDiv();
                var hdnMappedVariable = document.getElementById("hdnMappedVariable");
                hdnMappedVariable.value = "";

                var NodeAssembly = node.Parent.Value.split("~");
                var Assemblies = NodeAssembly[1].split("^");
                var Assembly = Assemblies[1];
                var nodeTextForExpression = node.Value.replace(".ctor(", "").replace(")", "");

                var hidNodeValue = document.getElementById("<%=hidNodeValue.ClientID%>");
                hidNodeValue.value = nodeTextForExpression;

                var hidAssemblyName = document.getElementById("hidAssemblyName");
                var hidNameSpaceName = document.getElementById("hidNameSpaceName");
                var hidClassName = document.getElementById("hidClassName");
                var hidConstructor = document.getElementById("hidConstructor");
                hidAssemblyName.value = node.Parent.Parent.Parent.Text;

                var NodeNamespaceValue = node.Parent.Parent.Value.split("~");
                var Namespace = NodeNamespaceValue[2].split("^");
                var NamespaceName = Namespace[1];
                hidNameSpaceName.value = NamespaceName;
                var NodeClassValue = node.Parent.Value.split("~");
                var Class = NodeClassValue[3].split("^");
                var ClassName = Class[1];

                var myRegExp = new RegExp("\\\\", "g");

                hidAssemblyName.value = Assembly.replace(myRegExp, "$");
                hidClassName.value = ClassName;
                hidConstructor.value = sourceValue;
                document.getElementById("<%=divAssembly.ClientID%>").innerText = Assembly;
                document.getElementById("<%=divNameSpace.ClientID%>").innerText = hidNameSpaceName.value;
                document.getElementById("<%=divClass.ClientID%>").innerText = hidClassName.value;
                document.getElementById("<%=tbName.ClientID%>").innerText = hidClassName.value;
            }              
        }        
       
        function ClearExpression()
        {
             var hdnActualExpression = document.getElementById("<%=hdnActualExpression.ClientID%>");	          
             hdnActualExpression.value = "";
             var hidNodeValue = document.getElementById("<%=hidNodeValue.ClientID%>");
             hidNodeValue.value = "";

             var tbExpression = document.getElementById("<%=tbExpression.ClientID%>");
             tbExpression.value = "";             
             
             var ipBox = GetInputBox('IB_ExpressionControl');
             ipBox.Expression.ActualExprtessionString = "";
             ipBox.Expression.DisplayExpressionString = "";
             ipBox.Expression.MethodParameterList = "";
             ipBox.Expression.HtmlVerexpString = "";
             ipBox.Expression.ReferencedFunctionList = "";
             ipBox.Expression.ReferenceList = "";
             ipBox.Expression.NodeInfo = "";
             ipBox.Expression.ReturnType = "";       
        }
		
        function GetBrowserversion()
        {
	        var app=navigator.userAgent;
	        if(app.indexOf("MSIE")>-1)
	        {
		        return 1;	
	        }
	        else if(app.indexOf("Firefox/1.5")>-1)
	        {
		        return 2;	
	        }
	        else
	        {
	            return 3;
	        }
        }
        
        function ShowOnError()
        {
            var DivTree = document.getElementById("<%=divError.ClientID%>");       
            DivTree.style.display = "block";                       
            DivTree.style.position="absolute";     
            DivTree.style.left = 0 + 'px';
            DivTree.style.top = 360 + 'px';      
            DivTree.style.height=150+'px';   
        }

        function MapVariable() {
            
            var ddlVariable = document.getElementById("<%=ddlVariables.ClientID%>");
            var tbName = document.getElementById("<%=tbName.ClientID%>");
            var variableDiv = document.getElementById("<%=variablesDiv.ClientID%>");
            var hdnMappedVariable = document.getElementById("<%=hdnMappedVariable.ClientID%>");
            
            if(ddlVariable.selectedIndex != 0)
            {      
                var txtMappedVariable = document.getElementById("<%=txtMappedVariable.ClientID%>");                                        
                var textToPaste = "Variable." + ddlVariable.value;         
                if(textToPaste != "")    
                {                          
                   txtMappedVariable.value = textToPaste;
                   hdnMappedVariable.value = textToPaste;
                }
                
                if(tbName.value == "")
                {
                    tbName.value =  ddlVariable.value;
                }                
                //Close the div
                variableDiv.style.display = "none";                     
            }else
            {
                alert('<%=GR.GetString("SoaObject_SelectAVaraible")%>');
            }
        }
        
       function CreateVariableWindow()
       {       
            var divMapVariable = document.getElementById("<%=divMapVariable.ClientID%>");
            var divCreateVariable = document.getElementById("<%=divCreateVariable.ClientID%>");
            var txtVariableName = document.getElementById("<%=txtVariableName.ClientID%>");
            txtVariableName.value = "";
            divMapVariable.style.display = "none";                
            divCreateVariable.style.display = "block";
        }

        function ClearVariable() {         
            var variablesDiv = document.getElementById("<%=variablesDiv.ClientID%>");
            var txtMappedVariable = document.getElementById("<%=txtMappedVariable.ClientID%>");
            var hdnMappedVariable = document.getElementById("<%=hdnMappedVariable.ClientID%>");           
            txtMappedVariable.value = "";
            hdnMappedVariable.value = "";
            variablesDiv.style.display = "none";        
        }       
       
       function CancelVariableWindow()
       {
            var divMapVariable = document.getElementById("<%=divMapVariable.ClientID%>");
            var divCreateVariable = document.getElementById("<%=divCreateVariable.ClientID%>");
            divMapVariable.style.display = "block";                
            divCreateVariable.style.display = "none";             
       }        
        function confirmDelete() 
        {
            var msg = '<%=GR.GetString("soa_confirmdelete")%>';        
            if (confirm(msg) ) 
            {
                return true;
            }
            return false;
        }       
        
       function leftTrim ( s )	
        {
	        return s.replace( /^\s*/, "" );
        }

        function rightTrim ( s )
        {
	        return s.replace( /\s*$/, "" );
        }

        function trim ( s )
        {
	        return rightTrim(leftTrim(s));
        }          
            
        function CloseDiv()
        {
            var DivTree = document.getElementById("<%=divError.ClientID%>");
            DivTree.style.display = "none";   
        }       
       
    //Block HTML Decode        
    function HtmlDecode(s) 
	{ 
      var out = ""; 
      if (s==null) return; 
      var l = s.length; 
      for (var i=0; i<l; i++) 
      { 
            var ch = s.charAt(i); 
            if (ch == '&') 
            { 
                  var semicolonIndex = s.indexOf(';', i+1); 
            if (semicolonIndex > 0) 
            { 
                        var entity = s.substring(i + 1, semicolonIndex); 
                        if (entity.length > 1 && entity.charAt(0) == '#') 
                        { 
                              if (entity.charAt(1) == 'x' || entity.charAt(1) == 'X') 
                                    ch = String.fromCharCode(eval('0'+entity.substring(1))); 
                              else 
                                    ch = String.fromCharCode(eval(entity.substring(1))); 
                        } 
                    else 
                      { 
                              switch (entity) 
                              { 
                                    case 'quot': ch = String.fromCharCode(0x0022); break; 
                                    case 'amp': ch = String.fromCharCode(0x0026); break; 
                                    case 'lt': ch = String.fromCharCode(0x003c); break; 
                                    case 'gt': ch = String.fromCharCode(0x003e); break; 
                                    case 'nbsp': ch = String.fromCharCode(0x00a0); break; 
                                    case 'iexcl': ch = String.fromCharCode(0x00a1); break; 
                                    case 'cent': ch = String.fromCharCode(0x00a2); break;
                                    case 'pound': ch = String.fromCharCode(0x00a3); break; 
                                    case 'curren': ch = String.fromCharCode(0x00a4); break; 
                                    case 'yen': ch = String.fromCharCode(0x00a5); break; 
                                    case 'brvbar': ch = String.fromCharCode(0x00a6); break; 
                                    case 'sect': ch = String.fromCharCode(0x00a7); break; 
                                    case 'uml': ch = String.fromCharCode(0x00a8); break; 
                                    case 'copy': ch = String.fromCharCode(0x00a9); break; 
                                    case 'ordf': ch = String.fromCharCode(0x00aa); break; 
                                    case 'laquo': ch = String.fromCharCode(0x00ab); break; 
                                    case 'not': ch = String.fromCharCode(0x00ac); break; 
                                    case 'shy': ch = String.fromCharCode(0x00ad); break; 
                                    case 'reg': ch = String.fromCharCode(0x00ae); break;
                                    case 'macr': ch = String.fromCharCode(0x00af); break;
                                    case 'deg': ch = String.fromCharCode(0x00b0); break; 
                                    case 'plusmn': ch = String.fromCharCode(0x00b1); break;
                                    case 'sup2': ch = String.fromCharCode(0x00b2); break; 
                                    case 'sup3': ch = String.fromCharCode(0x00b3); break; 
                                    case 'acute': ch = String.fromCharCode(0x00b4); break; 
                                    case 'micro': ch = String.fromCharCode(0x00b5); break; 
                                    case 'para': ch = String.fromCharCode(0x00b6); break; 
                                    case 'middot': ch = String.fromCharCode(0x00b7); break;
                                    case 'cedil': ch = String.fromCharCode(0x00b8); break; 
                                    case 'sup1': ch = String.fromCharCode(0x00b9); break; 
                                    case 'ordm': ch = String.fromCharCode(0x00ba); break; 
                                    case 'raquo': ch = String.fromCharCode(0x00bb); break; 
                                    case 'frac14': ch = String.fromCharCode(0x00bc); break; 
                                    case 'frac12': ch = String.fromCharCode(0x00bd); break; 
                                    case 'frac34': ch = String.fromCharCode(0x00be); break; 
                                    case 'iquest': ch = String.fromCharCode(0x00bf); break; 
                                    case 'Agrave': ch = String.fromCharCode(0x00c0); break; 
                                    case 'Aacute': ch = String.fromCharCode(0x00c1); break; 
                                    case 'Acirc': ch = String.fromCharCode(0x00c2); break; 
                                    case 'Atilde': ch = String.fromCharCode(0x00c3); break; 
                                    case 'Auml': ch = String.fromCharCode(0x00c4); break; 
                                    case 'Aring': ch = String.fromCharCode(0x00c5); break; 
                                    case 'AElig': ch = String.fromCharCode(0x00c6); break; 
                                    case 'Ccedil': ch = String.fromCharCode(0x00c7); break; 
                                    case 'Egrave': ch = String.fromCharCode(0x00c8); break; 
                                    case 'Eacute': ch = String.fromCharCode(0x00c9); break; 
                                    case 'Ecirc': ch = String.fromCharCode(0x00ca); break; 
                                    case 'Euml': ch = String.fromCharCode(0x00cb); break; 
                                    case 'Igrave': ch = String.fromCharCode(0x00cc); break; 
                                    case 'Iacute': ch = String.fromCharCode(0x00cd); break; 
                                    case 'Icirc': ch = String.fromCharCode(0x00ce ); break; 
                                    case 'Iuml': ch = String.fromCharCode(0x00cf); break; 
                                    case 'ETH': ch = String.fromCharCode(0x00d0); break; 
                                    case 'Ntilde': ch = String.fromCharCode(0x00d1); break; 
                                    case 'Ograve': ch = String.fromCharCode(0x00d2); break; 
                                    case 'Oacute': ch = String.fromCharCode(0x00d3); break;
                                    case 'Ocirc': ch = String.fromCharCode(0x00d4); break; 
                                    case 'Otilde': ch = String.fromCharCode(0x00d5); break; 
                                    case 'Ouml': ch = String.fromCharCode(0x00d6); break; 
                                    case 'times': ch = String.fromCharCode(0x00d7); break; 
                                    case 'Oslash': ch = String.fromCharCode(0x00d8); break; 
                                    case 'Ugrave': ch = String.fromCharCode(0x00d9); break; 
                                    case 'Uacute': ch = String.fromCharCode(0x00da); break; 
                                    case 'Ucirc': ch = String.fromCharCode(0x00db); break; 
                                    case 'Uuml': ch = String.fromCharCode(0x00dc); break; 
                                    case 'Yacute': ch = String.fromCharCode(0x00dd); break; 
                                    case 'THORN': ch = String.fromCharCode(0x00de); break; 
                                    case 'szlig': ch = String.fromCharCode(0x00df); break; 
                                    case 'agrave': ch = String.fromCharCode(0x00e0); break; 
                                    case 'aacute': ch = String.fromCharCode(0x00e1); break; 
                                    case 'acirc': ch = String.fromCharCode(0x00e2); break; 
                                    case 'atilde': ch = String.fromCharCode(0x00e3); break; 
                                    case 'auml': ch = String.fromCharCode(0x00e4); break; 
                                    case 'aring': ch = String.fromCharCode(0x00e5); break; 
                                    case 'aelig': ch = String.fromCharCode(0x00e6); break; 
                                    case 'ccedil': ch = String.fromCharCode(0x00e7); break; 
                                    case 'egrave': ch = String.fromCharCode(0x00e8); break; 
                                    case 'eacute': ch = String.fromCharCode(0x00e9); break; 
                                    case 'ecirc': ch = String.fromCharCode(0x00ea); break; 
                                    case 'euml': ch = String.fromCharCode(0x00eb); break; 
                                    case 'igrave': ch = String.fromCharCode(0x00ec); break; 
                                    case 'iacute': ch = String.fromCharCode(0x00ed); break;
                                    case 'icirc': ch = String.fromCharCode(0x00ee); break; 
                                    case 'iuml': ch = String.fromCharCode(0x00ef); break; 
                                    case 'eth': ch = String.fromCharCode(0x00f0); break; 
                                    case 'ntilde': ch = String.fromCharCode(0x00f1); break; 
                                    case 'ograve': ch = String.fromCharCode(0x00f2); break; 
                                    case 'oacute': ch = String.fromCharCode(0x00f3); break; 
                                    case 'ocirc': ch = String.fromCharCode(0x00f4); break; 
                                    case 'otilde': ch = String.fromCharCode(0x00f5); break; 
                                    case 'ouml': ch = String.fromCharCode(0x00f6); break; 
                                    case 'divide': ch = String.fromCharCode(0x00f7); break; 
                                    case 'oslash': ch = String.fromCharCode(0x00f8); break; 
                                    case 'ugrave': ch = String.fromCharCode(0x00f9); break; 
                                    case 'uacute': ch = String.fromCharCode(0x00fa); break; 
                                    case 'ucirc': ch = String.fromCharCode(0x00fb); break; 
                                    case 'uuml': ch = String.fromCharCode(0x00fc); break; 
                                    case 'yacute': ch = String.fromCharCode(0x00fd); break; 
                                    case 'thorn': ch = String.fromCharCode(0x00fe); break; 
                                    case 'yuml': ch = String.fromCharCode(0x00ff); break; 
                                    case 'OElig': ch = String.fromCharCode(0x0152); break; 
                                    case 'oelig': ch = String.fromCharCode(0x0153); break; 
                                    case 'Scaron': ch = String.fromCharCode(0x0160); break; 
                                    case 'scaron': ch = String.fromCharCode(0x0161); break; 
                                    case 'Yuml': ch = String.fromCharCode(0x0178); break; 
                                    case 'fnof': ch = String.fromCharCode(0x0192); break; 
                                    case 'circ': ch = String.fromCharCode(0x02c6); break; 
                                    case 'tilde': ch = String.fromCharCode(0x02dc); break; 
                                    case 'Alpha': ch = String.fromCharCode(0x0391); break; 
                                    case 'Beta': ch = String.fromCharCode(0x0392); break; 
                                    case 'Gamma': ch = String.fromCharCode(0x0393); break; 
                                    case 'Delta': ch = String.fromCharCode(0x0394); break; 
                                    case 'Epsilon': ch = String.fromCharCode(0x0395); break; 
                                    case 'Zeta': ch = String.fromCharCode(0x0396); break; 
                                    case 'Eta': ch = String.fromCharCode(0x0397); break; 
                                    case 'Theta': ch = String.fromCharCode(0x0398); break; 
                                    case 'Iota': ch = String.fromCharCode(0x0399); break; 
                                    case 'Kappa': ch = String.fromCharCode(0x039a); break; 
                                    case 'Lambda': ch = String.fromCharCode(0x039b); break; 
                                    case 'Mu': ch = String.fromCharCode(0x039c); break; 
                                    case 'Nu': ch = String.fromCharCode(0x039d); break; 
                                    case 'Xi': ch = String.fromCharCode(0x039e); break; 
                                    case 'Omicron': ch = String.fromCharCode(0x039f); break; 
                                    case 'Pi': ch = String.fromCharCode(0x03a0); break; 
                                    case ' Rho ': ch = String.fromCharCode(0x03a1); break; 
                                    case 'Sigma': ch = String.fromCharCode(0x03a3); break; 
                                    case 'Tau': ch = String.fromCharCode(0x03a4); break; 
                                    case 'Upsilon': ch = String.fromCharCode(0x03a5); break; 
                                    case 'Phi': ch = String.fromCharCode(0x03a6); break; 
                                    case 'Chi': ch = String.fromCharCode(0x03a7); break; 
                                    case 'Psi': ch = String.fromCharCode(0x03a8); break; 
                                    case 'Omega': ch = String.fromCharCode(0x03a9); break; 
                                    case 'alpha': ch = String.fromCharCode(0x03b1); break; 
                                    case 'beta': ch = String.fromCharCode(0x03b2); break; 
                                    case 'gamma': ch = String.fromCharCode(0x03b3); break; 
                                    case 'delta': ch = String.fromCharCode(0x03b4); break; 
                                    case 'epsilon': ch = String.fromCharCode(0x03b5); break; 
                                    case 'zeta': ch = String.fromCharCode(0x03b6); break; 
                                    case 'eta': ch = String.fromCharCode(0x03b7); break; 
                                    case 'theta': ch = String.fromCharCode(0x03b8); break; 
                                    case 'iota': ch = String.fromCharCode(0x03b9); break; 
                                    case 'kappa': ch = String.fromCharCode(0x03ba); break; 
                                    case 'lambda': ch = String.fromCharCode(0x03bb); break; 
                                    case 'mu': ch = String.fromCharCode(0x03bc); break; 
                                    case 'nu': ch = String.fromCharCode(0x03bd); break; 
                                    case 'xi': ch = String.fromCharCode(0x03be); break; 
                                    case 'omicron': ch = String.fromCharCode(0x03bf); break; 
                                    case 'pi': ch = String.fromCharCode(0x03c0); break; 
                                    case 'rho': ch = String.fromCharCode(0x03c1); break; 
                                    case 'sigmaf': ch = String.fromCharCode(0x03c2); break; 
                                    case 'sigma': ch = String.fromCharCode(0x03c3); break; 
                                    case 'tau': ch = String.fromCharCode(0x03c4); break; 
                                    case 'upsilon': ch = String.fromCharCode(0x03c5); break; 
                                    case 'phi': ch = String.fromCharCode(0x03c6); break; 
                                    case 'chi': ch = String.fromCharCode(0x03c7); break; 
                                    case 'psi': ch = String.fromCharCode(0x03c8); break; 
                                    case 'omega': ch = String.fromCharCode(0x03c9); break; 
                                    case 'thetasym': ch = String.fromCharCode(0x03d1); break; 
                                    case 'upsih': ch = String.fromCharCode(0x03d2); break; 
                                    case 'piv': ch = String.fromCharCode(0x03d6); break; 
                                    case 'ensp': ch = String.fromCharCode(0x2002); break; 
                                    case 'emsp': ch = String.fromCharCode(0x2003); break; 
                                    case 'thinsp': ch = String.fromCharCode(0x2009); break; 
                                    case 'zwnj': ch = String.fromCharCode(0x200c); break; 
                                    case 'zwj': ch = String.fromCharCode(0x200d); break; 
                                    case 'lrm': ch = String.fromCharCode(0x200e); break; 
                                    case 'rlm': ch = String.fromCharCode(0x200f); break; 
                                    case 'ndash': ch = String.fromCharCode(0x2013); break; 
                                    case 'mdash': ch = String.fromCharCode(0x2014); break; 
                                    case 'lsquo': ch = String.fromCharCode(0x2018); break; 
                                    case 'rsquo': ch = String.fromCharCode(0x2019); break; 
                                    case 'sbquo': ch = String.fromCharCode(0x201a); break; 
                                    case 'ldquo': ch = String.fromCharCode(0x201c); break; 
                                    case 'rdquo': ch = String.fromCharCode(0x201d); break; 
                                    case 'bdquo': ch = String.fromCharCode(0x201e); break; 
                                    case 'dagger': ch = String.fromCharCode(0x2020); break; 
                                    case 'Dagger': ch = String.fromCharCode(0x2021); break; 
                                    case 'bull': ch = String.fromCharCode(0x2022); break; 
                                    case 'hellip': ch = String.fromCharCode(0x2026); break; 
                                    case 'permil': ch = String.fromCharCode(0x2030); break; 
                                    case 'prime': ch = String.fromCharCode(0x2032); break; 
                                    case 'Prime': ch = String.fromCharCode(0x2033); break; 
                                    case 'lsaquo': ch = String.fromCharCode(0x2039); break; 
                                    case 'rsaquo': ch = String.fromCharCode(0x203a); break; 
                                    case 'oline': ch = String.fromCharCode(0x203e); break; 
                                    case 'frasl': ch = String.fromCharCode(0x2044); break; 
                                    case 'euro': ch = String.fromCharCode(0x20ac); break; 
                                    case 'image': ch = String.fromCharCode(0x2111); break; 
                                    case 'weierp': ch = String.fromCharCode(0x2118); break; 
                                    case 'real': ch = String.fromCharCode(0x211c); break; 
                                    case 'trade': ch = String.fromCharCode(0x2122); break; 
                                    case 'alefsym': ch = String.fromCharCode(0x2135); break; 
                                    case 'larr': ch = String.fromCharCode(0x2190); break; 
                                    case 'uarr': ch = String.fromCharCode(0x2191); break; 
                                    case 'rarr': ch = String.fromCharCode(0x2192); break; 
                                    case 'darr': ch = String.fromCharCode(0x2193); break; 
                                    case 'harr': ch = String.fromCharCode(0x2194); break; 
                                    case 'crarr': ch = String.fromCharCode(0x21b5); break; 
                                    case 'lArr': ch = String.fromCharCode(0x21d0); break; 
                                    case 'uArr': ch = String.fromCharCode(0x21d1); break; 
                                    case 'rArr': ch = String.fromCharCode(0x21d2); break; 
                                    case 'dArr': ch = String.fromCharCode(0x21d3); break; 
                                    case 'hArr': ch = String.fromCharCode(0x21d4); break; 
                                    case 'forall': ch = String.fromCharCode(0x2200); break; 
                                    case 'part': ch = String.fromCharCode(0x2202); break; 
                                    case 'exist': ch = String.fromCharCode(0x2203); break; 
                                    case 'empty': ch = String.fromCharCode(0x2205); break; 
                                    case 'nabla': ch = String.fromCharCode(0x2207); break; 
                                    case 'isin': ch = String.fromCharCode(0x2208); break; 
                                    case 'notin': ch = String.fromCharCode(0x2209); break; 
                                    case 'ni': ch = String.fromCharCode(0x220b); break; 
                                    case 'prod': ch = String.fromCharCode(0x220f); break; 
                                    case 'sum': ch = String.fromCharCode(0x2211); break; 
                                    case 'minus': ch = String.fromCharCode(0x2212); break; 
                                    case 'lowast': ch = String.fromCharCode(0x2217); break; 
                                    case 'radic': ch = String.fromCharCode(0x221a); break; 
                                    case 'prop': ch = String.fromCharCode(0x221d); break; 
                                    case 'infin': ch = String.fromCharCode(0x221e); break; 
                                    case 'ang': ch = String.fromCharCode(0x2220); break; 
                                    case 'and': ch = String.fromCharCode(0x2227); break; 
                                    case 'or': ch = String.fromCharCode(0x2228); break; 
                                    case 'cap': ch = String.fromCharCode(0x2229); break; 
                                    case 'cup': ch = String.fromCharCode(0x222a); break; 
                                    case 'int': ch = String.fromCharCode(0x222b); break; 
                                    case 'there4': ch = String.fromCharCode(0x2234); break; 
                                    case 'sim': ch = String.fromCharCode(0x223c); break; 
                                    case 'cong': ch = String.fromCharCode(0x2245); break; 
                                    case 'asymp': ch = String.fromCharCode(0x2248); break; 
                                    case 'ne': ch = String.fromCharCode(0x2260); break; 
                                    case 'equiv': ch = String.fromCharCode(0x2261); break; 
                                    case 'le': ch = String.fromCharCode(0x2264); break; 
                                    case 'ge': ch = String.fromCharCode(0x2265); break; 
                                    case 'sub': ch = String.fromCharCode(0x2282); break; 
                                    case 'sup': ch = String.fromCharCode(0x2283); break; 
                                    case 'nsub': ch = String.fromCharCode(0x2284); break; 
                                    case 'sube': ch = String.fromCharCode(0x2286); break; 
                                    case 'supe': ch = String.fromCharCode(0x2287); break; 
                                    case 'oplus': ch = String.fromCharCode(0x2295); break; 
                                    case 'otimes': ch = String.fromCharCode(0x2297); break; 
                                    case 'perp': ch = String.fromCharCode(0x22a5); break; 
                                    case 'sdot': ch = String.fromCharCode(0x22c5); break; 
                                    case 'lceil': ch = String.fromCharCode(0x2308); break; 
                                    case 'rceil': ch = String.fromCharCode(0x2309); break; 
                                    case 'lfloor': ch = String.fromCharCode(0x230a); break; 
                                    case 'rfloor': ch = String.fromCharCode(0x230b); break; 
                                    case 'lang': ch = String.fromCharCode(0x2329); break; 
                                    case 'rang': ch = String.fromCharCode(0x232a); break; 
                                    case 'loz': ch = String.fromCharCode(0x25ca); break; 
                                    case 'spades': ch = String.fromCharCode(0x2660); break; 
                                    case 'clubs': ch = String.fromCharCode(0x2663); break; 
                                    case 'hearts': ch = String.fromCharCode(0x2665); break; 
                                    case 'diams': ch = String.fromCharCode(0x2666); break; 
                                    default: ch = ''; break; 
                              } 
                        } 
                        i = semicolonIndex; 
                   } 
            } 
            out += ch; 
      } 
      return out; 
}      

</script>

