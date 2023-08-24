<%@ Page Language="C#" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" Title="" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/WebLogger.master" Inherits="Skelta.Repository.Web.CodeBehind.LiveLogger" Debug="true"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="mainContent" runat="server" SelectMethod="ShowEvent">
<style>
        .switch {
            position: relative;
            display: inline-block;
            width: 40px;
            height: 15px;
			float: right !important;
			margin-right: 3% !important;
			margin-top: 3% !important;
        }

            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            -webkit-transition: .4s;
            transition: .4s;
        }

            .slider:before {
                position: absolute;
                content: "";
                height: 18px;
                width: 18px;
                left: 0px;
                bottom: -1.05px;
                background-color: #1978CE;
                -webkit-transition: .4s;
                transition: .4s;
            }

        input:checked + .slider {
            background-color: #91C0E5;
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #2196F3;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(26px);
            -ms-transform: translateX(26px);
            transform: translateX(26px);
        }

        /* Rounded sliders */
        .slider.round {
            border-radius: 34px;
        }

            .slider.round:before {
                border-radius: 50%;
                margin-top: 20px;
            }
			
			.advancedOptionToogleTextLiveLogger
			{
				float: right !important;
				margin-top: 2.9% !important;
				margin-right: 20px !important;
				color: rgba(0, 0, 0, 0.54) !important;
				font-family: "Roboto", "Segoe UI", "Arial", "Verdana";
				font-size: 14px !important;
			}
			
			.exportButton{
				border: none;
				float: right;
				height: 20px !important;
				width: 20px !important;
				margin-top: 2.8% !important;
				margin-right: 25px !important;
			}
			
			.filterButton{
				border:none;
				float:right;
				height: 20px !important;
				width:20px !important;
				margin-top: 2.8% !important;
				margin-right: 25px !important;
			}
			
			.clearButton{
				border:none;
				float:right;
				height: 20px !important;
				width:20px !important;
				margin-top: 2.8% !important;
				margin-right: 25px !important;
			}
    
            .PauseButton{
				border:none;
				float:right;
				height: 20px !important;
				width:20px !important;
				margin-top: 2.8% !important;
				margin-right: 25px !important;
			}
			
            .PlayButton{
				border:none;
				float:right;
				height: 20px !important;
				width:20px !important;
				margin-top: 2.8% !important;
				margin-right: 25px !important;
			}
    
            .Progress{
                margin-left: 50% !important;
                height: 24px;
                width : 24px;
            }
    
			.mainContentDiv{
				 height: 75vh;
				 max-height: 80vh;
			 }
			 
			 .maxMessageModule{
				max-width: 400px !important;
				word-wrap: break-word !important;
			}
			
			.maxGridMessageModule{
				max-width: fit-content !important;
				word-wrap: break-word !important;
			}
			
			.headerClass > th 
			{
				text-align:left;
				max-width: 50px !important;
				word-wrap: break-word;
			}
			
			.maxTimeColumn{
				width: 100px !important;
				word-wrap: break-word !important;
			}
			
			.maxProcessColumn{
				width: 100px !important;
				word-wrap: break-word !important;
			}
			
			.logTypeColumn{
				width: 50px !important;
			}
			
			.LoggerGrid > div
			{
			height:60vh;
			background-color:white;
			}
			
    </style>
    <div style="max-height: 70vh;">
		<div style="width: 90% !important; margin-left: 5% !important;">
			<div id="clickArea" runat="server" class="AdvancedOption">   
                <%if(!isCloudPlatform) { %>
                    <label class="switch" runat="server" style="cursor:pointer">
                         <input type="checkbox" />
                         <span class="slider round"></span>
                    </label>
                    <div class="advancedOptionToogleTextLiveLogger">Advanced Option</div>
                <%} %>
				<asp:ImageButton ID="clearButton" TabIndex="6" class="clearButton" src="<%$ReplaceTemplateExpn:WorkItemList/Images/table-large-remove.svg%>" runat="server" OnClick="Clear_Log" Tooltip="Clear"/>
				<asp:ImageButton ID="ImageButton1" class="exportButton" TabIndex="5" src="<%$ReplaceTemplateExpn:WorkItemList/Images/application-export.svg%>" runat="server" OnClick="Excel_Export" Tooltip="Export"/>
                <asp:ImageButton ID="resumeButton" class="PlayButton" TabIndex="4" src="<%$ReplaceTemplateExpn:WorkItemList/Images/play-circle-outline.svg%>" runat="server" OnClick="Pause_Play" Visible="false" Tooltip="Play"/>
                <asp:ImageButton ID="pauseButton" class="PauseButton" TabIndex="4" src="<%$ReplaceTemplateExpn:WorkItemList/Images/pause-circle-outline.svg%>" runat="server" Tooltip="Pause" OnClick="Pause_Play" />
				<asp:ImageButton ID="filerButton" TabIndex="3" class="filterButton" src="<%$ReplaceTemplateExpn:WorkItemList/Images/filter-variant.svg%>" runat="server" OnClick="Filter_Search" Tooltip="Filter"/>
				<asp:TextBox ID="filter" type="search" runat="server" class="filter" placeholder="Message Filter" TabIndex="2" autocomplete="off" Style="border: 0; border-bottom: solid 0.20px #000; outline: none; width: 110px; background-repeat: no-repeat; float:right; padding:5px; margin-top: 2.6%; color: rgba(0, 0, 0, 0.54);"></asp:TextBox>
				<asp:DropDownList ID="filterByTypeDropDown" class="dropDown" TabIndex="1" runat="server" placeholder="Filter By Type" Style="border: 0; border-bottom: solid 0.20px #000; outline: none; width: 110px; height: 26px; float: right; margin-right: 20px!important; margin-top: 2.6% !important; background-color: transparent; color: rgba(0, 0, 0, 0.54); font-size: 14px !important; color: rgba(0, 0, 0, 0.54);">
					<asp:ListItem Value="0">All</asp:ListItem>
					<asp:ListItem Value="1">Information</asp:ListItem>
					<asp:ListItem Value="2">Warning</asp:ListItem>
					<asp:ListItem Value="3">Error</asp:ListItem>
				</asp:DropDownList>
			</div>
            <div style='background-color:#ffffff;height:24px;'>
                <asp:Image ID="progressBar" class="Progress" src="<%$ReplaceTemplateExpn:WorkItemList/Images/Preloader_Animation.gif%>" runat="server" Visible="false"/>
            </div>
		</div>		
        <asp:UpdatePanel ID="updatePanel" runat="server">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="timer" EventName="Tick" />
            </Triggers>
            <ContentTemplate>				
                <asp:Literal ID="literalMessages" runat="server" />
                <asp:Timer runat="server" ID="timer" Interval="2000" OnTick="OnTimerIntervalElapsed" />
                <asp:HiddenField ID="hiddenScrollPosition" runat="server" />
				<asp:HiddenField ID="hiddenSwitchValue" runat="server" />  
                
				<div style="max-height: 60vh; overflow-y: auto; overflow-x: hidden;width: 90% !important; margin-left: 5% !important" ID="grid" runat="server" class="gridDiv">
				<asp:GridView ID="gridLogInfoList" runat="server" Width="100%" OnRowDataBound="GridLogInfoList_RowDataBound" CssClass="LoggerGrid" AutoGenerateColumns="false" border="0" GridLines="Horizontal" CellPadding="5" ShowHeaderWhenEmpty="true" EmptyDataText="No logs Found">
					<HeaderStyle Height="40px" HorizontalAlign="Left" CssClass="headerClass"/>
                    <Columns>
                        <asp:TemplateField HeaderText="Time" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="maxTimeColumn">
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </asp:TemplateField>
						<asp:ImageField HeaderText="Type" DataImageUrlField="LogType" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="logTypeColumn" ControlStyle-Height="24" ControlStyle-Width="24" />
						<asp:TemplateField HeaderText="MessageType" ItemStyle-HorizontalAlign="Left" Visible="false">
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Message" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="maxGridMessageModule">
                            <ItemStyle HorizontalAlign="Left" Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                    </Columns>
					<rowstyle Height="25px" />
					<AlternatingRowStyle BackColor="#e0e0e0" />
					<EmptyDataRowStyle HorizontalAlign="center"/>
                </asp:GridView>
				</div>

				<div style="max-height: 60vh; overflow-y: auto; overflow-x: hidden;width: 90% !important; margin-left: 5% !important" ID="gridDiv" runat="server" class="gridAdvancedDiv">
                <asp:GridView ID="gridLogInfoListAdvanced" runat="server" Width="100%" OnRowDataBound="GridLogInfoListAdvanced_RowDataBound" CssClass="LoggerGridAdvanced" AutoGenerateColumns="false" border="0" GridLines="Horizontal" CellPadding="5" ShowHeaderWhenEmpty="true" EmptyDataText="No logs Found">
					<HeaderStyle Height="40px" HorizontalAlign="Left" CssClass="headerClass"/>
                    <Columns>
                        <asp:TemplateField HeaderText="Time" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="maxTimeColumn">
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </asp:TemplateField>
						<asp:ImageField HeaderText="Type" DataImageUrlField="LogType" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="logTypeColumn" ControlStyle-Height="24" ControlStyle-Width="24" />
						<asp:TemplateField HeaderText="MessageType" ItemStyle-HorizontalAlign="Left" Visible="false">
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Message" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="maxMessageModule">
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Module" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="maxWidthModule">
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Assembly Version" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="maxWidthColumn">
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Process" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="maxProcessColumn">
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </asp:TemplateField>
                    </Columns>
					<rowstyle Height="25px" />
					<AlternatingRowStyle BackColor="#e0e0e0" />
					<EmptyDataRowStyle HorizontalAlign="center"/>
                </asp:GridView>
				</div>
                <script>
					var prm = Sys.WebForms.PageRequestManager.getInstance();
					prm.add_beginRequest(beginRequest);
					prm.add_endRequest(EndRequestHandler);
					function beginRequest() {
						if (document.getElementById('<%= hiddenSwitchValue.ClientID %>').value === "ON")
						{
							yPos = $('.gridAdvancedDiv').scrollTop();
						}
						else
						{
							yPos = $('.gridDiv').scrollTop();
						}
					}
					
					function EndRequestHandler() {
						if (document.getElementById('<%= hiddenSwitchValue.ClientID %>').value === "ON")
						{
							$('.gridAdvancedDiv').scrollTop(yPos);
							$(".LoggerGrid").hide();
							$(".LoggerGridAdvanced").show();
							$(".gridAdvancedDiv > div").css({"height":"60vh", "background-color":"white"});
							$(".gridDiv > div").css("height","0");
						}
						else
						{
							$('.gridDiv').scrollTop(yPos);
							$(".LoggerGrid").show();
							$(".LoggerGridAdvanced").hide();
							$(".gridDiv > div").css({"height":"60vh", "background-color":"white"});
							$(".gridAdvancedDiv > div").css("height","0");
						}	
					}
					
					$(".liveTab").css({
						'backgroundColor': '#FFFFFF', 'position': 'absolute', top:'56px', 'right': '8.5%', 'width': '48px', 'height': '4px'
					});
					$('.historyMenuLogger').css({ 'opacity': '0.5' });
                    window.scrollTo(0, document.body.scrollHeight);
					
					document.getElementById('<%= filter.ClientID %>').value = "";
					document.getElementById('<%= filterByTypeDropDown.ClientID %>').value = "0";
					document.getElementById('<%= hiddenSwitchValue.ClientID %>').value = "OFF";
					$(".LoggerGrid").show();
					$(".LoggerGridAdvanced").hide();
					$(".gridAdvancedDiv > div").css("height","0");
					$(".gridDiv > div").css({"height":"60vh", "background-color":"white"});
                    
					var count = 0;
					var val = 0;
					var c = 0;
					$(document).ready(function () {
						$('.switch').click(function () {
							val = 0;
							count++;
							if (count % 2 == 0 && count % 4 == 0) {
								val = count - 1;
							}
							else if (count % 2 == 0 && count % 4 != 0) {
								val = count - 2;
							}

							if (val % 2 != 0) {
								document.getElementById('<%= hiddenSwitchValue.ClientID %>').value = "OFF";
								$(".LoggerGrid").show();
								$(".LoggerGridAdvanced").hide();
								$(".gridAdvancedDiv > div").css("height","0");
								$(".gridDiv > div").css({"height":"60vh", "background-color":"white"});
								
							}
							else if (val % 2 == 0) {
								////Switch On
								document.getElementById('<%= hiddenSwitchValue.ClientID %>').value = "ON";
								$(".LoggerGrid").hide();
								$(".LoggerGridAdvanced").show();
								$(".gridAdvancedDiv > div").css({"height":"60vh", "background-color":"white"});
								$(".gridDiv > div").css("height","0");
							}
						});
					});
                    
					function ShowMessagesWithBellyBar(messageToDisplay)
					{
						var bellyBarTitle = "<%=resManager.GlobalResourceSet.GetString("ec_LoggerProductName") %>";
						se.ui.messageDialog.showError(bellyBarTitle, messageToDisplay, function () {
							window.close();
                        });
					}
                </script>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>