<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.UcDynamicControl" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<Style type="text/css">
.hiddenControl {display:none}
    .inputselect1
{
    max-height: 25px !important;
    height: 25px !important;
}
    .inputtext
{
    height: 21px !important;
}
</Style>
<link href="<%:ThemePath%>Common/StyleSheet/Global.css" rel="stylesheet" />
<link href="<%:ThemePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%:ThemePath%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
<link rel="stylesheet" type="text/css" href="<%:ThemePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
<link rel="stylesheet" type="text/css" href="<%:ThemePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
<link rel="stylesheet" type="text/css" href="<%:ThemePath%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css"/>
<script>
    se.ui.messageDialog.setGlobalOptions({
        localization: { // All localization related default can be set
            closeButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
});
</script>
<div style="width:98%;">
     <telerik:RadScriptManager ID="RadScriptManager1" runat="server"/>
    <table style="width:100%;margin:auto;border-width:0;border-spacing:0px">
        <br />
        <tr>
          <td rowspan="2" style="vertical-align: middle;width:40px;text-align:center;padding-left:25px;">
            <img style="vertical-align:middle" alt="" src="<%=ThemePath%>Repository/ListControl/images/icons-ribbon/lookupsklist.png"/>
          </td>
          <td id="tdheader" runat="server" colspan="2" class="lblDescriptionStyle" style="padding-left:10px;">
          </td>
        </tr>
    </table>

    <table style="height: 60%; width: 100%; border-width:0;border-spacing:6px;padding-left:61px;padding-right:37px;">
        <tr style="width:100%;">
            <td style="width: 30%;" class="lblNameStyle" >
                <%=skrm.GlobalResourceSet.GetString("dqb_Condition") %> 
            </td>
            <td style="width:70%;">
                <select id="selMultCond" name="selMultCond" runat="server" class="inputselect1">
                    <option value="" selected="selected"></option>
                    <option value=" ( "></option>
                </select>
            </td>
        </tr>
        <tr style="width:100%;">
            <td style="width: 30%;" class="lblNameStyle" >
                <%=skrm.GlobalResourceSet.GetString("dqb_Table") %> 
            </td>
            <td style="width:70%;">
                <input type="text" onclick="OpenTableStructureUC();"  id="RadComboTableUC" runat="server"
                    readonly="readonly"  class="txtboxStyle" />
            </td>
        </tr>
        <tr style="width:100%;">
            <td style="width: 30%;" class="lblNameStyle" >
                <%=skrm.GlobalResourceSet.GetString("dqb_Column") %> 
            </td>
            <td style="width:70%;">
                <telerik:RadComboBox   ID="RadComboColumnsUC"  RenderMode="Classic" runat="server" Height="150px" EnableLoadOnDemand="true"
                       EnableEmbeddedSkins="false"  EnableViewState="true" AutoPostBack="true" MarkFirstMatch="true" Skin="AWTCombobox">
                 </telerik:RadComboBox>
            </td>
        </tr>
        <tr style="width:100%;">
            <td style="width: 30%;" class="lblNameStyle" >
                <%=skrm.GlobalResourceSet.GetString("dqb_Operator") %> 
            </td>
            <td style="width:70%;">
                <select id="SelectOperator" name="SelectOperator" class="inputselect1" runat="server" onchange="SelectOperatorChanged(this);">
                    <option value=" = " selected>=</option>
                    <option value=" > ">&gt;</option>
                    <option value=" < ">&lt;</option>
                    <option value="&gt;=">&gt;=</option>
                    <option value="&lt;= ">&lt;=</option>
                    <option value=" <> ">&lt;&gt;</option>
                    <option value=" IN ">IN</option>
                    <option value=" Not IN ">Not IN</option>
                    <option value=" Like ">Like</option>
                    <option value=" Is Null ">Is Null</option>
                    <option value=" Is Not Null ">Is Not Null</option>
                </select>
            </td>
        </tr>
        <tr style="width:100%;">
             <td style="width: 30%;" class="lblNameStyle" >
                 <%=skrm.GlobalResourceSet.GetString("dqb_Type") %> 
             </td>
             <td style="width:70%;">
                 <telerik:RadComboBox ID="SelectType"  RenderMode="Classic" runat="server" OnClientSelectedIndexChanged="ShowTableField" Height="100px"
                    EnableEmbeddedSkins="false" AutoPostBack="false" Skin="AWTCombobox">
                 </telerik:RadComboBox>
             </td>
        </tr>
        <tr style="width:100%;">
            <td style="width: 30%;" class="lblNameStyle" >
                <%=skrm.GlobalResourceSet.GetString("dqb_Value") %> 
            </td>
            <td style="width:50%;" class="hiddenControl" id="tdTableField" runat="server">
                <table style="width:100%">
                    <tr style="width:100%;">
                        <td style="width:70%;">
                            <input type="text" onclick="ToggleTableMax(this);" id="Text1" readonly="readonly" class="txtboxStyle"
                                runat="server" style="width:95%;" />
                        </td>
                        <td style="width:30%;">
                            <select id="selTableFieldId" runat="server" class="inputselect1">
                            </select>
                        </td>
                    </tr>
                </table>
            </td>
            <td id="tdtxtBox" style="width:20%;" runat="server">
                <asp:TextBox ID="txtType" runat="server" onblur="javascript:ValidateTextData(this);" CssClass="txtboxStyle"></asp:TextBox>
            </td>
        </tr>
        <tr style="width:100%;">
            <td style="width: 30%;" class="lblNameStyle" >
                <%=skrm.GlobalResourceSet.GetString("dqb_Condition") %> 
            </td>
            <td style="width:70%;">
                <select id="SelectCondition" name="SelectCondition" class="inputselect1" runat="server">
                    <option value="End" selected></option>
                    <option value="And "></option>
                    <option value="Or "></option>
                    <option value=" ) "> </option>
                    <option value=") OR "></option>
                    <option value=") AND "></option>
                </select>
             </td>

        </tr>
        <tr style="vertical-align:top;width:100%;">
            <td style="width:100%;" colspan="2">

                <telerik:RadTextBox ID="txtQuery" runat="server" ReadOnly="true" TextMode="MultiLine" Height="80px" Width="100%" EnableEmbeddedSkins="false">
                </telerik:RadTextBox>
                <input type="hidden" id="hdnQuery" runat="server" />
            </td>
        </tr>
    </table>
</div>
<div style="height: 110px; width: 100%; background-color: White; border: Solid 2px #d2d2d2;
    display: none;" id="divTreeUC" runat="server">
    <table style="width: 100%;border-width:0" class="lefttdbg">
        <tr style="width:100%;">
            <td  class="righttdbg" style="width: 100%;text-align:right" colspan="2">
                <a id="aCloseDivUC" onclick="CloseDivUC()">
                    <img alt="" style="border: 0" src="<%=ThemePath%>Common/Images/close.gif" />
                </a>
            </td>
        </tr>
    </table>
    <telerik:RadTreeView  ID="RadTreeViewUC"  EnableViewState="true" Height="100px" runat="server" Skin="AWTTreeView" EnableEmbeddedSkins="false" ShowLineImages="false">
    </telerik:RadTreeView>
    <input type="hidden" id="hdnTableName" runat="server" />
    
</div>
<div style="height: 110px; width: 100%; background-color: White; border: Solid 2px #d2d2d2;
    display: none;" id="div1" runat="server">
    <table class="lefttdbg"  style="width: 100%;border-width:0">
        <tr style="width:100%;">
            <td  style="width: 100%;text-align:right" class="righttdbg" colspan="2">
                <a id="a1" onclick="CloseDivTable()">
                    <img alt="" style="border: 0" src="<%=ThemePath%>Common/Images/close.gif" />
                </a>
            </td>
        </tr>
    </table>
    <telerik:RadTreeView  ID="RadTreeView1"  EnableViewState="true" Height="100px" runat="server" Skin="AWTTreeView" RetainScrollPosition="true" EnableEmbeddedSkins="false" ShowLineImages="false">
    </telerik:RadTreeView>
    <input type="hidden" id="hdnTableFieldName" runat="server" />
</div>

<table style="width:100%;">
    <tr style="width:100%;">
        <td style="width:100%;padding-left:65px;" colspan="2"> <span class="note"><%=skrm.GlobalResourceSet.GetString("dqb_indexnote")%> </span> 
        </td>
    </tr>
    <tr>
        <div class="lineCss" style="width:92%;margin-left:20px;border-bottom-width: 0px;"></div>
    </tr>
    <tr  style="width:100%;">
        <td style="text-align:right;width:100%;padding-bottom:12px;padding-top:17px;"colspan="2">
             <input type="submit"  disabled="disabled" onclick="javascript: return ValidateLookupQuery();"  id="idButtonInsert" runat="server" class="inputbutton" style="margin-right:6px;" />
            <input type="button" id="clearId"  runat="Server" name="clearId" class="inputsecondarybutton" onclick="ClearQuery();" style="margin-right:6px;" />
            <button type="button" name="btnClose" class="inputsecondarybutton" onclick="javascript:closeWindowInternal();" style="margin-right: 6px;"><%=skrm.GlobalResourceSet.GetString("ec_BAMReports_BtnExportClose")%></button>
             <asp:Button runat="server" ID="btnSelect"  CssClass="inputbutton" style="margin-right:16px;" />
        </td>
    </tr>
</table>

<script type="text/javascript">

    function SelectOperatorChanged(dropdownItem) {
        var combo = $find('<%= SelectType.ClientID %>');
        var text = document.getElementById("<%=txtType.ClientID%>");
        if (dropdownItem[9].selected || dropdownItem[10].selected) {            
            combo.disable();
            combo.clearSelection();
            
            text.value = "";
            text.disabled = true;
        }
        else {
            combo.enable();
            text.disabled = false;
        }
    }

    function ValidateLookupQuery() {
    try
    {
        var combo = $find('<%= SelectType.ClientID %>');
        if(combo.SelectedIndex == 1)
        {
            var txtType = document.getElementById('IdDynamicQuery_txtType');
            if(txtType)
            {
                var data =  document.getElementById("hdnTable")
                if( (txtType.value == "" || txtType.value.length == 0) )
                {
                    if(data == null)
                    {
                        se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("List Query") %>", "Select the column field");
                        ToggleTableMax();
                        return false;
                    }
                    else if(data.value.length == 0)
                    {
                        se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("List Query") %>", "Select the column field");
                        ToggleTableMax();
                        return false;
                    }
                    else
                    {
                        data.value = "";
                        return true;
                    }
                    
                    
                }
            }
        }
    }
    catch(err)
    {
        return true;
    }
    
    
    return true;
}
    function ValidateTextData(obj)
    {
       try
       {
            
            var iChars = "!#$^&=-\\\;/{}|\":<>?";
            
            if(obj.value != "")
            {
               var sText=obj.value;
               // validate for special characters only if the value is not in single quote
               if(sText.indexOf("'") == 0 && sText.lastIndexOf("'") == sText.length-1)
               {
                  // 
  	           }
  	           else
  	           {
  	               for (var i = 0; i < sText.length; i++)
                   {
  	                   if (iChars.indexOf(sText.charAt(i)) != -1)
  	                   {
                           se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("List Query") %>", "<%=skrm.GlobalResourceSet.GetString("ReportActivity_SpecialChar") %>"+"  "+ "<%=skrm.GlobalResourceSet.GetString("dqb_Value") %>" +     "<%=skrm.GlobalResourceSet.GetString("Field") %>"+'.');
  	                        obj.value="";
  	                        obj.focus();
  	                        return false;
  	                   }
  	               }     
  	           }
      	       
  	        }
  	    }
  	    catch(err)
  	    {}
  	    
  	    return true;   
    }
    
    function ToggleMax()
    {
        var DivTree = document.getElementById("<%=divTreeUC.ClientID%>");       
        DivTree.style.display = "block";                       
        
        DivTree.style.position="absolute";                
        DivTree.style.left = 255 + 'px';
        DivTree.style.top = 100 + 'px';       
        DivTree.style.width=250+'px';
        DivTree.style.height=150+'px';   
        
        var RadTree = document.getElementById("<%=RadTreeViewUC.ClientID%>");
        RadTree.style.height =  DivTree.style.height;       
    } 
    
    function ToggleTableMax()
    {
        var DivTree = document.getElementById("<%=div1.ClientID%>");       
        DivTree.style.display = "block";                       
        
        DivTree.style.position="absolute";                
        DivTree.style.left = 300 + 'px';
        DivTree.style.top = 260 + 'px';       
        DivTree.style.width=250+'px';
        DivTree.style.height=150+'px';   
        
        var RadTree = document.getElementById("<%=RadTreeView1.ClientID%>");
        RadTree.style.height =  DivTree.style.height;       
    }   
    
    function ShowTableField(sender, eventArgs)
    {
        var item = eventArgs.get_item();
        var selectedIndex = item.get_index();
        var showTable = document.getElementById("<%=RadComboColumnsUC.ClientID%>");
        var textId = document.getElementById("<%=tdtxtBox.ClientID%>");
        var textData = document.getElementById("<%=txtType.ClientID%>");
        var tdTable = document.getElementById("<%=tdTableField.ClientID%>");
              
        switch (selectedIndex)
        {
            case 0:
                tdTable.className = "hiddenControl";
                textId.className="";
                if(showTable.nextSibling.value != "")
                    textData.value = "'"+showTable.firstChild.value+"'";
                document.getElementById("<%=Text1.ClientID%>").value = "";
                
            
                break;
            case 1:
                tdTable.className = "";
                textId.className = "hiddenControl";
                textData.value = "";
                var tableFields = document.getElementById("<%=selTableFieldId.ClientID%>"); 
                for (i = 0; i <= tableFields.options.length+1; i++) 
                        tableFields.options[i] = null;
                break;
            case 2:
                tdTable.className = "hiddenControl";   
                 textId.className="";
                 if(showTable.nextSibling.value != "")
                    textData.value = "@"+showTable.firstChild.value;
                document.getElementById("<%=Text1.ClientID%>").value = "";
                
                break;
        }
        
        
    }
    function OpenTableStructureUC()
    {
        ToggleMax();     
    }    
     
    function CloseDivUC()
    {
          var DivTree = document.getElementById("<%=divTreeUC.ClientID%>");
          DivTree.style.display = "none";   
    }
    
    function CloseDivTable()
    {
          var DivTree = document.getElementById("<%=div1.ClientID%>");
          DivTree.style.display = "none";   
    }
    
    function NodeClickUC(node)
    {
        var RadComboTable = document.getElementById("<%=RadComboTableUC.ClientID%>");
        //Get the Parent Nodes and Append from the Parent Node 
        var NodeText = node.Text;
        var i =0;
        for(i=node.Level; i>0; i--)
        {
            if(node.Parent != null)
            {   
                node = node.Parent;
                NodeText = NodeText + "``";
                NodeText = NodeText + node.Text;
            }        
        }
        
        var TempNodeText = NodeText;
        NodeText = "";
        var mySplitResult = TempNodeText.split("``");
        
        var j = 0;
        for(j=mySplitResult.length; j>0; j--)
        {
            if(j==mySplitResult.length)
            {
                NodeText = mySplitResult[j-1];
            }
            else
            {
                NodeText = NodeText + ".";
                NodeText = NodeText + mySplitResult[j-1];
            }        
        }
        //Update the Text in to the TextBox
        RadComboTable.value = NodeText;
        CloseDivUC();        
    }
    
    function ClearQuery()
    {
      
       // window["<%=txtQuery.ClientID%>"].SetValue("");
        var txQuery = document.getElementById("<%=txtQuery.ClientID%>");
       
         var InsertButton = document.getElementById("<%=idButtonInsert.ClientID%>");
       var hdnQuery = document.getElementById("<%=hdnQuery.ClientID%>");
        txQuery.value = "";  
        hdnQuery.value = "";
        var ptxtQuery = window.parent.document.getElementById('txtQuery');
        if (ptxtQuery)
            ptxtQuery.value = "";
        var phdisplayQuery = window.parent.document.getElementById('hdnDisplayQuery');
        if(phdisplayQuery)
            phdisplayQuery.value = "";
        var phactualQuery = window.parent.document.getElementById('hdnActualQuery');
        if(phactualQuery)
           phactualQuery.value = "";

        InsertButton.disabled = false; 
        var hdnTable = document.getElementById("hdnTable");
        if(hdnTable)
            hdnTable.value = "";
    }

    function closeWindowInternal() {
        var oWindow = GetRadWindow();
        oWindow.close();
    }
    
</script>

