<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.SkeltaListStorageCodeFile"  Theme="" StylesheetTheme="" %>
<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer" TagPrefix="cc1" %>
<%@ Register TagPrefix="cc2" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetCommonRelativeUrl("stylesheet/global.css")%>" >
<script src="<%=ProcessDesignerControl.GetJscriptUrl("../Common/javascripts/XmlTreeview.js")%>"></script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
    <style>
        html, body {
            height:100%;
            overflow:auto;
            overflow-x:hidden !important;
        }
    </style>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" /> 
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
    </script>
    <form id="form1" runat="server">
           <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
         <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
           <table width=100% height="100%" cellpadding=0 cellspacing=0   border="0" class="tablebg">
            <tr>
                <td valign="top" align="center" >
                    <table width=100% height=100% cellspacing=1 cellpadding=1 border=0>
                       <tr>
                            <td class="lefttdbg" align="Left" width="20%">
                              <span class="subtitle"><%=ProcessDesignerControl.GlobalResourceSet.GetString("ListXmlVariableSelectList")%></span>
                            </td>
                            <td class="righttdbg">
                                 <table cellpadding=3 cellspacing=0 >
                                    <tr>
                                         <td id="Td1" class="righttdbg" runat="server" align="left" width="25%"> 
                                            <asp:TextBox ID="txtListName" runat="server" class="inputtext" ></asp:TextBox>
                                            <asp:HiddenField ID="txtListID" runat="server" />
                                        </td>
                                        <td>                         
                                            <a href="#" onclick = "selectListId();return false;">  <img src="../Plugins/EnterpriseConsole/images/group-explore.gif" width="25" height="23" border="0" align="left"
                                                id="Img1"  /></a>
                                             <telerik:RadWindowManager ID="RadWindowManager1" Skin="AWTWindow" EnableEmbeddedSkins="false" runat="server" Behaviors="Close" RenderMode="Classic" VisibleStatusbar="false" IconUrl="..\images\Icon-ListExplorer.png">  
                                             </telerik:RadWindowManager>
                                         </td>
                                    </tr>
                                 </table>
                            </td>
                         </tr>
                       
                        <tr>
                              <td align="center"  class="lefttdbg" colspan="2" >
                                <table cellpadding=0 cellspacing=0 width=100%>
                                    <tr>
                                        <td  width=50%>
                                             <span class="subtitle"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableSchema")%></span>
                                        </td>
                                        <td  width=50% align="Right">
                                             <input type="button" id="SchemaButton" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVarRefreshSchema")%>" class="inputbutton" onclick="javascrpt:RefreshSchema();" /> 
                                             &nbsp;&nbsp;
                                        </td>
                                   </tr>
                                   <tr>
                                        <td width=100% valign="top" align="center" colspan=2 style="padding-left:-15px" class="lefttdbg">
                                            <div id="divSchema">
                                                <cc1:XmlSchemaDesigner ID="XmlSchemaDesigner1" Width="680px" Height="242px" IsSchemaEditable=false runat="server" />              
                                                </div>
                                        </td>
                                   </tr>
                                </table>
                            </td>
                         </tr>
                       
                        <tr>
                            <td class="lefttdbg" colspan="2"> 
                                <table width="100%" cellspacing=0  cellpadding=2 border=0 align="center" >
                                      <tr>
                                         <td  class="lefttdbg"  >
                                             <span class="subtitle"><%=ProcessDesignerControl.GlobalResourceSet.GetString("ListXmlVarWorkChooseListItem") %></span>
                                         </td> 
                                      </tr>
                                      <tr>
                                            <td class="lefttdbg">
                                               <table width=97% cellspacing=1 cellpadding=2 border=0 class="tablebg"  align="center" >
                                                    <tr >
                                                        
                                                         <td  class="righttdbg" width="20%" >
                                                              <span class="description"><asp:RadioButton ID="RadioButton1" GroupName="ChooseItem" runat="server" CssClass="inputradio"/>&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("XMLCurrent")%> </span>
                                                          </td>
                                                          <td  class="righttdbg" valign="top">
                                                             <table>
                                                                <tr>
                                                                    <td><img src="<%=ProcessDesignerControl.GetThemeRelativeUrl("images/icon-tips.png")%>" height="16" border="0">
                                                                    </td>
                                                                    <td>
                                                                    <span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("ListXmlVarRunTimeCurrentContextText") %></span>
                                                                    </td>
                                                                </tr>
                                                              </table>
                                                          </td>
                                                     </tr>
                                                     <tr>
                                                          <td class="righttdbg" valign=top>
                                                             <span class="description"><asp:RadioButton ID="RadioButton2" GroupName="ChooseItem" runat="server"  CssClass="inputradio"/>&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("XMLVarNew")%> </span>
                                                           </td>
                                                           <td class="righttdbg" >
                                                            <table>
                                                                <tr>
                                                                    <td><img src="<%=ProcessDesignerControl.GetThemeRelativeUrl("images/icon-tips.png")%>" height="16" border="0">
                                                                    </td>
                                                                    <td>
                                                                    <span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("ListXmlVarRunTimeNewContextText") %></span>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                           
                                                          </td>
                                                    </tr>                                             
                                            </table>
                                        </td>
                                    </tr>
                            </table>               
                            </td>
                       </tr>
                    </table>
                </td>
               </tr>
               <asp:HiddenField ID="SiteId" runat="server" />
              <tr class="lefttdbg">
                <td align="right" valign="top" colspan="2">
                    <table cellpadding=1 cellspacing=1>
                        <tr>
                            <td>
                            
                            <input type="button" id="btnCancel" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("ExpCancel")%>" class="inputsecondarybutton"  onclick="javascript:window.parent.close();"  />&nbsp;&nbsp;&nbsp;     
                                <input type="button" id="btnSave" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlSaveVariable")%>" class="inputbutton" onclick="javascript: CallServer()" />    
                            </td>
                        </tr>
                   </table>
                    
                </td>
            </tr>
               
        </table>
  
        <cc2:AjaxPageControl id="AjaxPageControl1" runat="server" style="Z-INDEX: 104; LEFT: 440px; POSITION: absolute; TOP: 88px"></cc2:AjaxPageControl> 
    </form>
    <iframe id="XmlSchemaFrame"   style="position:absolute;display:none;z-index: 101;border:1px solid #256194;"></iframe>
    <div id="PropertyDiv" style="border:1px solid #256194;display:none"/>
