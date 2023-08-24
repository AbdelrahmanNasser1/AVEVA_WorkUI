<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.Login"
    EnableViewStateMac="false" EnableEventValidation="false" %>

<!DOCTYPE html >
<html>
<head id="Head1" runat="server">
    <style>
        html, body
        {
            height: 100%;
        }
    </style>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <title>
        <%WriteLangSpecText("ec_newHeader"); %><%:RepositoryName %>
    </title>
    <script type="text/javascript">
        function focusonuserid() {
            try {
                var userid = document.getElementById('Login1_UserName');
                userid.focus();
            }
            catch (e)
            { }
            //resize the window
            resizehtml();
        }

		function delayLogin(timeValue, value){
			value = value.split("@@@");
			var counter = parseInt(timeValue);
			if (counter <= 0)
			{	
				counter = 4294967295;
			}
			var logonBtnId = "<%=LogOnButton.ClientID%>";
            $("#" + logonBtnId).attr("disabled", "true");
			$("#" + logonBtnId).css('pointer-events','none');
			
			setInterval(function() 
			{
				if (counter >= 0) 
				{
					counter--;
					document.getElementById('showmessage').innerHTML = value[0] + counter + value[1];
				}
				// Display 'counter' wherever you want to display it.
				if (counter === 0) 
				{
					clearInterval(counter);
					$("#showmessage").hide();
					$("#" + logonBtnId).removeAttr("disabled");
					$("#" + logonBtnId).css('pointer-events','');;
				}
			}, 1000);
		}
		
        function resizehtml() {
            window.moveTo(0, 0);
            window.resizeTo(screen.availWidth, screen.availHeight);
        }

        function getUrlParameterValue(windowObject, parameterName)
        {
            var match = RegExp('[?&]' + parameterName + '=([^&]*)').exec(windowObject.location.search);
            return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
        }        

        //
        // NOTE: { Rupesh M. Kokal}
        // To handle the closure of any popup windows of EC, we need to put a sleep of 5 secs when redirecting to the login page. 
        //
        $(document).ready(function ()
        {
            if (getUrlParameterValue(window, "fl") == "re")
            {
                var logonBtnId = "<%=LogOnButton.ClientID%>";
                $("#" + logonBtnId).attr("disabled", "true");

                setTimeout(function () { $("#" + logonBtnId).removeAttr("disabled"); }, 5000);
            }
        });
    </script>
</head>
<body class="bodylogintext" onload="javascript:focusonuserid();">
    <form id="form1" runat="server" style="height: 100%" autocomplete="off">        
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
        <asp:Panel ID="pnlLogin" runat="server" Height="100%" Width="100%">

            <div class="loginbox" style="display: block;">
                <div style="margin: 30px auto;">&nbsp;</div>
                <div class="ecbrand">
                    <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>Repository/Site/Images/EC-LoginPg-Branding.png" style="max-width: 100%;" />
                </div>

                <div style="width: 85%; margin: 0 auto;">
                    <asp:Login ID="Login1" runat="server" LoginButtonType="Button" MembershipProvider="SkeltaMemberShipProvider"
                        OnAuthenticate="Login1_LoggedInAuthenticate" OnLoggedIn="Login1_LoggedIn" Width="100%">
                        <LayoutTemplate>
                            <div class="loginfields">
                                <asp:Label ID="LogOnLabel" runat="server" class="LoginTitleText"><%WriteLangSpecText("ec_newHeader");%></asp:Label>
                            </div>
                            <div class="loginfields">
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" CssClass="username-password-lables">
                                                        <%WriteLangSpecText("ec_userid"); %>&nbsp; 
                                </asp:Label>
                            </div>
                            <div class="loginfields">
                                <asp:TextBox ID="UserName" runat="server" CssClass="username-password-text" Width="100%"></asp:TextBox>
                            </div>
                            <div class="loginfields">
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" CssClass="username-password-lables">
                                                        <%WriteLangSpecText("ec_userpwd"); %>&nbsp; 
                                </asp:Label>
                            </div>
                            <div class="loginfields">
                                <input type="text" style="display: none;">
                                <asp:TextBox ID="Password" runat="server" CssClass="username-password-text" TextMode="Password" autocomplete="off" Width="100%">
                                </asp:TextBox>
                            </div>
							<div style="display:block; margin-top: 1px; padding-left: 8px; min-height:20px;">
                                <asp:Label ID="Label1" runat="server" CssClass="errormsg"><%=GetLangSpecText("ec_loginfail") %></asp:Label>
                                <asp:RequiredFieldValidator display="Dynamic" ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                    CssClass="errormsg" ErrorMessage="" ValidationGroup="Login1"><%WriteLangSpecText("ec_username_required"); %>
                                </asp:RequiredFieldValidator>
                            </div>
							<div style="display:block; margin-top: 1px; padding-left: 8px;">
                                <asp:RequiredFieldValidator display="Dynamic" ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                    CssClass="errormsg" ErrorMessage="" ValidationGroup="Login1"><%WriteLangSpecText("ec_password_required"); %>
                                </asp:RequiredFieldValidator>
                            </div>
							<div style="display:block; margin-top: 1px; padding-left: 8px;">
                                <span id="showmessage" class="errormsg"></span>
                            </div>
								<div class="loginbutton">
									<asp:Button ID="LogOnButton" runat="server" Text="Login" ValidationGroup="Login1" CssClass="inputbutton" CommandName="Login" />
								</div>
                        </LayoutTemplate>
                    </asp:Login>

                </div>
            </div>
                        
            <div style="float: left; width: 70%; display:block;height:100%;position:relative;">
                <div style="padding: 0;position: absolute;display: inline-block;top: 9%;left: 10%;">
                    <span class="wwbpmtextcss"><%WriteLangSpecText("productheaderWithversionTm");%></span>
                    <br />
                    <span class="wwbpmtextdetailcss"><%WriteLangSpecText("Advanced business process and workflow management");%></span>
                </div>
                <div style="height: 510px;width: 630px;padding: 0;position: absolute;display: inline-block;top: 55%;left: 50%;margin-top: -255px;margin-left: -275px;max-width: 100%;">                        
                    <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>Repository/Site/Images/EC-LoginPg-Logo.png" style="max-width: 100%;" />
                </div>
            </div>
            
        </asp:Panel>

        <asp:HiddenField ID="hdnrepo" runat="server" />
        <asp:HiddenField ID="hdninstance" runat="server" />
        <asp:HiddenField ID="hdnuser" runat="server" />
        <asp:HiddenField ID="hdnprovtext" runat="server" />
        <asp:HiddenField ID="hdnprovider" runat="server" />
    </form>

</body>
</html>
