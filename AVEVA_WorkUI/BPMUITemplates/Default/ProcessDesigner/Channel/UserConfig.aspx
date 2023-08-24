<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Channel.UserConfig"
    Theme="" StylesheetTheme="" EnableEventValidation="false" %>

<!DOCTYPE HTML>
<html>
<head runat="server">
    <title>Untitled Page</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
	<script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script language="javascript" type="text/javascript">
	
		 se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
		
        function DisplayMessage() {
            var header = '<%=Channel_Label_Users %>';
            var message = '<%=resManager.GlobalResourceSet.GetString("SilentInstallation_InvalidInputs") %>';
            se.ui.messageDialog.showError(header, message);
        }
		
		function x(){alert('here');}	
		
		function ClearListBox(ListBoxId){
			while(document.getElementById(ListBoxId).options.length > 0){
				document.getElementById(ListBoxId).remove(0);
			}
			if(ListBoxId == 'ListBoxRoles'){
				document.getElementById('HiddenRoles').value ='';
			}
			else if(ListBoxId == 'ListBoxUsers'){
				document.getElementById('HiddenUsers').value ='';
			}
		}
		
		function AddListItem(ListBoxId, text, value)
		{
		
		  var chk=false;
		    for(var i=0;i<document.getElementById(ListBoxId).options.length;i++)
		    {
		      if(document.getElementById(ListBoxId).options[i].value==value)
		        chk=true;
		      
		    }
		    if(chk==false)
		    {
			    var no = new Option();
			    no.value = value;
			    no.text  = text;
			    document.getElementById(ListBoxId).options[document.getElementById(ListBoxId).options.length]= no;
    			
			    if(ListBoxId == 'ListBoxRoles'){
				    if(document.getElementById('HiddenRoles').value != '')
					    document.getElementById('HiddenRoles').value += ',';
				     document.getElementById('HiddenRoles').value += value;
			    }
			    else if(ListBoxId == 'ListBoxUsers'){
				    if(document.getElementById('HiddenUsers').value != '')
					    document.getElementById('HiddenUsers').value += ',';
				     document.getElementById('HiddenUsers').value += value;
			    }
			}
		}
	
    </script>
</head>
<link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
<link href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
<body>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <table width="100%" border="0"  cellpadding="0" cellspacing="1" height="100%">
            <tr valign="top" height="5%">
                <td colspan="2" class="ListHeaderCss" style="vertical-align: middle">
                <table width="100%"><tr><td style="padding-left:5px;"><span class="subtitle"><%= Channel_PageHeader_FormInstanceSecurity %></span></td></tr></table>
                </td>
            </tr>
            <tr valign="top" height="83%">
                <td valign="top">
                    <table width="100%" height="100%" border="0" cellpadding="2" cellspacing="0">
                        <tr valign="top" height="10%">
                            <td><span class="description" style="padding-left:5px">
                                <%= Channel_Label_Users %></span>
                            </td>
                        </tr>
                        <tr height="90%">
                            <td style="padding-left:5px">
                                <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="tablebg">
                                    <tr valign="top" height="15%">
                                        <td class="lefttdbg">
                                            <asp:DropDownList ID="DropDownUsers" CssClass="inputselect" runat="server" />
                                        </td>
                                    </tr>
                                    <tr valign="top" height="85%">
                                        <td class="lefttdbg">
                                            <div id="divlistUsers" style="height: 250px; overflow: auto;">
                                                <asp:ListBox ID="ListBoxUsers" runat="server" />
                                           </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table width="100%" height="100%" border="0" cellpadding="2" cellspacing="0">
                        <tr class="gridbg" valign="top" height="10%">
                            <td><span class="description" style="padding-left:5px">
                                <%= Channel_Label_Roles %></span>
                            </td>
                        </tr>
                        <tr valign="top" height="90%">
                            <td style="padding-left:5px">
                                <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr valign="top" height="15%">
                                        <td>
                                            <asp:DropDownList ID="DropDownRoles" CssClass="inputselect" runat="server" />
                                        </td>
                                    </tr>
                                    <tr valign="top" height="85%">
                                        <td>
                                            <div id="divListBoxRoles" style="height: 250px; overflow: auto;">
                                                <asp:ListBox ID="ListBoxRoles" runat="server"/>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr height="12%">
                <td align="right" colspan="2" valign="top" style="padding-right:10px">                 
                    <asp:Button ID="ButtonSave" runat="server" CssClass="inputbutton" OnClick="ButtonSave_Click" />
                </td>
                <input type="hidden" id="HiddenUsers" runat="server" />
                <input type="hidden" id="HiddenRoles" runat="server" />
            </tr>
        </table>
    </form>
