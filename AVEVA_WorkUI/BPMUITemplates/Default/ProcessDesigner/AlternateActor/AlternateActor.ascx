<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.HWS.UserControls.AlternateActor" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


<script src="<%=JavaScriptReferencePath%>Common/JavaScripts/jquery.min.js"></script>
<script src="<%=JavaScriptReferencePath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=commonCssPath%>CommonUXControls/StyleSheet/se.ui.min.css">
<link rel="stylesheet" type="text/css" href="<%=commonCssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css">
<link rel="stylesheet" type="text/css" href="<%=commonCssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css">
<link rel="stylesheet" type="text/css" href="<%=commonCssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
<link rel="stylesheet" type="text/css" href="<%=commonCssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
<link rel="stylesheet" type="text/css" href="<%=commonCssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
<link rel="stylesheet" type="text/css" href="<%=commonCssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">




<link href="<%= commonCssPath %>Common/StyleSheet/global.css" rel="stylesheet" type="text/css" />


<script type="text/javascript">

    se.ui.messageDialog.setGlobalOptions({
        localization: {
            closeButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                   okButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                   cancelButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                   showDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                   hideDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
               }
    });

    //variable used for assigning actor within add actor window from search actor window.
 
    var toActor = '';
    
    function OnInitialize(gridId){
        //On grid intialize.
        var grid = wgGetGridById(gridId);
        grid.HidePadColumn = true;
        // grid.RefreshAll();
    }

    function CheckSearchActorInputs() {
        //checks search text is empty
        if( TrimSpaces(document.getElementById('<%=this.ClientID%>_txtSearch').value) == '' ) {
            alert( "<%= altActor_message_SearchTextisEmpty %>" );
            return false;
        }
        //checks search by option is selected
        if(! document.getElementById('<%= rdoListSearchBy.ClientID %>_0').checked ) {
            if(! document.getElementById('<%= rdoListSearchBy.ClientID %>_1').checked ) {
                alert( "<%= altActor_message_SearchByNotSelected %>" );
                return false;
            }
        }
        return true;
    }
    
    //validates inputs of add actor window before submission
    function CheckAddActorInputs() {
    
        //checks type of rule is selected
        if(! document.getElementById('<%= rdoListType.ClientID %>_0').checked ) {
            if(! document.getElementById('<%= rdoListType.ClientID %>_1').checked ) 
            {                
                se.ui.messageDialog.showError("<%=altActor_bellyBarTitle%>", "<%= altActor_message_TypeNotSelected %>");
                return false;
            }
        }
        
        //checks actor for rule is selected
        if('<%=workflowSpecific%>'=="False" && '<%=(actorObject != null) %>' == "True")
        {
            if( TrimSpaces( document.getElementById('<%=this.ClientID%>_hidden_lblActor').value ) == '' ) 
            {                
                se.ui.messageDialog.showError("<%=altActor_bellyBarTitle%>", "<%= altActor_message_ActorNotSelected %>");
                return false;
            }
        }
        else
        {
            //checks actor for rule is selected
            if( TrimSpaces( document.getElementById('<%=this.ClientID%>_usrName').value ) == '' ) 
            {                
                se.ui.messageDialog.showError("<%=altActor_bellyBarTitle%>", "<%= altActor_message_ActorNotSelected %>");
                return false;
            }
        }
        
        //checks alternate actor for rule is selected
        if( TrimSpaces( document.getElementById('<%=this.ClientID%>_altUsrName').value ) == '' ) {            
            se.ui.messageDialog.showError("<%=altActor_bellyBarTitle%>", "<%= altActor_message_AlternateActorNotSelected %>");
            return false;
        }
        //checks whether from date alone is empty
        if( ( TrimSpaces( document.getElementById('<%=this.ClientID%>_firstInputDate').value ) == '' ) && 
            ( TrimSpaces( document.getElementById('<%=this.ClientID%>_secondInputDate').value ) != '' ) ) 
        {            
            se.ui.messageDialog.showError("<%=altActor_bellyBarTitle%>", "<%= altActor_message_FromDateEmpty %>");
            return false;
        }
        
        //checks whether to date alone is empty
        if( ( TrimSpaces( document.getElementById('<%=this.ClientID%>_firstInputDate').value ) != '' ) && 
            ( TrimSpaces( document.getElementById('<%=this.ClientID%>_secondInputDate').value ) == '' ) ) {
            
            se.ui.messageDialog.showError("<%=altActor_bellyBarTitle%>", "<%= altActor_message_ToDateEmpty %>");
            return false;
        }
        
        //checks entered from date if any, is valid
        if( TrimSpaces( document.getElementById('<%=this.ClientID%>_firstInputDate').value ) != '' ) {
            if(! checkDate( document.getElementById('<%=this.ClientID%>_firstInputDate').value ) ) {                
                se.ui.messageDialog.showError("<%=altActor_bellyBarTitle%>", "<%= altActor_message_FromDateInvalid %>");
                return false;
            }
        }

        //Checking the from date is greater than todays date
        var today = new Date();
        var m = today.getMonth()+1;
        var d = today.getDate();
        var y = today.getFullYear();
        var todaysDate=y+"-"+m+"-"+d;
                      
        if(dateCompare(todaysDate,document.getElementById('<%=this.ClientID%>_firstInputDate').value) > 0 ) 
        {            
            se.ui.messageDialog.showError("<%=altActor_bellyBarTitle%>", "<%= altActor_message_FromDateValidation %>");
            return false;
        }
        
        //checks entered to date if any, is valid
        if( TrimSpaces( document.getElementById('<%=this.ClientID%>_secondInputDate').value ) != '' ) {
            if(! checkDate( document.getElementById('<%=this.ClientID%>_secondInputDate').value ) ) {                
                se.ui.messageDialog.showError("<%=altActor_bellyBarTitle%>", "<%= altActor_message_ToDateInvalid %>");
                return false;
            }
        }
        
        //compare from date and to date
        if( dateCompare( document.getElementById('<%=this.ClientID%>_firstInputDate').value, document.getElementById('<%=this.ClientID%>_secondInputDate').value ) > 0 ) {
            se.ui.messageDialog.showError("<%=altActor_bellyBarTitle%>", "<%= altActor_message_FromDateGreater %>");            
            return false;
        }

        //checks whether to date alone is empty
        if('<%=DateIsMandatory%>' == 'True')
        {
            if( ( TrimSpaces( document.getElementById('<%=this.ClientID%>_firstInputDate').value ) == '' ) && 
                ( TrimSpaces( document.getElementById('<%=this.ClientID%>_secondInputDate').value ) == '' ) ) 
            {                        
                se.ui.messageDialog.showError("<%=altActor_bellyBarTitle%>", "<%= altActor_message_DateConfiguration %>");            
                return false;
            }
        }
        
        document.getElementById('<%=this.ClientID%>_firstInput').value=document.getElementById('<%=this.ClientID%>_firstInputDate').value;
        document.getElementById('<%=this.ClientID%>_secondInput').value=document.getElementById('<%=this.ClientID%>_secondInputDate').value;
        
        
        //submit the form	
        return true;
    }
    
    //opens a pop up window for adding alternate actor
    function AddActorPopup()
    {
        
        var left = (screen.width / 2) - (1000 / 2);
        var top = (screen.availHeight / 2) - (620 / 2);

        //open window for adding alternate actor
        myActWindow = window.open ( AddActorUrl( location.href ), "winAddActor", "location=0, status=0, scrollbars=yes, width=1000, height=620, resizable=yes, top=" + top + ", left=" + left );
        //move that window to specified loacation
        //myActWindow.moveTo(0,0);
        //block reloading of current window
        return false;
    }
     
    //opens a pop up window for searching an actor
    function SearchActorPopup( to, crossChecks )
    {
        var left = (screen.width / 2) - (550 / 2);
        var top = (screen.height / 2) - (250 / 2);


        //open window for searching actor
        myActWindow = window.open ( SearchActorUrl( location.href, to, crossChecks ), "winSearchActor", "location=0, status=0, scrollbars=0, width=550, height=250, resizable=no, top=" + top + ", left=" + left );
        //move the window to specified location
        //myActWindow.moveTo(10,10);
        //block reloading of current window
        return false;
    }
     
    //returns url for add actor page.  it contains a query string div=divaddactor
    function AddActorUrl( currentUrl ) 
    {
    
        currentUrl=currentUrl.replace('#',''); //For Handling the opening of window in case if we click Help icon first and then add actor next
        //if current url has got query string, append values, else make querystring
        if( currentUrl.indexOf('?') >= 0 ) {
            currentUrl += '&';
        }
        else {
            currentUrl += '?';
        }
        //add querystring that identifies it as add actor url
        currentUrl += 'div=divAddActor';
        //return modified url
        return currentUrl;
    }
    
    //returns url for search actor page. it contains query string div=divsearchactor
    function SearchActorUrl( currentUrl, to, crossCheckFields ) {
        //modify current url, by replacing the div= value
        currentUrl = currentUrl.replace(/div=divAddActor/, 'div=divSearchActor');
        //workflow combo control
        var radCombo = <%=comboWorkFlows.ClientID%>;
        //get the workflow seleted for using within actionsdata in search actor page
        var wfName = radCombo.GetValue();

        //append querystring to= for identifying from which link the pop up is fired, ie, from actor or alternate actor and selected workflowname
        return currentUrl + '&to=' + to + '&cross=' + crossCheckFields + '&wf=' + wfName;
    }
    
    //closes the  current window
    function Close() {
        window.close();
    }
    
    //enables the submit button of search actor window. by default it will be disabled. on selection of list box, submit button will gets enabled
    function EnableActorSubmit() {
        document.getElementById('<%= btnActorSubmit.ClientID %>').disabled = false;
    }
    
    //assigns the selected actor from search actor window to add actor window.
    function AssignActor() {
        //splits the query string of current url to array
        var mysearch = location.search.substr(1).split("&");
        //cross check variable
        var crossChecks = '';
        //loop through array
        for( var i=0; i<mysearch.length; i++ ) {
            //if querystring has to= 
            if( mysearch[i].indexOf('to=') == 0 ) {
                //assign the label id to be changed with selected actors name
                toActor = TrimSpaces( mysearch[i].replace(/to=/, '') );
            }
                //if querystring has cross= 
            else if( mysearch[i].indexOf('cross=') == 0 ) {
                //assign the cross check fields to variable
                crossChecks = TrimSpaces( mysearch[i].replace(/cross=/, '') );
            }
        }
        
        //if there is an id for label to be changed
        if( toActor != '' ) {
            //if actors are unique
            if( window.opener.IsActorsUnique( document.getElementById('<%= listBoxActors.ClientID %>').value, crossChecks ) ) {
                //change the label text and guid within the add actor window
                window.opener.ChangeActor( toActor, document.getElementById('<%= listBoxActors.ClientID %>').value );
                //close search actor window
                window.close();
            }
            else {
                alert( '<%= altActor_message_ActorsUnique %>' );
                return false;
            }
        }
    }
    
    //Change actor.  expects field name to be assigned and value as display text and value separated with comma
    function ChangeActor( actorField, textCommaValue ) {
        //actor name to be displayed
        var display = textCommaValue.split("@$#")[0];
        //actor guid to be insereted within database
        var hidden = textCommaValue.split("@$#")[1];
        //change the display name within form
        document.getElementById('<%=this.ClientID%>_' + actorField).innerText = display;
        //assign the guid to hidden field, which is used while submitting the form
        document.getElementById('<%=this.ClientID%>_hidden_' + actorField).value = hidden;
    
    }
    
    //checks the uniqueness of field values.  expects check fields to be separated with ,
    function IsActorsUnique( valueToCheck, checks ) {
        //split to fields to array
        var fields = checks.split(",");
        
        //for each actor in array
        for( var i=0; i<fields.length; i++ ) {
            //if found same actor combined with comma and guid
            if( TrimSpaces(document.getElementById('<%=this.ClientID%>_' + fields[i]).innerText + ',' + document.getElementById('<%=this.ClientID%>_hidden_' + fields[i]).value ) == TrimSpaces( valueToCheck ) ) {
                //return false
                return false;
            }
        }
        //return true
        return true;
    }
    
    //Refresh grid data
    function RefreshGrid() {  
   
        var grid = ISGetObject("WebGrid1");
        grid.Refresh();    
    }

    
    //removes the blank spaces from beginning and end of a string
    function TrimSpaces( str ) {
        var start;
        var end;
        str = str.toString();
        var len = str.length;
        for (start = 0; start < len; start ++) {
            if (str.charAt(start) != ' ')
                break;
        }
        if (start == len)
            return "";
        for (end = len - 1; end > start; end --) {
            if (str.charAt(end) != ' ')
                break;
        }
        end ++;
        return str.substring(start, end);
    }
     
    //variables used by rad calendar control
    var calendar, popup, calendarContainer, activeInput, isVisible;
   
    //rad calendar control function
    function ToggleCalendar(e, inputId) {
         
        ShowCalendar(inputId);
        e.cancelBubble = true;
        return false;
    }
    
    // This Function Compare two dates
    // If dateStr1 > dateStr2 then returns 1, If dateStr1 < dateStr2 then returns -1 If dateStr1 = dateStr2 then returns 0
    // Dates should be in the format MM/DD/YYYY
    function dateCompare(dateStr1, dateStr2)
    {
     
        var day1, day2, month1, month2, yr1, yr2;
        //var months = new Array('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
            
        arr1 = dateStr1.split('-');
        arr2 = dateStr2.split('-');
            
        /*for(i=0;i<months.length;i++)
              {
                    if (months[i] == arr1[1])
                          month1 = i;
                    
                    if (months[i] == arr2[1])
                          month2 = i; 
              }*/
            
        month1 = parseInt(arr1[1],10);
        month2 = parseInt(arr2[1],10);
            
        var date1 = new Date();
        var date2 = new Date();
            
        day1 = parseInt(arr1[2], 10);
        yr1   = parseInt(arr1[0], 10);
            
        day2 = parseInt(arr2[2], 10);
        yr2   = parseInt(arr2[0], 10);

                        
        if (yr1 == yr2)
        {
            if (month1 == month2)
            {
                if (day1 == day2)
                    return 0;
                else if (day1 > day2)
                    return 1;
                else if (day1 < day2)
                    return -1;
            }
            else if (month1 > month2)
                return 1;
            else if (month1 < month2)
                return -1;
        }           
        else if (yr1 > yr2)
            return 1;
        else if (yr1 < yr2)
            return -1;
                  
    }

    //********************************************************************
    /*function checks whether the selected Date is Valid or Not*/
    /*Checks that user enters in MM/DD/YYYY format*/
    //********************************************************************
    function checkDate(Dtval) {
        var flagval;
        var tempStr;
        for(i=0;i<Dtval.length;i++) {
            tempStr = Dtval.charAt(i);
            if ((tempStr >= 0)&&(tempStr<=9)) {}
            else {
                if (tempStr=="-") {}
                else {
                    // 
                    flagval=false;
                    return 
                    false;    
                }
            }
        }
        if(Dtval.indexOf("-")=="-1")
        {
            //flagval=false;
            return false;    
        }
                        
        if(flagval!=false)
        {
            var Dtval1=Dtval.split("-")
                                    
            //                              if ((Dtval1[0]==0)||(Dtval1[0]>12)
            //||(Dtval1[0].length>2)||(Dtval1[1]==0)||(Dtval1[1].length>2)||(Dtval1[1]
            //>31)||(Dtval1[2]<1975)||(Dtval1[2]>2100)||(Dtval1[2].length<4)||(Dtval1
            //[2].length>4))

            if( (Dtval1[0]<1975)||(Dtval1[0]>2100)
            ||(Dtval1[1]==0)||(Dtval1[1]>12||Dtval1[1].length>2)
            ||(Dtval1[2]==0)||(Dtval1[2].length>2)||(Dtval1[2]>31))  
            {
                                    
                //flagval=false;    
                return false; 
            }
        }
        return true;      
    }

    
    //rad calendar control function
    function ShowCalendar(inputId) {
        
        if (!calendar)
            calendar = <%=Radcalendar2.ClientID%>;
        
        if (!popup)
            popup = new RadCalendar.Popup();
            
        if (!calendarContainer)
            calendarContainer = document.getElementById("calendarContainer");
            
        if (activeInput
            && activeInput.id == inputId
            && popup.IsVisible())
        {
            popup.Hide();
        }			
        else
        {        
            activeInput = document.getElementById(inputId);
            var x = PositionX(activeInput);
            var y = document.getElementById('<%= rdoListType.ClientID %>').offsetTop;
            popup.Show(x, y, calendarContainer);
        }
    }
    
    //rad calendar control function
    function ChangeInput(calendarInstance, renderDay)
    {  
        
        var dateArray = renderDay.Date;  
        var dateString = dateArray[1] + "/" + dateArray[2] + "/" + dateArray[0];
        activeInput.value = dateString;
        
        if (popup.IsVisible())
        {
            popup.Hide();
        }
    }
    
    //rad calendar control function
    function Init()
    {
        ShowCalendar('firstInputDate');
    }
    
    //rad calendar control function
    function PositionX(inputElement) 
    {
        var offsetLeft = 0;
        if (inputElement.offsetParent)
        {
            while (inputElement.offsetParent)
            {
                offsetLeft += inputElement.offsetLeft;
                inputElement = inputElement.offsetParent;
            }
        }
        else if (inputElement.x)
        {
            offsetLeft += inputElement.x;
        }
        return offsetLeft;
    }
    
    //rad calendar control function
    function PositionY(inputElement) 
    {
        var offsetTop = 0;
        //alert( document.getElementById('Radcalendar2').offsetHeight);
        if (inputElement.offsetParent)
        {
            while (inputElement.offsetParent)
            {
                offsetTop += inputElement.offsetTop;
                inputElement = inputElement.offsetParent;
            }
        }
        else if (inputElement.y)
        {
            offsetTop += inputElement.y;
        }
        return offsetTop;
    }
    
    function OnRowContextMenu(gridId, rowType, rowElement, menuObject) 
    {
   
        var i;
        var grid = wgGetGridById(gridId);	             
        if (rowType != "Record") return true;	
        if(rowType =="Record")
        {
            // hide the default context menu
            for (i=0;i<=43;i++)
            {
                if(i!=22)         
                    menuObject.Items[i].Hide();                      
            }                       
                               
        } 
        return true;	
    }


    function selectUsers(usernameclientid, hiddenusernameclienid, btnlistingclientid) {

        var oWindow;
        var urlParam;
        if (document.getElementById(hiddenusernameclienid) != null) {
            urlParam = '?users=' + encodeURIComponent(document.getElementById(hiddenusernameclienid).value) + '&singleselection=1';
            oWindow = radopen("../../Repository/Site/UserLookup.aspx" + urlParam, null);
        }
        else {
            urlParam = '?singleselection=1';
            oWindow = radopen("../../Repository/Site/UserLookup.aspx", null);
        }
        oWindow.set_modal(true);
        oWindow.set_title('Select User');
        oWindow.setSize(600, 500);
        oWindow.setActive(true);
        oWindow.center();

        oWindow.add_beforeClose(onClientBeforeCloseUserLookup);

        function onClientBeforeCloseUserLookup(sender, args)
        {
            var returnValue = args.get_argument();

            if (returnValue !== null && returnValue !== undefined)
            {
                var oArea = document.getElementById(usernameclientid);
                var ids;
                var names = '';
                var useridstring = '';


                if (returnValue.indexOf("@!@") != -1)
                {
                    alert('<%=usrLookupText%>');
                    args.set_cancel(true);
                    return;
                }

                if (returnValue.lastIndexOf("^") != -1)
                {
                    var usernamestring = returnValue.substring(0, returnValue.lastIndexOf("^"));
                    useridstring = returnValue.substring(returnValue.lastIndexOf("^") + 1);
                    names = usernamestring;
                }

                oArea.value = names;
                var oArea1 = document.getElementById(hiddenusernameclienid);
                oArea1.value = useridstring;

                if (btnlistingclientid != undefined)
                {
                    var btn = document.getElementById(btnlistingclientid);
                    btn.disabled = false;
                }
            }

            sender.remove_beforeClose(onClientBeforeCloseUserLookup);
        }
    }

    function ShowAlternateActorHelp()
    {
        var left = (screen.width / 2) - (600 / 2);
        var top = (screen.height / 2) - (450 / 2);

        window.open('<%=HelpPageUrl%>alternateactors.html','newwin','height=450,width=600,resizable=yes,status=no,scrollbars=yes,top='+ top + ', left=' + left);

    }

    // Timeout tracker variable to control the WebGrid Resize calls.
    var webGridTimer = 0;

    function InitWebGrid()
    {
       
        var grid = ISGetObject("WebGrid1");            
        try {
            // grid.GetRootTable().Columns[0].ResizeBestFit();
            //grid.RefreshGrid();

            //
            // When there are around 3 items. Then when we have the page in full screen, 
            // the 3 items are visible and do not show scrollbar in the grid. When we
            // resize the page, such that all 3 items are not visible, then the scrollbar 
            // should be present in the grid.
            // Below code is required to perform that action. Else in Firefox, the scrollbars 
            // are not visible.
            //

            if (webGridTimer != 0)
            {
                window.clearTimeout(webGridTimer);
                webGridTimer = 0;
            }

            webGridTimer = window.setTimeout(function ()
                            {
                                wgDoResize(true, true);
                            }, 500);
        } catch (e) { }

    }
    AddEventHandler(window, 'load', InitWebGrid);
    AddEventHandler(window, 'resize', InitWebGrid);

    function AddEventHandler(elementObject, eventName, functionObject) {
        if (document.addEventListener)
            elementObject.addEventListener(eventName, functionObject, false);
        else
            if (document.attachEvent)
                elementObject.attachEvent("on" + eventName, functionObject);
    }
     
    function OpenAuditTrail()
    {
        var oWindow;
        oWindow = radopen("AlternateActorAuditTrail.aspx", null);
        oWindow.set_modal(true);
        oWindow.set_title('Select User');
        oWindow.setSize(1100, 500);
        oWindow.setActive(true);
        oWindow.center();       
    }
   
   
