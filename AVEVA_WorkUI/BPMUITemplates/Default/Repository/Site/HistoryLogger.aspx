<%@ Page Language="C#" AutoEventWireup="true" Title="" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/WebLogger.master" Inherits="Skelta.Repository.Web.CodeBehind.HistoryLogger" Debug="true"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="mainContent" runat="server" SelectMethod="ShowEvent">	
<style>
        .switch {
            position: relative;
            display: inline-block;
            width: 40px;
            height: 15px;
			  float: right !important;
			  margin-right: 3% !important;
			  margin-top: 2.7% !important;
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
            bottom: -1.0px;
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
			
		.submitButton{
			background-color: #0F76C7 !important;
			color: #ffffff !important;
			border-radius: 8px;
			width: 100px !important;
			height: 32px !important;
			float: right !important;
			margin-right: 5%;
			margin-top: 28px !important;
			border-style: none !important;
		}
		
		.submitButton:hover {
			cursor: pointer;
			background-color: #0446a6 !important;
		}
		
		.historyBar{
			width: 100% !important;
			height: 100px !important;
		}
		
		.ui-widget-content {
			background: none !important;
			color: none !important;
			border: none !important;
		}
		
		.exportButton{
			border: none;
			float: right;
			height: 20px !important;
			width: 20px !important;
			margin-top: 2.5% !important;
			margin-right: 25px !important;
			opacity: 0.54;
		}
		
		.advancedOptionToogleText {
			float: right !important;
			margin-top: 2.6% !important;
			margin-right: 20px !important;
			color: rgba(0, 0, 0, 0.54) !important;
			font-family: "Roboto", "Segoe UI", "Arial", "Verdana";
			font-size: 14px !important;
		}
		
		.filterButton{
			border:none;
			float:right;
			height: 20px !important;
			width:20px !important;
			margin-top: 2.5% !important;
			margin-right: 25px !important;
			opacity: 0.54;
		}
		
		.dropDown, .enddate, .startdate, .filter{
			font-family: "Roboto", "Helvetica", "Arial", sans-serif;
		}
		
		.dropdown-menu {
			position: absolute;
			top: 100%;
			left: 0;
			z-index: 1000;
			display: none;
			float: left;
			min-width: 10rem;
			padding: .5rem 0;
			margin: .125rem 0 0;
			font-size: 1rem;
			color: #212529;
			text-align: left;
			list-style: none;
			background-color: #fff;
			background-clip: padding-box;
			border: 1px solid rgba(0,0,0,.15);
			border-radius: .25rem;
		}
		
		.mainContentDiv{
			height: calc(84vh);
			max-height: 84vh;
		}
		 
		.maxMessageModule{
			max-width: 600px !important;
			word-wrap: break-word !important;
		}
			
		.maxGridMessageModule{
			max-width: fit-content !important;
			word-break: break-all !important;
		}
		
		.headerClass > th 
		{
			text-align:left;
			max-width: 50px !important;
			padding-left:20px;
		}
		
		.maxTimeColumn{
			width: 100px !important;
			word-wrap: break-word !important;
			padding-left:20px;
		}
			
		.maxProcessColumn{
			width: 100px !important;
			word-wrap: break-word !important;
		}
			
		.logTypeColumn{
			width: 50px !important;
		}
    </style>
    <div>
		<div class="historyBar">
           <asp:Button ID="btnSubmit" type="button" runat="server" TabIndex="4" Text="Submit" Size="Small" ShowRoundedCorner="true" OnClientClick="ClearTextBox()" OnClick="Submit_Button" class="submitButton" Tooltip="Submit"/>
			<asp:DropDownList ID="repositoriesDropDownList" class="dropDown" TabIndex="3" runat="server" placeholder="Please Select" Style="border: 0; border-bottom: solid 0.20px #000; outline: none; width: 130px; height: 30px; float: right; margin-right: 20px!important; margin-top: 29px !important; background-color: transparent; color: rgba(0, 0, 0, 0.54); font-size: 14px !important;">
                <asp:ListItem Value="">Please Select</asp:ListItem>
            </asp:DropDownList>
			<asp:TextBox ID="txtEndDate" runat="server" TabIndex="2" placeholder="End Date" class="enddate" autocomplete="off" Style="border: 0; border-bottom: solid 0.20px #000; outline: none; width: 100px; background-image: url(Images/calendar.svg); background-size: 1.5rem !important; background-repeat: no-repeat; float:right; margin-top: 27px !important; height:30px !important; margin-right: 10px; background-color: transparent !important; background-position: right !important; padding-right: 20px; margin-right: 20px; font-size: 14px !important; color: rgba(0, 0, 0, 0.54);"></asp:TextBox>		
			<asp:TextBox ID="txtStartDate" runat="server" TabIndex="1" placeholder="Start Date" class="startdate" autocomplete="off" Style="border: 0; border-bottom: solid 0.20px #000; outline: none; width: 100px; background-image: url(Images/calendar.svg); background-size: 1.5rem !important; background-repeat: no-repeat; float:right; margin-top: 27px !important; height:30px !important; margin-right: 10px; background-color: transparent !important; background-position: right !important; padding-right: 20px; margin-right: 20px; font-size: 14px !important; color: rgba(0, 0, 0, 0.54);"></asp:TextBox>
        </div>
		<div>
			<div id="clickArea" runat="server" class="AdvancedOptionHistory">          
				<label class="switch" runat="server" style="cursor: pointer;">
					 <input type="checkbox" />
					 <span class="slider round"></span>
				</label>
				<div class="advancedOptionToogleText">Advanced Option</div>
				<asp:ImageButton ID="ImageButton1" class="exportButton" TabIndex="8" src="<%$ReplaceTemplateExpn:WorkItemList/Images/application-export.svg%>" runat="server" OnClick="Excel_Export" Tooltip="Export"/>
				<asp:ImageButton ID="filerButton" class="filterButton" TabIndex="7" src="<%$ReplaceTemplateExpn:WorkItemList/Images/filter-variant.svg%>" runat="server" OnClick="Filter_Search" Tooltip="Filter"/>
				<asp:TextBox ID="filter" type="search" class="filter" runat="server" OnTextChanged="Filter_Search" TabIndex="6" placeholder="Message Filter" autocomplete="off" Style="border: 0; border-bottom: solid 0.20px #000; outline: none; width: 110px; background-repeat: no-repeat; float:right; padding:5px; margin-top: 2.3%; color: rgba(0, 0, 0, 0.54);"></asp:TextBox>
				<asp:DropDownList ID="filterByTypeDropDown" class="dropDown" TabIndex="5" runat="server" placeholder="Filter By Type" Style="border: 0; border-bottom: solid 0.20px #000; outline: none; width: 110px; height: 26px; float: right; margin-right: 20px!important; margin-top: 2.3% !important; background-color: transparent; color: rgba(0, 0, 0, 0.54); font-size: 14px !important;">
					<asp:ListItem Value="0">All</asp:ListItem>
					<asp:ListItem Value="1">Information</asp:ListItem>
					<asp:ListItem Value="2">Warning</asp:ListItem>
					<asp:ListItem Value="3">Error</asp:ListItem>
				</asp:DropDownList>
			</div>
		</div>		
        <asp:UpdatePanel ID="updatePanel" runat="server">
            <ContentTemplate>
                <asp:Literal ID="literalMessages" runat="server" />
				<asp:HiddenField ID="hiddenSwitchValue" runat="server" /> 
				
				<div style="max-height: 57vh; overflow-y: auto; overflow-x: hidden; width: 90% !important; margin-left: 5% !important" ID="grid" runat="server" class="gridDiv">
				<asp:GridView ID="gridLogInfoList" runat="server" Width="100%" OnRowDataBound="GridLogInfoList_RowDataBound" CssClass="LoggerGrid" AutoGenerateColumns="false" border="0" GridLines="Horizontal" CellPadding="5" ShowHeaderWhenEmpty="true" EmptyDataText="No logs Found">
					<HeaderStyle Height="40px" HorizontalAlign="Left" CssClass="headerClass"/>
                    <Columns>
                        <asp:TemplateField HeaderText="Time" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="maxTimeColumn">
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </asp:TemplateField>
						<asp:ImageField HeaderText="Type" DataImageUrlField="LogType" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="logTypeColumn" ControlStyle-Height="24" ControlStyle-Width="24"/>
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

				<div style="max-height: 57vh; overflow-y: auto; overflow-x: hidden; width: 90% !important; margin-left: 5% !important" ID="gridDiv" runat="server" class="gridAdvancedDiv">
                <asp:GridView ID="gridLogInfoListAdvanced" runat="server" Width="100%" OnRowDataBound="GridLogInfoListAdvanced_RowDataBound" CssClass="LoggerGridAdvanced" AutoGenerateColumns="false" border="0" GridLines="Horizontal" CellPadding="5" ShowHeaderWhenEmpty="true" EmptyDataText="No logs Found">
					<HeaderStyle Height="40px" HorizontalAlign="Left" CssClass="headerClass"/>
                    <Columns>
                        <asp:TemplateField HeaderText="Time" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="maxTimeColumn">
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </asp:TemplateField>
						<asp:ImageField HeaderText="Type" DataImageUrlField="LogType" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="logTypeColumn" ControlStyle-Height="24" ControlStyle-Width="24"/>
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

					jQuery.browser = {};
					(function () {
						jQuery.browser.msie = false;
						jQuery.browser.version = 0;
						if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
							jQuery.browser.msie = true;
							jQuery.browser.version = RegExp.$1;
						}
					})();
					
					$(document).ready(function () {
						$('.startdate').datepicker({
							format: "dd/mm/yyyy",
							autoclose: true,
							todayHighlight: true,
							inline: true,
							onSelect: function (dateText, inst) {
								var date = $(this).datepicker('getDate'),
									day = date.getDate(),
									month = date.getMonth() + 1,
									year = date.getFullYear();
							}
						});
						$('#ui-datepicker-div').removeClass('ui-helper-hidden-accessible');
					});

					$(document).ready(function () {
						$('.enddate').datepicker({
							format: "dd/mm/yyyy",
							autoclose: true,
							todayHighlight: true,
							inline: true,
							onSelect: function (dateText, inst) {
								var date = $(this).datepicker('getDate'),
									day = date.getDate(),
									month = date.getMonth() + 1,
									year = date.getFullYear();
							}
						});
						$('#ui-datepicker-div').removeClass('ui-helper-hidden-accessible');
					});
					
					$(".LoggerGridAdvanced").hide();
                    $(".gridAdvancedDiv > div").css("height","0");
					$(".gridDiv > div").css({"height":"57vh", "background-color":"white"});
					
					$(".historyTab").css({
						'backgroundColor': '#FFFFFF', 'position': 'absolute', 'top': '56px', 'right': '5.0%', 'width': '48px', 'height': '4px'
					});
					$('.liveMenuLogger').css({ 'opacity': '0.5' });
					
                    window.scrollTo(0, document.body.scrollHeight);
					
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
								$(".gridDiv > div").css({"height":"57vh", "background-color":"white"});
							}
							else if (val % 2 == 0) {
								////Switch On
								document.getElementById('<%= hiddenSwitchValue.ClientID %>').value = "ON";
								$(".LoggerGrid").hide();
								$(".LoggerGridAdvanced").show();
                                $(".gridAdvancedDiv > div").css({"height":"57vh", "background-color":"white"});
								$(".gridDiv > div").css("height","0");
							}
						});
					});
					
					function ShowMessagesWithBellyBar(messageType, messageToDisplay)
					{
						var bellyBarTitle = "<%=resManager.GlobalResourceSet.GetString("ec_LoggerProductName") %>";
						switch (messageType) {
							case 1: se.ui.messageDialog.showAlert(bellyBarTitle, messageToDisplay);
								break;
							case 2: se.ui.messageDialog.showError(bellyBarTitle, messageToDisplay);
								break;
						}
					}
					
					function ClearTextBox()
					{
						document.getElementById('<%= filter.ClientID %>').value = "";
						document.getElementById('<%= filterByTypeDropDown.ClientID %>').value = "0";
					}
                </script>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