</body>
</html>


<script language="javascript">
	SetLHSHeight();

        SetRHSHeight();

        function SetLHSHeight()
        {
        
         
            var longTextCount=false;
            var shortTextcount=false; 
            var lstUserNames = document.getElementById('<%=ListBoxUsers.ClientID%>');
           lstUserNames.style.width="";
            lstUserNames.style.height="";
              if(lstUserNames != null)
                {
                if(lstUserNames.options.length >= 6)
                {
                    for(var i=0;i < lstUserNames.options.length;i++) 
                         { 
                         
                           if(lstUserNames.options[i].text.length < 29)
                            {
                                shortTextcount=true;
                               
                            }
                            
                            else
                            {
                                    longTextCount=true;
                                
                            }
                        }
                        
                         if(shortTextcount==true && longTextCount==false)
                        {
                        
                            document.getElementById('<%=ListBoxUsers.ClientID%>').style.width="250px";
                                var itemCount = eval(lstUserNames.options.length * 17);
                                if(itemCount<=250)
                                {
                                document.getElementById('<%=ListBoxUsers.ClientID%>').style.height="250px";
                                }
                             document.getElementById('<%=ListBoxUsers.ClientID%>').style.height=itemCount + "px";
                        
                        }
                        
                        else 
                        {
                        
                              var itemCount = eval(lstUserNames.options.length * 17);
                              if(itemCount<=250)
                              {
                               document.getElementById('<%=ListBoxUsers.ClientID%>').style.height="250px";
                              }
                              else
                                document.getElementById('<%=ListBoxUsers.ClientID%>').style.height=itemCount + "px";
                        }
                }
                else
                {
                 
                    document.getElementById('<%=ListBoxUsers.ClientID%>').style.height="250px";
                    if(lstUserNames.options.length == 0)
                        document.getElementById('<%=ListBoxUsers.ClientID%>').style.width="250px";
                     else  if(lstUserNames.options.length > 1)
                      {
                            for(var i=0;i < lstUserNames.options.length;i++) 
                        { 
                         
                           if(lstUserNames.options[i].text.length < 29)
                            {
                                shortTextcount=true;
                               
                            }
                            
                            else
                            {
                                    longTextCount=true;
                                
                            }
                        }
                        
                          if(shortTextcount==true && longTextCount==false)
                        {
                        
                            document.getElementById('<%=ListBoxUsers.ClientID%>').style.width="250px";
                                var itemCount = eval(lstUserNames.options.length * 17);
                                if(itemCount<=250)
                                {
                                document.getElementById('<%=ListBoxUsers.ClientID%>').style.height="250px";
                                }
                                else                                
                             document.getElementById('<%=ListBoxUsers.ClientID%>').style.height=itemCount + "px";
                        
                        }
                        else 
                        {
                        
                              var itemCount = eval(lstUserNames.options.length * 17);
                              if(itemCount<=250)
                              {
                               document.getElementById('<%=ListBoxUsers.ClientID%>').style.height="250px";
                              }
                              else
                              {
                                document.getElementById('<%=ListBoxUsers.ClientID%>').style.height=itemCount + "px";
                              }
                        }
                      
                      }
                      
                       else if(lstUserNames.options.length =1)
                      {
                      
                        if(lstUserNames.options[0].text.length<29)
                        {
                            
                        document.getElementById('<%=ListBoxUsers.ClientID%>').style.width="250px";
                        
                        }
                      
                      }
                }
            }
            

         }
          function SetRHSHeight()
         {
            
             var longTextCount=false;
            var shortTextcount=false; 
            var lstSelectedUserNames=document.getElementById('<%=ListBoxRoles.ClientID%>');
                        
            if(lstSelectedUserNames != null)
            {
             lstSelectedUserNames.style.width="";
            lstSelectedUserNames.style.height="";
                if(lstSelectedUserNames.options.length >= 6)
                {
                    
                   for(var i=0;i < lstSelectedUserNames.options.length;i++) 
                         { 
                         
                           if(lstSelectedUserNames.options[i].text.length < 29)
                            {
                                shortTextcount=true;
                               
                            }
                            
                            else
                            {
                                    longTextCount=true;
                                
                            }
                        }
                        
                         if(shortTextcount==true && longTextCount==false)
                        {
                        
                            document.getElementById('<%=ListBoxRoles.ClientID%>').style.width="250px";
                                var itemCount = eval(lstSelectedUserNames.options.length * 17);
                                if(itemCount<=250)
                                {
                                document.getElementById('<%=ListBoxRoles.ClientID%>').style.height="250px";
                                }
                                else
                             document.getElementById('<%=ListBoxRoles.ClientID%>').style.height=itemCount + "px";
                        
                        }
                        
                        else 
                        {
                        
                              var itemCount = eval(lstSelectedUserNames.options.length * 17);
                              if(itemCount<=250)
                              {
                              document.getElementById('<%=ListBoxRoles.ClientID%>').style.height="250px";
                              }
                              else
                                document.getElementById('<%=ListBoxRoles.ClientID%>').style.height=itemCount + "px";
                        }
                }
                else
                {
                    document.getElementById('<%=ListBoxRoles.ClientID%>').style.height="250px";  
                     if(lstSelectedUserNames.options.length == 0)          
                        document.getElementById('<%=ListBoxRoles.ClientID%>').style.width="250px";
                        
                     else  if(lstSelectedUserNames.options.length > 1)
                      {
                             for(var i=0;i < lstSelectedUserNames.options.length;i++) 
                        { 
                         
                           if(lstSelectedUserNames.options[i].text.length < 29)
                            {
                                shortTextcount=true;
                               
                            }
                            
                            else
                            {
                                    longTextCount=true;
                                
                            }
                        }
                        
                          if(shortTextcount==true && longTextCount==false)
                        {
                        
                            document.getElementById('<%=ListBoxRoles.ClientID%>').style.width="250px";
                                var itemCount = eval(lstSelectedUserNames.options.length * 17);
                                if(itemCount<=250)
                                {
                                document.getElementById('<%=ListBoxRoles.ClientID%>').style.height="250px";
                                }
                                else
                             document.getElementById('<%=ListBoxRoles.ClientID%>').style.height=itemCount + "px";
                        
                        }
                        else 
                        {
                        
                              var itemCount = eval(lstSelectedUserNames.options.length * 17);
                              if(itemCount<=250)
                              {
                              document.getElementById('<%=ListBoxRoles.ClientID%>').style.height="250px";
                              }
                              else
                                document.getElementById('<%=ListBoxRoles.ClientID%>').style.height=itemCount + "px";
                        }
                      
                      }
                      
                      else if(lstSelectedUserNames.options.length =1)
                      {
                      
                        if(lstSelectedUserNames.options[0].text.length<29)
                        {
                            
                        document.getElementById('<%=ListBoxRoles.ClientID%>').style.width="250px";
                        
                        }
                      
                      }
                      
                }
            }
            }
         
</script>

