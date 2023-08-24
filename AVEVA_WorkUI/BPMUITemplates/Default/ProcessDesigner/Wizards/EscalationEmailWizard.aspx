<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.Web.Designer.EscalationEmailWizard" Theme="" StylesheetTheme="" %>

<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer"
    TagPrefix="cc1" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
<script language="javascript" type="text/javascript">

    function RefreshParent(emailActionName, emailActionLinkName)
    {
        window.opener.setTimeout('refreshaction();' + "LoadNewDiagramElements(new Array('" + emailActionName + "'),new Array('" + emailActionLinkName + "'));", 100);
        window.setTimeout('window.close()', 100);
    }

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

        var winLeft = (600 - 530) / 2;
        var winTop = (480 - 460) / 2;
		oWindow.moveTo(winLeft, winTop); 
        oWindow.add_beforeClose(onClientBeforeCloseUsers);
        
        function onClientBeforeCloseUsers(sender, args) {
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
<html>
<head runat="server">
    <title>Escalation Email Wizard</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
	<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>	
	
</head>
	 




<body class="body-blue" style="overflow:hidden;">
	<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
	<link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(pdCtrl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css")) %>">
	<link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(pdCtrl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css")) %>">
	<link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(pdCtrl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTWindow/Window.css")) %>">
	<link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(pdCtrl.GetCommonRelativeUrl("StyleSheet/Global.css"))%>" >
		</telerik:RadScriptBlock>
    <form id="form1" runat="server" style="overflow:hidden;">
		<telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
		<telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
			</telerik:RadCodeBlock>
    <div>
     
          <asp:Wizard ID="emailwizard" 
            runat=server 
            DisplaySideBar="false"          
            OnFinishButtonClick="GetAllValues"
            OnActiveStepChanged="OnActiveStepChanged"        
            OnNextButtonClick="ExecNext" 
            DisplayCancelButton=true
            CancelButtonText=" Close " 
            OnCancelButtonClick="ExecCancel"  
        CancelButtonStyle-CssClass="inputsecondarybutton"
            Height="480"
            StepStyle-VerticalAlign=Top  
            Width="650"  
            NavigationStyle-HorizontalAlign="Right"        
            ActiveStepIndex="0"> 
         <WizardSteps>
            <asp:WizardStep ID="TimeoutStep" Title="Escalation Settings" runat=server>          
    
                <table width="100%" cellspacing="0" cellpadding="0" border="0" class="tablebg">	
	                <tr>
		                <td valign="top" height="25" >
			                <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
					                <div  height="25" class="ListHeaderCSS" style="padding-left:10px;"><span class="subtitle"> <%=strEscalationEmailWizard%></span></div>
					                <div valign="top" width="25" class="header"><!--<a href="#"><img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(pdCtrl.GetCommonRelativeUrl("images/help.gif"))%>" border="0"></a>--></div>
								</telerik:RadCodeBlock>
		                </td>
	                </tr>	                
	                 <tr>
			            <td valign="bottom" height="25"  class="lefttdbg">
			            <span class="errormsg"><asp:Label ID="lblDisplayError" runat="server"></asp:Label></span> 		            
			            </td>
		            </tr>
                	
	                                      
		                          		
	                <tr>
		                <td>
				           <table cellspacing="1" cellpadding="9" border="0" width="100%" class="6489d4ColorCode" align="center">
					            <tr>
					                <td  class="lefttdbg" width="60%">
										<telerik:RadCodeBlock ID="RadCodeBlock4" runat="server">
					                    <span class="description"> <%=strEscalateTime%>	</span>		
											</telerik:RadCodeBlock>
					                </td>
					                <td  class="righttdbg" width="180" >
					                     <telerik:RadMaskedTextBox  id="txtTimeoutAction" Skin="AWTInput" runat="server" Width="150"  EnableEmbeddedSkins="false" RenderMode="Classic"
    					                    CssClass="TextboxStyle"   
    					                    PromptChar="_" 	    					                    
                                            Mask="###.##:##:##" Text="000000000" >
                                            </telerik:RadMaskedTextBox> 
                                            <telerik:RadCodeBlock ID="RadCodeBlock5" runat="server">                                      
                                           <span class="description"><%=strEscalationDateFormat%> </span>	
												</telerik:RadCodeBlock>
					                </td>
					             </tr>               					
                			     <tr>
							         <td  class="lefttdbg" width="60%">
										 <telerik:RadCodeBlock ID="RadCodeBlock6" runat="server">
							          <span class="description"><%=strRepeatedEscalation%></span>
											 </telerik:RadCodeBlock>
							                </td>
							                <td class="righttdbg" width="100" colspan="2">
							                   <asp:DropDownList  ID="ddlRecurring" runat="server" AutoPostBack="true"  CssClass="inputselect" OnSelectedIndexChanged="EnableRecurring">
								                 <asp:ListItem Value="Select">Select</asp:ListItem> 
								                   <asp:ListItem Value="Yes">Yes</asp:ListItem>
								                   <asp:ListItem Value="No" selected>No</asp:ListItem>
								                </asp:DropDownList> 
							                </td>
					                </tr>
					                
					                <tr>
							             <td  class="lefttdbg" width="60%">
											 <telerik:RadCodeBlock ID="RadCodeBlock7" runat="server">
							                   <span class="description"> <%=strRecurringEscalationTime%></span>
												 </telerik:RadCodeBlock>
							              </td>
							               <td class="righttdbg" width="200" >
							                   <telerik:RadMaskedTextBox  id="txtTimeoutRecurring" Skin="AWTInput" runat="server" Width="150" 
                                                    EnableEmbeddedSkins="false" RenderMode="Classic"
                                                    CssClass="TextboxStyle"   
                                                    PromptChar="_" 	
                                                    Enabled="false"  				                    				                    
                                                    Mask="###.##:##:##">
                                               </telerik:RadMaskedTextBox> 	
											   <telerik:RadCodeBlock ID="RadCodeBlock8" runat="server">
                                            <span class="description"><%=strEscalationDateFormat%></span>
												   </telerik:RadCodeBlock>
							                </td>
					                </tr>
					                
					                 <tr>
							                <td class="lefttdbg" width="60%">
												<telerik:RadCodeBlock ID="RadCodeBlock9" runat="server">
							                    <span class="description"><%=strEscalationOutput%></span>
													</telerik:RadCodeBlock>
							                </td>
							                <td class="righttdbg" width="100" colspan="2">							                  
							                     <asp:TextBox id="txtTimeoutOutput" CssClass="inputtext" runat="server" Width="150"></asp:TextBox>							                							                
							                </td>
					                </tr>                					
			                </table>
			                
		                </td>
	                </tr>
                </table>	
        </asp:WizardStep>
        
        <asp:WizardStep ID="ResourceSetup" Title="Escalation Email Resource Settings" runat="server" StepType="Step">
               
	     <table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0" >		            
	    
	        <tr>
	                <td valign="middle" height="25" >
		                <table cellspacing="0" cellpadding="0" border="0" width="100%">
			                <tr>
								
				                <td  height="25" style="padding-left:10px;" >
									<telerik:RadCodeBlock ID="RadCodeBlock10" runat="server">
									<span class="subtitle"> <%=strEscalationEmailWizard%></span>
										</telerik:RadCodeBlock>

				                </td>
				               
			                </tr>
		                </table>		
	                </td>
	        </tr>	 
	        <tr>
                <td valign="bottom" height="25"  class="lefttdbg">
                 <span class="errormsg"><asp:Label ID="lblResourceNotSelected" runat="server"></asp:Label></span> 		            
			    </td>
		    </tr>
		
	    <tr>
	        <td valign="top"  >
            <table id="TMain" width="94%" align="center" border="0" cellpadding="7" cellspacing="1"  class="tablebg">
            <tr>
            <td class="lefttdbg" valign="top" style="width: 45%">
				<telerik:RadCodeBlock ID="RadCodeBlock11" runat="server">
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
				<telerik:RadCodeBlock ID="RadCodeBlock12" runat="server">
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
        
           
           <asp:WizardStep ID="EmailSetup" Title="Escalation Email Settings" runat=server StepType=Finish>          
              
                <table width="100%" cellspacing="0" cellpadding="0" border="0">	
	                <tr>
		                <td valign="middle" height="25">
			                <table cellspacing="0" cellpadding="0" border="0" width="100%">
				                <tr>
					                <td  height="25">
										<telerik:RadCodeBlock ID="RadCodeBlock13" runat="server">
										<span class="subtitle" style="padding-left:10px;"> <%=strEscalationEmailWizard%></span>
											</telerik:RadCodeBlock>
											</td>
					                
				                </tr>
			                </table>		
		                </td>
	                </tr>
                	
	                <tr>
		                <td valign="bottom" height="10"></td>
	                </tr> 
	                             		
	                <tr>
		                <td>
				           <table cellspacing="1" cellpadding="6" border="0" width="100%" class="tablebg" align="center">
				                
				                  <tr>
							                <td class="lefttdbg" width="200" valign=top >
												<telerik:RadCodeBlock ID="RadCodeBlock14" runat="server">
							                <span class="description"> <%=strFromEmailId%></span>
													</telerik:RadCodeBlock>
							                </td>
							                <td class="righttdbg" width="100" colspan="2">							                    
					                            <asp:TextBox id="txtFromEmailId" runat="server" CssClass="inputtext" Width="200"></asp:TextBox>						                							                   
							                </td>
					                </tr>
				                
                			     <tr>
							                <td class="lefttdbg" width="200" valign=top >
												<telerik:RadCodeBlock ID="RadCodeBlock15" runat="server">
							                 <span class="description"><%=strEmailSubject%></span>
													</telerik:RadCodeBlock>
							                </td>
							                <td class="righttdbg" width="100" colspan="2">							       
					                            <asp:TextBox id="txtTimeoutEmailSubject" TextMode="MultiLine"  runat="server" CssClass="inputtextarea"	 Width="300"></asp:TextBox>							                							                   
							                </td>
					                </tr>
					                
					                <tr>
							             <td class="lefttdbg" width="200" valign=top>
											 <telerik:RadCodeBlock ID="RadCodeBlock16" runat="server">
							                <span class="description"><%=strEmailContent%></span>
												 </telerik:RadCodeBlock>
							              </td>
							               <td class="righttdbg" width="300">							                   	
							                    <asp:TextBox id="txtTimeoutEmailContent" Height="100"  TextMode="multiLine"   runat="server" CssClass="inputtextarea" Width="300"></asp:TextBox>						                
							               </td>
					                </tr>					                
					                                					
			                </table>
			                
		                </td>
	                </tr>
                </table>	
        </asp:WizardStep>  
        
        <asp:WizardStep ID="CompleteStep" Title="Complete Step" runat=server StepType=Complete>
        <table width="540" cellspacing="0" cellpadding="0" border="0" class="tablebg" height="100%" >	
            <tr>
		        <td valign="bottom" height="25">
			        <table cellspacing="0" cellpadding="0" border="0" width="545">
				        <tr>
					        <td valign="bottom" height="25">
								<telerik:RadCodeBlock ID="RadCodeBlock17" runat="server">
								<span class="subtitle"><%=strEscalationEmailWizard%></span>
									</telerik:RadCodeBlock></td>
					        
				        </tr>
        				
			        </table>		
		        </td>
	    </tr>
	    
	   <tr>
		<td>
	    <table cellspacing="1" cellpadding="4" border="0" width="500" height="50"  class="tablebg" align="center">
				
		<tr>
	        <td class="lefttdbg">	                              
             <asp:Label ID="label1" runat=server></asp:Label>
             </td>
         </tr>
		</table>			
		</td>
		</tr>
		 <tr><td>&nbsp;</td></tr>
	            <tr><td>&nbsp;</td></tr>
	            <tr><td>&nbsp;</td></tr>
	            <tr><td>&nbsp;</td></tr>
	            <tr><td>&nbsp;</td></tr>
	            <tr><td>&nbsp;</td></tr>
	            <tr><td>&nbsp;</td></tr>
	            <tr><td>&nbsp;</td></tr>
	            <tr><td>&nbsp;</td></tr>
	               
		        
		        <tr>
		            <td width="520" align="right">
		                <input type=button id="btnClose" class="inputbutton" value=" Close "  onclick="RefreshParent()" />  
		            </td>		        
		        </tr>  
		
	    
        </table>      
        </asp:WizardStep>      
            
    </WizardSteps>
    <NavigationButtonStyle CssClass="inputbutton" />
	    <HeaderStyle backcolor="whitesmoke" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px"
	    Font-Bold="True" Font-Size="0.8em"  ForeColor="Black" HorizontalAlign="Center" />                         
</asp:Wizard> 
    
        
         <telerik:RadAjaxManager id="RadAjaxManager1"  runat="server">
			  <AjaxSettings>                				
        			<telerik:AjaxSetting AjaxControlID="emailwizard">
						<UpdatedControls>
						    <telerik:AjaxUpdatedControl ControlID="emailwizard" /> 						    
						    <telerik:AjaxUpdatedControl ControlID="lblDisplayError"></telerik:AjaxUpdatedControl>							
						</UpdatedControls>
					</telerik:AjaxSetting>	        				 
	                <telerik:AjaxSetting AjaxControlID="ddlRecurring">
		                <UpdatedControls>						                    
		                    <telerik:AjaxUpdatedControl ControlID="ddlRecurring"></telerik:AjaxUpdatedControl>
		                    <telerik:AjaxUpdatedControl ControlID="txtTimeoutRecurring" UpdatePanelRenderMode="Inline"></telerik:AjaxUpdatedControl>					                
		                </UpdatedControls>
	                </telerik:AjaxSetting>
			                
			  </AjaxSettings> 
		</telerik:RadAjaxManager>
		
<telerik:RadWindowManager ID="Singleton"  Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
         runat="server"  Behaviors="Close, Minimize, Maximize, Move"  RenderMode="Classic" VisibleStatusbar="false">          
</telerik:RadWindowManager>
    
    </div>
    </form>

</body>
</html>