</body>
</html>

<script>
    function selectListId() {
        var modevar = "";
        modevar = "List";
        var oWindow1 = radopen("../plugins/enterpriseconsole/eventprovider/ListExplorer.aspx?mode=" + modevar, null);
        oWindow1.set_modal(true);
        oWindow1.set_title("Select List/List Items");
        oWindow1.setSize(350, 325);
        oWindow1.set_iconUrl("..\plugins\enterpriseconsole\images\Icon-ListExplorer.png");

        oWindow1.add_beforeClose(onClientBeforeCloseListExplorer);

        function onClientBeforeCloseListExplorer(sender, args)
        {
            var returnlistid = args.get_argument();

            if (returnlistid !== null && returnlistid !== undefined)
            {
                var dataArray = returnlistid.split("/");
                var list = document.getElementById('txtListName');
                if (dataArray.length > 2)
                    list.value = dataArray[2];
                var listid = document.getElementById('txtListID');
                listid.value = dataArray[0];
                CallServerSideMethod(null, 'LoadTreeForList', "DataTableTest", CallbackLoadTreeForList, 'table', listid.value);
            }

            sender.remove_beforeClose(onClientBeforeCloseListExplorer);
        }
    }
function CallbackLoadTreeForList(context, result, response)
{
    
   if(result!=null)
   {
       if(result[0]!=null)
       {
       
            if(result[1].length>5)
            {
            se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', result[1]);
            document.getElementById("xmlTreeDiv").innerHTML = "";  
            return;
            }
       }
       
       var objTree = new jsTree;
       eval(result);
       document.getElementById("xmlTreeDiv").innerHTML = "";
       objTree.buildDOM();   
       var strInnerHTML = document.getElementById("xmlTreeDiv").innerHTML;
       document.getElementById("xmlTreeDiv").innerHTML = strInnerHTML.replace("<DIV><DIV>",""); 
       
   }
 }


