<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.CreateList.SkeltaListTableSelect" %>
<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
    <script type="text/JavaScript" language="JavaScript">
        function Checkbox1_onclick() 
        {
            //alert('Testing Checkbox1_onclick');      
            //alert(document.getElementById("RadioGenTbl")); 
            var ctrlid="<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(CtrlID, false)%>";
            if(document.getElementById("RadioGenTbl").checked)
            {
            
                //alert(ctrlid);
                //alert(document.getElementsByName(ctrlid+"_hValue"));
            
            
                document.getElementById(ctrlid+"_hValue").value="GeneralTable";
                document.getElementById("ExistTableDiv").style.display='none';
            }
            else
            {
                //alert('Existing');
                document.getElementById(ctrlid+"_hValue").value="ExistingTable";
                document.getElementById("ExistTableDiv").style.display='block';
            }
        }
    
        function OpenHelpWindow(applicationName)
        {           
            //return  window.open("CreateListTableHelp.htm",'Help','top=100,left=100,resizable=yes,scrollbars=yes');
            return  window.open("../Repository/Site/CreateDListTableHelp.aspx?ApplicationName=" + applicationName,'Help','top=100,left=100,height='+parseInt(document.body.clientHeight)+',width='+parseInt(document.body.clientWidth)+',resizable=yes');
        }
    </script>
    <link type="text/css" rel="stylesheet" href="<%=cssPath %>Common/StyleSheet/Global.css" />
</telerik:RadCodeBlock>
  <div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock2">
                    <img src="<%=cssPath %>SkeltaForms/images/new-form-icon.jpg" align="absmiddle" />
                    <span class="pagetitle"><%=resManager.GlobalResourceSet.GetString("FormListSelectTable") %></span>
                </telerik:RadCodeBlock>
            </td>
        </tr>
    </table>
    <br />
    <table width="98%" border="0" cellpadding="5" cellspacing="1" class="tablebg">
        <tr>
            <td class="lefttdbg" valign="top" height="100" style="width: 50%">
                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock3">
                    <span class="subtitle"><%=resManager.GlobalResourceSet.GetString("FormListTableOptionOne") %></span> <br />
                    <span class="description"><%=resManager.GlobalResourceSet.GetString("FormListListTableControlOption1Text") %></span>
                </telerik:RadCodeBlock>
            </td>
            <td  class="righttdbg" style="width: 50%">
                <label>
                    <input id="RadioGenTbl" name="Test" checked="checked" title="Generic Table" type="radio"
                        onclick="Checkbox1_onclick();" class="inputradio" />
                    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock4">
                        <span class="description"><%=resManager.GlobalResourceSet.GetString("FormListGenericTable") %></span>
                    </telerik:RadCodeBlock>
                </label>
            </td>
        </tr>
        <tr>
            <td class="lefttdbg" valign="top" height="100">
                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock5">
                    <span class="subtitle"><%=resManager.GlobalResourceSet.GetString("FormListTableOptionTwo") %></span><br />
                    <span class="description"><%=resManager.GlobalResourceSet.GetString("FormListListTableControlOption2Text") %>
                    <br /><b><%=resManager.GlobalResourceSet.GetString("FormSelectDListTableNote1Text")%></b><br /><a href="#"
                            onclick="javascript:OpenHelpWindow('<%=ApplicationName%>');"><%=resManager.GlobalResourceSet.GetString("FormListOptionReadMore") %></a></span>
                </telerik:RadCodeBlock>
            </td>
            <td  class="righttdbg" style="width: 416px">
                <p>
                <input id="RadioExistTbl" name="Test" title="Existing Table" type="radio" class="inputradio" onclick="Checkbox1_onclick();" />
                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock6">
                    <span class="description"><%=resManager.GlobalResourceSet.GetString("FormListExistingTableText") %></span>
                </telerik:RadCodeBlock>
                <div id="ExistTableDiv" style="display: none">
                    <table width="100%" border="0" cellspacing="5" cellpadding="4">
                        <tr>
                            <td width="60%" class="description">
                                <span class="description"> Select Table</span><br />                                    
                                <asp:ListBox ID="lstListTables"  runat="server" Width="100%" Rows="8" ></asp:ListBox>
                            </td>
                            <td valign="top" width="40%">
                                <br />
                                <asp:ImageButton runat="server" ID="imgRefresh" OnClick="imgRefresh_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <input id="hValue" type="hidden" name="hValue" runat="server">
            </td>
        </tr>
    </table>
    <telerik:RadAjaxManager id="RadAjaxManager2" runat="server">
        <AjaxSettings>				
            <telerik:AjaxSetting AjaxControlID="imgRefresh">
                <UpdatedControls>                           
					<telerik:AjaxUpdatedControl ControlID="lstListTables"></telerik:AjaxUpdatedControl>                        
				</UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
</div>
    
    
    
       
    