</script>
<telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
<div id="divGrid" runat="server" style="padding-left:10px;padding-right:10px; height:100%; width:100%;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;box-sizing:border-box;">
    <table style="width:100%;height:100%;border-spacing:0px;border-collapse:collapse;padding:2px; box-sizing:border-box;">
        <tr  style="height:100%;width:100%;vertical-align:top;">
            <td style="height:100%;width:100%;">
                <table  style="width:100%;height:100%; border-spacing:0px;border-collapse:collapse;">
                    <tr class="ListHeaderCss">
                        <td class="fontheading" style="width:50%;text-align:left;padding:2px;">
                            <span class="fontheading">
                            <%=altActor_pageHeader_AlternateActors%>
                            </span>
                        </td>
                        <td  style="width:50%;text-align:right;padding:2px;vertical-align:middle;">
                            <a href="#" onclick="javascript:ShowAlternateActorHelp()">
                                <img  src="<%= commonCssPath %>HWS/Images/icon-help.png")"   style="cursor: pointer;border:0px;text-align:right;"
                                    alt="<%=HelpAlternateActor%>" /></a></td>
                    </tr>
                    <tr style="vertical-align:top;width:100%;padding:2px;">
                        <td style="width:100%;text-align:left;" colspan="2" class="lefttdbg" >
                            <div style="position:absolute;top:40px;right:14px;left:14px;bottom:48px;">
                            <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Width="100%" Height="100%"
                                OnInitializeDataSource="WebGrid1_InitializeDataSource"
                                HorizontalAlign="NotSet" OnDeleteRow="WebGrid1_DeleteRow" OnPrepareDataBinding="WebGrid1_PrepareDataBinding"
                                ViewStateStorage="None" AllowAutoDataCaching="false" DisableFileSystemChecking="true" EnableWebResources="never" RenderingMode="HTML5">                              
                                        <LayoutSettings AlwaysShowHelpButton="false" PagingMode="VirtualLoad" AllowDelete="Yes"  VirtualPageSize="20" 
                                             CellClickAction="RowSelect"  UseRelativePositioning="true" PersistRowChecker="True"   AllowAddNew="No" 
                                        AlternatingColors="true" GridLineStyle="Solid"  GridLineColor="#afafaf" CellPaddingDefault="2" 
                                        RowHeightDefault="30px" AutoFitColumns="true" AutoFitColumnsBuffering="false" AllowFilter="Yes"
                                        GridLines="None" ScriptDirectory="../../InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/" PromptBeforeDelete="true" 
                                        FilterBarVisible="false" RowHeaders="No">
                                        <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"></HeaderStyle>
                                        <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                        <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                                        <GroupByBox>
                                            <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                            <Style BackColor="#ececec"></Style>
                                        </GroupByBox>
                                        <FilterRowStyle CssClass="GridEditFocusCellStyle"></FilterRowStyle>
                                        <EditTextboxStyle CssClass="GridEditTextBoxStyle"></EditTextboxStyle>
                                        <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                        <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                                        <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                        <AlternatingRowStyle CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                                        <StatusBarStyle CssClass="GridStatusBarStyle">
                                            <Padding Top="0px" Left="0px" Bottom="0px" Right="0px"></Padding>
                                        </StatusBarStyle>
                                        <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">

                                        </StatusBarCommandStyle>
                                        <RowStyle  OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"  CssClass="GridRowStyle"></RowStyle>
                                        <ClientSideEvents OnRowContextMenu="OnRowContextMenu" OnInitialize="OnInitialize" />
                                        <TextSettings Language="UseCulture"></TextSettings>
                                        <LostFocusRowStyle CssClass="GridSelectedRowStyle"></LostFocusRowStyle>
                                             <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                            ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"                                            
                                             />
                                    </LayoutSettings>
                                <RootTable Caption="Alternate Actors" CaptionImage="Customer.gif" GridLineStyle="NotSet">
                                    <TableHeaderStyle BackgroundImage="../../Intersoft/Grid/CommonLibrary/Images/SelectColumns.gif"
                                        Width="100%" />
                                </RootTable>
                            </ISWebGrid:WebGrid>
                            </div>
                        </td>
                    </tr>
                    <tr style="height:48px; vertical-align:middle;">
                        <td style="text-align:right;padding-right:2px;padding-top:10px;padding-bottom:5px;" colspan="2">
                           <% if (enableAuditTrail ){ %>
                            <input type="button" class="inputsecondarybutton" value="<%=altActor_AuditTrail_Button_Caption %>" id="buttonAuditTrail" onclick="OpenAuditTrail();" name="btnok">
                            <%}%>
                            <asp:Button ID="btnGridCancel" runat="server"  CssClass="inputsecondarybutton" />
                            <asp:Button ID="btnGridAddNew" runat="server" CssClass="inputbutton" />
                                                      
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
<div id="divAddActor" runat="server" style="height:100%;">        
    <table style="width:100%;border-spacing:0px;border-collapse:collapse;border:0px solid;height:100%;">
        <tr>
            <td style="height:100%;">
                <table style="height:100%;width:100%;border-spacing:0px;border-collapse:collapse;" >
                    <tr class="ListHeaderCss">
                        <td  colspan="2" style="padding:10px 5px 5px 10px;">
                            <span class="fontheading">
                            <%= altActor_pageHeader_AddAlternateActor %>
                            </span>
                        </td>
                    </tr>                   
                    <tr>
                        <td colspan="2" style="text-align:left;padding:0px;vertical-align:top;" class="lefttdbg" >
                            <table style="width:100%;border-spacing:1px;border-collapse:separate;height:100%;border:0px solid;" class="tablebg" >
                                <tr>
                                    <td style="width:30%;padding-left:20px;text-align:left;height:25px;"  class="lefttdbg" >
                                        <span class="subtitle"> <%= altActor_Label_Workflow %></span>
                                    </td>
                                    <td style="width:70%;padding-left:10px;height:25px;" colspan="3" class="righttdbg">
                                   <telerik:RadComboBox   ID="comboWorkFlows" EnableLoadOnDemand="true" RenderMode="Classic" runat="server"  Skin="AWTCombobox"  DataTextField="Workflow" DataValueField="Workflow" AutoPostBack="True"  EnableEmbeddedSkins="false" >
                                  </telerik:RadComboBox>
                                </td>
                                </tr>
                                <%if (comboActivities.Visible) 
                                          {%>
                                <tr>
                                    <td style="text-align:left;padding-left:20px;width:30%;height:25px;" class="lefttdbg" >
                                        <span class="subtitle">
                                            <%= altActor_Label_Activities %>
                                            </span></td>
                                    <td style="width:70%;padding-left:10px;height:25px;" colspan="3" class="righttdbg">
                                        <%}%>
                                   <telerik:RadComboBox RenderMode="Classic" ID="comboActivities" runat="server" EnableLoadOnDemand="true"  DataTextField ="ActivityType" DataValueField="ActivityType" Skin="AWTCombobox" EnableEmbeddedSkins="false" >
                                  </telerik:RadComboBox>
                                       
                                        <%if (comboActivities.Visible) 
                                          {%>
                                    </td>
                                </tr>
                                <%}%>
                                <tr>
                                    <td style="text-align:left;padding-left:20px;width:30%;height:25px;"  class="lefttdbg">
                                        <span class="subtitle">
                                            <%= altActor_Label_Type %>
                                            </span></td>
                                    <td colspan="3" class="righttdbg" style="width:70%;padding-left:2px;height:25px;text-align:left;" >
                                        <asp:RadioButtonList ID="rdoListType" runat="server" BorderStyle="None" RepeatDirection="Horizontal" CssClass="inputradio" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left:20px;height:10px;" colspan="4"  class="lefttdbg">
                                     <span class="subtitle">
                                      <%= altActor_buttonCaption_Search%> 
                                      </span> </td>
                                </tr>
                                <tr>
                                    <td style="text-align:left;padding-left:20px;height:25px;" class="lefttdbg">
                                        <span class="subtitle">
                                            <%= altActor_Actor%>
                                            </span></td>
                                    <td class="righttdbg" style="width: 25%;padding-left:10px;height:25px;">
                                       
                                            <% if (workflowSpecific ||(!workflowSpecific && actorObject == null)){ %>
                                            
                                                    <asp:TextBox ID="usrName" CssClass="inputtext" runat="server" onclick="this.blur()" onkeyup="this.blur()" onkeydown="this.blur()" onmouseover="this.blur()" Width="200px">
                                                     </asp:TextBox>
                                                    <input id="Button6" class="userlookup" onclick="selectUsers('<%=usrName.ClientID %>','<%=usrNameHidden.ClientID%>','<%=buttonListing.ClientID%>');"
                                                     type="button" title="" value=".." name="SiteExplorer" style="padding-top:5px;" />
                                                     <asp:HiddenField ID="usrNameHidden" runat="server" />
                                                <%} %>
                                                <asp:Label ID="lblActor"  runat="server" CssClass="description"  />
                                                <input type="hidden" id="hidden_lblActor" runat="server" />                                              
                                                                                                
                                                                                        
                                    </td>
                                    <td style="text-align:left;padding-left:45px;height:25px;" class="lefttdbg">
                                        <span class="subtitle">
                                            <%= altActor_Alternate_Actor %>
                                            </span></td>
                                    <td class="righttdbg" style="width:25%;padding-left:2px;height:25px;">
                                            <asp:Label Style="cursor: hand" ID="lblAlternateActor" runat="server" Visible="false"  />
                                            <input type="hidden" id="hidden_lblAlternateActor" runat="server" />
                                                                               
                                        <asp:TextBox ID="altUsrName" CssClass="inputtext" runat="server" onclick="this.blur()" onkeyup="this.blur()" onkeydown="this.blur()" onmouseover="this.blur()" Width="200px"></asp:TextBox>
                                        <input id="Button1" class="userlookup" onclick="selectUsers('<%=altUsrName.ClientID %>','<%=altUsrNameHidden.ClientID%>');"
                                        type="button" title="" value=".." name="SiteExplorer" style="padding-top:5px;" />
                                        <asp:HiddenField ID="altUsrNameHidden" runat="server" />                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:30%;padding-left:20px;text-align:left;height:25px;"  class="lefttdbg" >

                                    </td>
                                    <td style="width:70%;padding-left:10px;height:25px;" colspan="3"  class="righttdbg">
                                        <asp:Button ID="buttonListing" CssClass="inputbutton" runat="server" Text="Test" Enabled="false" OnClick="ButtonListing_Click"  />    
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left:20px;width:30%;height:10px;" colspan="4" class="lefttdbg">
                                         <span class="subtitle">
                                            <%= altActor_Label_Period %>
                                            </span></td>
                                </tr>
                                <tr>
                                    <td style="text-align:left;padding-left:20px;height:25px;" class="lefttdbg">
                                        <asp:Label ID="lblFromText" runat="server"  CssClass="subtitle"> <%= altActor_Label_From %></asp:Label>
                                    </td>
                                    <td class="righttdbg" style="padding-left:10px;height:25px;">
                                    <asp:HiddenField runat="server" ID="firstInput"></asp:HiddenField>                                                                
                                     <telerik:RadDatePicker RenderMode="Classic" Width="125px" ID="firstInputDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">
                                    <Calendar ID="Calendar1" runat="server" Skin="AWTCalendar">
                                    </Calendar>
                                     <DateInput ToolTip="Date input" runat="server"></DateInput>
                                     </telerik:RadDatePicker>
                                    </td>
                                    <td style="text-align:left;padding-left:45px;height:25px;" class="lefttdbg">                                    
                                   <asp:Label ID="lblToText" runat="server"  CssClass="subtitle"> <%= altActor_Label_To %></asp:Label>
                                    </td>
                                    <td class="righttdbg" style="text-align:left;padding-left:2px;height:25px;">
                                    <asp:HiddenField runat="server" ID="secondInput"></asp:HiddenField>                                                               
                                     <telerik:RadDatePicker RenderMode="Classic" Width="125px" ID="secondInputDate" runat="server"   Skin="AWTCalendar" EnableEmbeddedSkins="false">
                                    <Calendar ID="Calendar2" runat="server"  Skin="AWTCalendar">
                                    </Calendar>
                                     <DateInput ToolTip="Date input" runat="server"></DateInput>
                                     </telerik:RadDatePicker>
                                    </td>
                                   </tr>
                                <tr>
                                    <td style="height:24px;text-align:right;padding:10px;" class="lefttdbg">
                                        </td>
                                    <td colspan="3" class="righttdbg" style="padding:8px;">
                                        <span class="description">
                                        <asp:CheckBox runat="server" ID="CheckBoxConsider"  CssClass="inputcheckbox" />
                                        </span>
                                    </td>
                                </tr>                               
                                
                            </table>
                           
                            
                        </td>
                    </tr> 
                    <tr>
                        <td style="width:100%;padding-left:10px;padding-right:10px;vertical-align:top;" colspan="2">
                            <div style="height:200px;overflow-y:auto;width:975px;overflow-x:hidden;border: 1px solid #ccc;">
                                    <ISWebGrid:WebGrid ID="WebGridListing" runat="server" Height="99%" Width="100%" Visible="false"                               
                                    HorizontalAlign="NotSet" ViewStateStorage="None" AllowAutoDataCaching="false" DisableFileSystemChecking="true" 
                                        EnableWebResources="never" RenderingMode="HTML5" OnPrepareDataBinding="WebGridListing_PrepareDataBinding">                              
                                            <LayoutSettings AlwaysShowHelpButton="false" PagingMode="None" AllowDelete="No"  VirtualPageSize="20" 
                                            CellClickAction="RowSelect"  UseRelativePositioning="true" PersistRowChecker="True"   AllowAddNew="No" 
                                            AlternatingColors="true" GridLineStyle="Solid"  GridLineColor="#afafaf" CellPaddingDefault="2" 
                                            RowHeightDefault="30px" AutoFitColumns="true" AutoFitColumnsBuffering="false" AllowFilter="No" AllowSorting="No"
                                            GridLines="None" ScriptDirectory="../../InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/" PromptBeforeDelete="true" ShowRefreshButton="false" 
                                            FilterBarVisible="false" RowHeaders="No">
                                            <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"></HeaderStyle>
                                            <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                            <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                                            <GroupByBox>
                                                <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                                <Style BackColor="#ececec"></Style>
                                            </GroupByBox>
                                            <FilterRowStyle CssClass="GridEditFocusCellStyle"></FilterRowStyle>
                                            <EditTextboxStyle CssClass="GridEditTextBoxStyle"></EditTextboxStyle>
                                            <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                            <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                                            <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                            <AlternatingRowStyle CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                                            <StatusBarStyle CssClass="GridStatusBarStyle">
                                                <Padding Top="0px" Left="0px" Bottom="0px" Right="0px"></Padding>
                                            </StatusBarStyle>
                                            <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">

                                            </StatusBarCommandStyle>
                                            <RowStyle  OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"  CssClass="GridRowStyle"></RowStyle>
                                            <ClientSideEvents OnRowContextMenu="OnRowContextMenu" OnInitialize="OnInitialize" />
                                            <TextSettings Language="UseCulture"></TextSettings>
                                            <LostFocusRowStyle CssClass="GridSelectedRowStyle"></LostFocusRowStyle>
                                                 <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                                ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"                                            
                                                 />
                                            </LayoutSettings>
                                            <RootTable Caption="Alternate Actors" CaptionImage="Customer.gif" GridLineStyle="NotSet">
                                                <TableHeaderStyle BackgroundImage="../../Intersoft/Grid/CommonLibrary/Images/SelectColumns.gif"
                                                    Width="100%" />
                                            </RootTable>
                                </ISWebGrid:WebGrid>
                            </div>
                        </td>
                    </tr>      
                    
                    <tr>
                        <td style="text-align:right;padding-top:10px; padding-right:20px;padding-bottom:10px;width:100%;" colspan="2">                 
                            <asp:Button ID="btnAddActorCancel" CssClass="inputsecondarybutton" runat="server"  />
                            <asp:Button ID="btnAddActor" CssClass="inputbutton" runat="server" OnClick="btnAddActor_Click" />   
                
                        </td>
                    </tr>             
                </table>
            </td>
        </tr>
        
    </table>
        
