<%@ Control Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.Web.Designer.ResourceWizardClass" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
	
 <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
<link rel="stylesheet" type="text/css" href="<%=resWizControl.GetCommonRelativeUrl("StyleSheet/Global.css") %>" >
<link rel="stylesheet" type="text/css" href="<%=resWizControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css") %>">
<link rel="stylesheet" type="text/css" href="<%=resWizControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTWindow/Window.css") %>">
</telerik:RadScriptBlock>

<telerik:RadCodeBlock ID="RadCodeBlock16" runat="server">
<script language="javascript">


    function selectUsers(usernameclientid, hiddenusernameclienid)
    {        
        var oWindow;

        if (document.getElementById(hiddenusernameclienid) != null)
            oWindow = radopen("../../Repository/Site/UserLookup.aspx?users=" + encodeURIComponent(document.getElementById(hiddenusernameclienid).value), null);
        else
            oWindow = radopen("../../Repository/Site/UserLookup.aspx", null);

        oWindow.set_modal(true);
        oWindow.set_title('Select User');
        oWindow.setSize(600, 480);
        var windowheight = window.innerHeight; 
        var windowWidth = window.innerWidth;

        if (windowWidth < 850) { 
            oWindow.moveTo(20, 10); 
        }   

        if (windowWidth > 1000) { 
            oWindow.moveTo(windowheight / 2 - 100, 60); 
        }

        oWindow.add_beforeClose(onClientBeforeCloseUsers);

        function onClientBeforeCloseUsers(sender, args)
		{
			var returnValue = args.get_argument();
			if (returnValue !== null && returnValue !== undefined) {
				var oArea = document.getElementById(usernameclientid);
				var ids;
				var names = '';
				var useridstring = '';

				if (returnValue != ",") {
					if (returnValue.lastIndexOf("^") != -1) {
						var usernamestring = returnValue.substring(0, returnValue.lastIndexOf("^"));
						useridstring = returnValue.substring(returnValue.lastIndexOf("^") + 1);
						names = ReplaceAll(usernamestring, "@!@", ", ");
					}
				}
				else {
					alert('<%=strNoResource%>');
					args.set_cancel(true);
					return;
				}

				oArea.value = names;
				var oArea1 = document.getElementById(hiddenusernameclienid);
				oArea1.value = useridstring;
			}
            sender.remove_beforeClose(onClientBeforeCloseUsers);
        }
    }

    //
    // Replaces all the match strings with the replace string in the source string
    // and returns the result.
    //
    function ReplaceAll(Source, stringToFind, stringToReplace)
    {
        var temp = Source.split(stringToFind);

        return temp.join(stringToReplace);
    }

</script>
 </telerik:RadCodeBlock>
<div>
	<telerik:RadWindowManager ID="Singleton"  Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
         runat="server"  Behaviors="Close, Minimize, Maximize, Move"  RenderMode="Classic" VisibleStatusbar="false">          
</telerik:RadWindowManager>

    
    <asp:Wizard ID="reswizard" 
        runat="server"  
        DisplaySideBar="false"          
        OnFinishButtonClick="GetAllValues"
        OnActiveStepChanged="OnActiveStepChanged"        
        OnNextButtonClick="ExecNext" 
        DisplayCancelButton="true" 
        CancelButtonStyle-CssClass="inputsecondarybutton"
        CancelButtonText=" Close "       
        OnCancelButtonClick="ExecCancel"         
        Height="480"
        StepStyle-VerticalAlign="Top"   
        Width="650"  
        NavigationStyle-HorizontalAlign="Right"    
        ActiveStepIndex="0">      
    <WizardSteps>

    <asp:WizardStep ID="SearchStep" Title="SearchResource" runat="server">
    
    <table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0" >	
	    <tr>
		<td valign="top" height="25">
			<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
					<div height="25" style="padding-left:10px;" class="ListHeaderCSS"><span class="subtitle"> <%=strActorsSelectionWizard%></span></div>
					<div valign="top" width="25" class="ListHeaderCSS"></div>
			</telerik:RadCodeBlock>
		</td>
	   </tr>
		
         
	    <tr>
			<td class="lefttdbg" height="20">	
					<table cellspacing="1" cellpadding="0" border="0" width="100%"  align="center">
						<tr>									
							<td style="padding-left:8px;">
							    <span class="errormsg">
							        <asp:Label ID="lblDisplayError" runat="server"></asp:Label>
							    </span>
							</td>										
						</tr>
				    </table>
			</td>
	    </tr>
		
	    <tr>
	<td valign="top"  >
    <table id="TMain" width="94%" align="center" border="0" cellpadding="7" cellspacing="1"  class="">
        <tr>
            <td class="lefttdbg" valign="top" style="width: 45%">
				<telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
                <span class="subtitle">
                    <%=resourceManager.GlobalResourceSet.GetString("Wiz_select_userlookup")%>
                    </span><br /><br />
                    <span class="description">
                    <%= resourceManager.GlobalResourceSet.GetString("Wiz_Select_User_desc")%>
                 </span>
					</telerik:RadCodeBlock>
                <br />
            </td>
            <td class="righttdbg" style="width: 55%"> 
				<telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
                <asp:TextBox ID="usrName" CssClass="inputtext" runat="server" onclick="this.blur()" Width="200px"></asp:TextBox>
                <input id="Button6" class="userlookup" 
                onclick="selectUsers('<%=usrName.ClientID %>','<%=usrNameHidden.ClientID%>');"
                    type="button" title="<%=resourceManager.GlobalResourceSet.GetString("ec_userlookup_title")%>" value=".." name="SiteExplorer" />
                <asp:HiddenField ID="usrNameHidden" EnableViewState="true" runat="server" />
					</telerik:RadCodeBlock>
            </td>
        </tr>
    </table>
   </td>
   </tr>			
	</table>
	
	
	
	
	