function CallServer()
{
//debugger;
   if(top.document.getElementById("variableName").value=="")
    {
        top.document.getElementById("variableName").focus();
        se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableEnterVariableName")%>');
        return false;
    }
    else
    {
        if (!CheckInputValue(top.document.getElementById("variableName").value))
        {
            top.document.getElementById("variableName").focus();
            return false;
        }
    }
    if(document.getElementById('txtListName').value=="" || document.getElementById('txtListName').value=="Select")
    {
        se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.GlobalResourceSet.GetString("Select List")%>');
        return false;
    }
    
       
    
    var xVariable =new XmlVariable();
    xVariable.VariableName = top.document.getElementById("variableName").value;
    xVariable.VariableDescription = top.document.getElementById("VarDescription").value;
    xVariable.EditMode = top.document.getElementById("HdnModeEdit").value;
    xVariable.ListName=document.getElementById("txtListName").value;  
    xVariable.ListId=document.getElementById("txtListID").value; 
    xVariable.Scope =top.document.getElementById("variablescope").value;
    
    if(document.getElementById("RadioButton1").checked==true)
         xVariable.ListItemType ="Current";
    else if(document.getElementById("RadioButton2").checked==true)
        xVariable.ListItemType ="New";
    CallServerSideMethod(null, 'SaveVariable',"DataTableTest",CallbackSaveVariable,'table',xVariable);
}

function XmlVariable()
{
    this.VariableName = "";
    this.VariableDescription = "";
    this.ListId="";
    this.ListItemType="Current"; 
    this.Scope = "global";
}

function CallbackSaveVariable(context, result, response)
{
   var error;
    
   if((result!=null)&&(result!=""))
   {
        error=result;
   }
   if(error!=null)
   {
        if(error[0]=="errReturned")
        {
            se.ui.messageDialog.showError('<%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', error[1]);
            return false;
        }   
   }
    se.ui.messageDialog.showAlert('<%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%:ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("XmlVariableSave")%>');
  
  top.refreshGrid(top.document.getElementById("variableName").value);
  
}
function RefreshSchema()
{
    if(trim(document.getElementById("txtListName").value)!="")
      {
        var listName= document.getElementById('txtListName');
        CallServerSideMethod(null, 'LoadTreeForList',"DataTableTest",CallbackLoadTreeForList,'table',listName.value);
     }
}

    function CheckInputValue(nodetext)
    {
        if (/\s/.test(nodetext))
        {
            se.ui.messageDialog.showError('<%=Skelta.Forms.Core.Common.GetEscapedJavaScriptString(ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables"))%>', '<%=Skelta.Forms.Core.Common.GetEscapedJavaScriptString(ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("XmlVariableVariableNamespace"))%>');
            return false;
        }

        var pattern = "^[^!=|~\\s@#$%^&*()+`\\-\\\\{}:\\\"<>?\\[\\];',./_\\d][^!=|~\\s@#$%^&*()+`\\-\\\\{}:\\\"<>?\\[\\];',./]+$";
        var validateTextRegex = new RegExp(pattern);
        if (!validateTextRegex.test(nodetext))
        {
            se.ui.messageDialog.showError('<%=Skelta.Forms.Core.Common.GetEscapedJavaScriptString(ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables"))%>', '<%=Skelta.Forms.Core.Common.GetEscapedJavaScriptString(ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Err_XmlVariableSpecialCharacters"))%>');
            return false;
        }

        return true;
    }

function ltrim ( s )	
{
	return s.replace( /^\s*/, "" );
}

function rtrim ( s )
{
	return s.replace( /\s*$/, "" );
}

function trim ( s )
{
	return rtrim(ltrim(s));
}

</script>