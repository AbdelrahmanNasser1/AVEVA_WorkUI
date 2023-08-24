<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Queue.aspx.cs" Inherits="SkeltaTemplates_Default_ProcessDesigner_Queue"
    EnableEventValidation="true" Theme="" StylesheetTheme="" %>

<html style="height:100%">
<head runat="server">
    <title>
        <%=PageTitle%>
        -<%=_Actionname%>-<%=PropertyDisplayName%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <link href="<%=ProcessDesignerControl.GetCommonRelativeUrl("stylesheet/global.css")%>"
        rel="stylesheet" type="text/css" />

    <script type='text/javascript' src='<%=_JScriptPath%>'></script>

    <script language="javascript" type="text/javascript">
       
		var selectedList;
		var availableList;
		
		function createListObjects(){
			availableList = document.getElementById("LstQueue");
			selectedList = document.getElementById("LstSelQueue");
		}
		
		function delAttribute(){
			var i = 0;
			while (i < selectedList.length){
				if(selectedList.options[i].selected){
					var addIndex = i;
				if(addIndex < 0)
					return;
				availableList.appendChild( 
					selectedList.options.item(addIndex));
					i--;
				}
				i++;
			}
		    selectNone(selectedList,availableList);
		}
		
		function addAttribute(){
			var i = 0;
			while (i < availableList.length){
				if(availableList.options[i].selected){
					var addIndex = i;
				if(addIndex < 0)
					return;
				selectedList.appendChild( 
					availableList.options.item(addIndex));
					i--;
				}
				i++;
			}
		    selectNone(selectedList,availableList);
		}

		function selectNone(list1,list2){
			list1.selectedIndex = -1;
			list2.selectedIndex = -1;
			addIndex = -1;
			selIndex = -1;
		}

		function delAll(){
			var len = selectedList.length -1;
			for(i=len; i>=0; i--){
				availableList.appendChild(selectedList.item(i));
			}
			selectNone(selectedList,availableList);
		    
		}

		function addAll(){
			var len = availableList.length -1;
			for(i=len; i>=0; i--){
				selectedList.appendChild(availableList.item(i));
			}
			selectNone(selectedList,availableList);
		}
		
		function beforeSubmit()
		{
		    var rows = selectedList.options.length;
		    var setInput = document.getElementById('hidInput');
		    selectedList.selectedIndex =-1;
		    for( var i=0; i<rows; i++ ) {
		        if( setInput.value != '' )
		            setInput.value += '/';
		        setInput.value += selectedList.options[i].value;
		    
		    }		    
	        document.forms[0].submit();
		}
		
		function RefreshParentPage()
		{
		    window.setTimeout('window.opener.refreshselectedaction()',100);
        window.opener.parent._skProcessDesigner.RefreshProperties();
        window.setTimeout('window.close()',300);
        window.close();
		}
    </script>

</head>
<body onload="createListObjects();" style="overflow:hidden">
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
            <tr>
                <td style="width: 99%; height: 300px;" valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                        <tr valign="top" class="ListHeaderCss">
                            <td style="width: 621px; padding-left: 10px" valign="middle">
                              <span class="fontheading"><%=_Actionname%>
                                -<%=PropertyDisplayName%></span>  </td>
                            <td valign="middle" style="padding-right: 10px">
                                <span title="Help">
                                    <img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%>"
                                        align="right" <%=_Helpimagetags%> style="cursor: pointer" alt="Help" /></span></td>
                        </tr>
                        <tr>
                            <td style="width: 621px" colspan="2" class="error">
                              <span class="errormsg"><%=ErrMsg%></span>  
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 5px;" colspan="2">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center" style="height: 210px" class="lefttdbg">
                                <table width="97%" cellspacing="1" cellpadding="1" border="0">
                                    <tr>
                                        <td class="lefttdbg" align="center" style="height: 220px;">
                                            <table border="0">
                                                <tr>
                                                    <td class="description" style="width: 139px; height: 21px;" align="center">
                                                        <asp:Label ID="lblQueueAvlbl" runat="server" Width="114px"></asp:Label>
                                                    </td>
                                                    <td style="height: 21px">
                                                    </td>
                                                    <td class="description" style="width: 139px; height: 21px;" align="center">
                                                        <asp:Label ID="lblQueueSlctd" runat="server" Width="114px"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 180px;" valign="top">
                                                        <asp:ListBox ID="LstQueue" CssClass="inputtext" runat="server" SelectionMode="Multiple" Height="160px"
                                                            Width="180px"  /></td>
                                                    <td valign="middle" align="center" style="width: 35px; padding-left: 5px; padding-right: 5px">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <!--add all-->
                                                                    <input type="button" id="BtnAddAll" onclick="addAll();" value=">>" class="lookupnavigationbutton"
                                                                        style="width: 36px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <input type="button" id="Button1" onclick="addAttribute();" value=">" class="lookupnavigationbutton"
                                                                        style="width: 36px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <input type="button" id="Button2" onclick="delAttribute()" value="<" class="lookupnavigationbutton"
                                                                        style="width: 36px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <input type="button" id="BtnRemoveAll" value="<<" class="lookupnavigationbutton" onclick="delAll();"
                                                                        style="width: 36px" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td style="width: 180px;">
                                                        <asp:ListBox ID="LstSelQueue" CssClass="inputtext" runat="server" Height="160px" Width="180px" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>    
                            <td style="height: 5px;" colspan="2">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="right">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 100%; height: 27px; padding-right: 10px">
                                            <input name="button2" type="button" class="inputsecondarybutton" id="btnClear" style="cursor: pointer;margin-right:10px;"
                                                onclick="window.close()" value="<%=strClose%>" />
                                            <input type="button" name="btnUpdate" class="inputbutton" onclick="beforeSubmit();"
                                                style="cursor: pointer" value="<%=strAssign%>" />
                                            <input type="hidden" id="hidInput" name="hidInput" value="" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