</div>
<div id="divSearchActor" runat="server">
    <table style="width:100%;height:90%;border-spacing:0px;border-collapse:separate;"   class="tablebg" >
        <tr>
            <td colspan="2" class="header" style="padding:5px;" >
            <span class="pagetitle">
                <%= altActor_pageHeader_SearchActor %>
             </span>
            </td>
        </tr>
        <tr>
            <td class="tdbg" style="width:90%;padding:5px;">
            <br />
                <table style="width:90%;margin:0px auto;border-spacing:1px;border-collapse:separate;"   class="tablebg" >
                    <tr>
                        <td class="lefttdbg" style="padding:5px;">
                             <span class="subtitle">
                                <%= altActor_Label_SearchText %>
                                : </span>
                        </td>
                    <td class="righttdbg" style="padding:5px;">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="inputtext" Width="70%"  />
                         <asp:Button ID="btnActorSearch" runat="server" Width="50" CssClass="inputbutton" OnClick="btnActorSearch_Click" />
                        </td>
                        
                       <%-- <td rowspan="3" align="center" class="lefttdbg" valign="top">
                       
                        </td>--%>
                </tr>
                <tr>
                    <td class="lefttdbg" style="padding:5px;">
                        <span class="subtitle">
                            <%= altActor_Label_SearchBy %>
                            : </span>
                    </td>
                    <td class="righttdbg">
                        <asp:RadioButtonList ID="rdoListSearchBy" runat="server" BorderStyle="None" RepeatDirection="Horizontal" CssClass="inputradio" /></td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="padding:5px;">
                       
                        <span class="subtitle">
                            <%= altActor_Label_SearchResult %>
                        </span><br />
                         <span class="errormsg">
                            <%= searcherror %>
                        </span>
                    </td>
                    <td class="righttdbg"  style="padding:5px;">
                   <div id="div1" style="height:85px;width:231px;overflow:auto">
                        <asp:ListBox ID="listBoxActors" runat="server"   CssClass="inputselect"  /></div>
                        </td>
                </tr>
            </table>
    <br />
    </td>
    </tr>
    <tr>
        <td colspan="2" style="padding-right:10px;text-align:right;" class="footer">
            <asp:Button ID="btnActorSubmit" runat="server" CssClass="inputbutton"
                Enabled="False" />
            <asp:Button ID="btnActorCancel" runat="server"  CssClass="inputbutton" />
        </td>
    </tr>
    </table>
</div>
<div id="calendarContainer" style="display: none;">

   
    <telerik:RadCalendar ID="Radcalendar2" runat="server"  EnableEmbeddedSkins="false" Skin="AWTCalendar" Width="300px" ClientEvents-OnDateSelected="ChangeInput">
     </telerik:RadCalendar>
      
    &nbsp;
    
    
</div>

 
<telerik:RadWindowManager ID="RadWindowManager2" Height="280" Width="700" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
         runat="server" BackColor="Black" Behaviors="Close, Move" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">
</telerik:RadWindowManager>