</asp:WizardStep>        
              
                
<asp:WizardStep ID="MultipleUsersStep" Title="MultipleUsers" runat="server" StepType=Step>          

<table width="100%" cellspacing="0" cellpadding="0" border="0">	
	<telerik:RadCodeBlock ID="RadCodeBlock4" runat="server">
	<tr>
		
		<td valign="middle" height="25" background="<%=resWizControl.GetCommonRelativeUrl("images/top-bg.gif")%>">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td height="25"><span class="subtitle"> <%=strActorsSelectionWizard%></span></td>
					<td valign="top" width="25"></td>
				</tr>
			</table>		
		</td>
		
	</tr>
	</telerik:RadCodeBlock>
		
	<tr>
		<td>
				<table cellspacing="1" cellpadding="4" border="0" width="100%" class="tablebg" align="center">
					<tr>
							<td class="lefttdbg" width="60%">
<telerik:RadCodeBlock ID="RadCodeBlock5" runat="server">
							<span class="description"><%=strAcknowledgers%></span>
	</telerik:RadCodeBlock>
							</td>
							<td class="righttdbg" width="100" colspan="2">
							
							<asp:DropDownList ID="ddlMulPartAck" runat="server" AutoPostBack="true"  CssClass="inputselect" OnSelectedIndexChanged="EnableMulUsersAck">
							    <asp:ListItem Value="Select">Select</asp:ListItem> 
							   <asp:ListItem Value="Yes">Yes</asp:ListItem>
							   <asp:ListItem Value="No">No</asp:ListItem>							
							</asp:DropDownList>
							</td>
					</tr>
					
					<tr>
							<td class="lefttdbg" width="60%">
								<telerik:RadCodeBlock ID="RadCodeBlock6" runat="server">
							<span class="description"><%=strMinAcknowledgers%></span>
									</telerik:RadCodeBlock>
							</td>
							<td class="righttdbg" width="85">							
							    <asp:TextBox ID="txtAckMinUsers" runat="server" Width="40"  CssClass="inputtext" Enabled="false"  
							    Text="1" ></asp:TextBox>
							</td>
							<td class="righttdbg" width="125">
								<telerik:RadCodeBlock ID="RadCodeBlock7" runat="server">
							<span class="description"><%=strperornumber%></span>
									</telerik:RadCodeBlock>
							</td>
					</tr>
					
					<tr>
							<td class="lefttdbg" width="60%">
								<telerik:RadCodeBlock ID="RadCodeBlock8" runat="server">
							<span class="description"><%=strMaxAcknowledgers%></span>
									</telerik:RadCodeBlock>
							</td>
							<td class="righttdbg" width="85">
							    <asp:TextBox ID="txtAckMaxUsers" runat="server" Width="40" CssClass="inputtext"
							    Enabled="false"  Text="100%"></asp:TextBox>
								
							</td>
							
							<td class="righttdbg" width="125">
								<telerik:RadCodeBlock ID="RadCodeBlock9" runat="server">
							<span class="description"><%=strperornumber%></span>
									</telerik:RadCodeBlock>
							</td>
					</tr>
			
					<tr>
							<td class="lefttdbg" width="60%">
								<telerik:RadCodeBlock ID="RadCodeBlock10" runat="server">
							<span class="description"><%=strActors%></span>
									</telerik:RadCodeBlock>
							</td>
							<td class="righttdbg" width="100" colspan="2">
							  	<asp:DropDownList ID="ddlMulPartAct" runat="server" AutoPostBack="true" OnSelectedIndexChanged="EnableMulUsersAct" CssClass="inputselect">
								       <asp:ListItem Value="Select">Select</asp:ListItem> 
								       <asp:ListItem Value="Yes">Yes</asp:ListItem>
								       <asp:ListItem Value="No">No</asp:ListItem>
								</asp:DropDownList>
							</td>
					</tr>
					
					
					<tr>
							<td class="lefttdbg" width="60%">
								<telerik:RadCodeBlock ID="RadCodeBlock11" runat="server">
							<span class="description"><%=strMaxActors%></span>
									</telerik:RadCodeBlock>
							</td>
							<td class="righttdbg" width="85">
							   						    
							    <asp:TextBox ID="txtActUsers" runat="server" Width="40" CssClass="inputtext"
							    Enabled="false"  Text="100%"></asp:TextBox>
							</td>
							<td class="righttdbg" width="125">
								<telerik:RadCodeBlock ID="RadCodeBlock12" runat="server">
							<span class="description"><%=strperornumber%></span>
									</telerik:RadCodeBlock>
							</td>
					</tr>
					
					<tr>
							<td class="lefttdbg" width="60%">
								<telerik:RadCodeBlock ID="RadCodeBlock13" runat="server">
							<span class="description"><%=strMinActors%></span>
									</telerik:RadCodeBlock>
							</td>
							<td class="righttdbg" width="85">
												 
							 <asp:TextBox ID="txtActMinLimit" runat="server" Width="40" CssClass="inputtext"
							    Enabled="false"  Text="100%"></asp:TextBox> 
							</td>
							<td class="righttdbg" width="125">
								<telerik:RadCodeBlock ID="RadCodeBlock14" runat="server">
							 <span class="description"><%=strperornumber%></span>
									</telerik:RadCodeBlock>
							</td>
					</tr>
					<asp:Label ID="label3" runat=server></asp:Label>
				</table>
		</td>
	</tr>
</table>	
</asp:WizardStep>  
<asp:WizardStep ID="ConfirmSelectedExpn" runat=server StepType=Finish>
        <table width="100%"  cellspacing="0" cellpadding="0" border="0" class="tablebg" >	
            <tr>
		    <td valign="bottom" height="25" class="ListHeaderCSS">
			    <table cellspacing="0" cellpadding="0" border="0" width="100%" >
				    <tr>
					    <td height="25" style="padding-left:10px;">
							<telerik:RadCodeBlock ID="RadCodeBlock15" runat="server">
							<span class="subtitle"><%=strActorsSelectionWizard%></span>
								</telerik:RadCodeBlock>
								</td>
					    <td valign="top" width="25" class="ListHeaderCSS"></td>
				    </tr>
    				
			    </table>		
		    </td>
	    </tr>
	    
	   <tr>
		<td>
	        <table cellspacing="1" cellpadding="4" border="0" width="100%"   class="tablebg" align="center" height="100%">
    				
		    <tr>
	            <td class="lefttdbg" style="text-align:center;">	                              
                    <span class="subtitle"><asp:Label ID="label2" runat=server></asp:Label></span>
                 </td>
             </tr>
		    </table>			
		</td>
		</tr>  	
	    
        </table>      
        </asp:WizardStep>
        
          
</WizardSteps> 

   
<NavigationButtonStyle  CssClass="inputbutton"       />

</asp:Wizard>       


    <telerik:RadAjaxManager id="RadAjaxManager1" runat="server">
				<AjaxSettings>
				    <telerik:AjaxSetting AjaxControlID="resWizard">
						<UpdatedControls>
						    <telerik:AjaxUpdatedControl ControlID="resWizard" /> 						    
						    <telerik:AjaxUpdatedControl ControlID="lblDisplayError"></telerik:AjaxUpdatedControl>							
						</UpdatedControls>
					</telerik:AjaxSetting>	
										     				   							    									
					<telerik:AjaxSetting AjaxControlID="ddlMulPartAck">
						<UpdatedControls>						
							<telerik:AjaxUpdatedControl ControlID="txtAckMinUsers" ></telerik:AjaxUpdatedControl>
							<telerik:AjaxUpdatedControl ControlID="txtAckMaxUsers" ></telerik:AjaxUpdatedControl>
						</UpdatedControls>
					</telerik:AjaxSetting>
					<telerik:AjaxSetting AjaxControlID="ddlMulPartAct">
						<UpdatedControls>						
							<telerik:AjaxUpdatedControl ControlID="txtActUsers" ></telerik:AjaxUpdatedControl>
							<telerik:AjaxUpdatedControl ControlID="txtActMinLimit" ></telerik:AjaxUpdatedControl>
						</UpdatedControls>
					</telerik:AjaxSetting>
				</AjaxSettings>
	    </telerik:RadAjaxManager>
     
</div>

 
       
      

 