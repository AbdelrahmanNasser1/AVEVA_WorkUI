 function trim(theString) //Remove Trailing spaces
{
	while(""+theString.charAt(theString.length-1)==" ")
		theString = theString.substring(0, theString.length-1);
	while(""+theString.charAt(0)==" ")
		theString = theString.substring(1, theString.length);
	return(theString);		  					 
}

function checkMaxLen(theString, theLen ) //Check if string is empty  
{
	if( checkIfEmpty(theString) ) return true;
	var bIsOk=false;
	if( typeof(theString) == "string" )
	{
  	  	if( trim(theString).length <= theLen ) //Remove extra spaces and check the length 
	 	bIsOk = true;
	}
	return bIsOk;
}

function ValidateTime(InputVal)
		{
			var TimeVal=InputVal
 			if (IsPosInteger(TimeVal)== false)
				{
  					return false;
				}
			if (TimeVal.indexOf(":")==-1 )
				{
  					return false;
				}
  			if ((TimeVal.length)<=10)	
 				{
  					ArrTimeVal=TimeVal.split(":")
 					for (i=0;i<ArrTimeVal.length;i++)
 						{
 							FirstVal=ArrTimeVal[0]
 							SecondVal=ArrTimeVal[1]
 							if (SecondVal.length !=2)
 								return false;
   							if (FirstVal>23)
 								{
  								return false;
 								}
   							if (SecondVal>=60)
 								{
  								return false;
 								}
  						}
  					}
 			}
function IsPosInteger(inputVal)
{
	inputStr=inputVal.toString();
	for(var i=0;i<inputStr.length;i++)
		{ 
			var oneChar=inputStr.charAt(i);
			if (oneChar != ":")
				{
					if(oneChar<"0" || oneChar>"9")
					{
						return false;
					}
				}	
		}
	return true;	
}

function IsPosDecimal(inputVal)
{
	var dotFlag = 0;
	if (inputVal.charAt((inputVal.length-1))=='.')
	{
		return false;
	}
	inputStr=inputVal.toString();
	for(var i=0;i<inputStr.length;i++)
		{ 
			var oneChar=inputStr.charAt(i);
			if (dotFlag == 1 && oneChar == ".")
			{
				return false;
			}
			
			if (oneChar != ".")
				{
					if(oneChar<"0" || oneChar>"9")
					{
						return false;
					}
				}	
			if (oneChar == ".")
			{
				dotFlag = 1;
			}
		}
	return true;	
}

function IsPosWholeNumber(inputVal)
{
	inputStr=inputVal.toString();
	for(var i=0;i<inputStr.length;i++)
	{ 
			var oneChar=inputStr.charAt(i);
				if(oneChar<"0" || oneChar>"9")
				{
					return false;
				}
	}
	return true;	
}

function IsMoney(inputVal)
{
	var count;
	count = 0;
	inputStr=inputVal.toString();
	
	
	if (inputStr.length == 1)
	{
		if (inputStr.charAt(0) == ".")
		{
			return false;
		}
	}
	for(var i=0;i<inputStr.length;i++)
	{ 
			var oneChar=inputStr.charAt(i);
		
			
		if (oneChar == ".")
		{
			count = count + 1;
		}	
		if (count > 1 )
		{
			return false;
		}
			if (oneChar !=".")	
				{
					if(oneChar<"0" || oneChar>"9")
					{
						return false;
					}
				}	
	}
	return true;	
}

function IsDay(inputVal)
{
	ArrinputVal=jtrim(inputVal).split(".")
	for(i=0;i<ArrinputVal.length;i++)
		{
 			
			if (ArrinputVal[1]<5 ||ArrinputVal[1]>5)
				{
					return false;
				}
			
		}
		
	if (IsMoney(inputVal)==false)
		{
			return false
		}
		
 }
function CheckDateDiff(StartTime,EndTime)
	{
 			 
 		ArrStartTime=jtrim(StartTime).split(":")
 			 
		for (i=0;i<ArrStartTime.length;i++)	
		{
			FStartTime=ArrStartTime[0]
 		}
 			
			
		ArrEndTime=EndTime.split(":")
		for (i=0;i<ArrEndTime.length;i++)	
		{
			TStartTime=ArrEndTime[0]
		}
		if (FStartTime>TStartTime)
			{
				alert("Start Time must be lesser then End time")
				Err=1
				return false;		
			}
		if (FStartTime==TStartTime)
			{
				alert("Start Time and End time must be different.")
 				Err=1
				return false;		
			}	
	} 
	
 

function CheckNull(theString, Label)
{
	if (jtrim(theString).length == 0 )
	{
		alert("You need to enter " + Label + ".");
		return false;
	}	
	
	return true;
}

function CheckForNull(theString)
{
	if(jtrim(theString).length == 0 )
	{
    	return false;
	}	
	else
	{
		return true;
	}
}

function CheckLength(theString, label, minlength, maxlength)
{
	stringlength = theString.length;
	
	minlength=eval(minlength);
	maxlength=eval(maxlength);
	
	
	if (stringlength >= minlength && stringlength <= maxlength )
		return true;
		
		if (minlength == 0)
		{
			alert("The length of " + label + " cannot exceed " + maxlength + ".");
			return false;
		}	
		
		if(minlength == maxlength)
		{
			alert(" The length of " + label + " should be " + minlength + ".");
			return false;
		}	
		if ((maxlength - minlength) == 1)
		{	
			alert(" The length of " + label + " should be either " + minlength + " or " + maxlength + ".");
			return false;
		}
		
		alert(" The length of " + label + " should be between " + minlength + " and " + maxlength + ".");
		return false;
}


function jtrim(str)
{
	  var i= 0;
	  var ltrimedStr = ""
	  var rtrimedStr = ""
	  l=str.length;
	  for (i=0;i<l;i++)
	  {
	  	if (str.charAt(i) != " ")
	  	break;
	  }
	  ltrimedStr = str.substring(i,l);
     k = ltrimedStr.length;	
	  for(j=k-1;j>=0;j--)
	 {
		
	   if (ltrimedStr.charAt(j)!= " ")
	    {
	  	    break;
	    }  
	 }
	   
	 rtrimedStr = ltrimedStr.substring(0,j+1);
	//	return str.substring(i,l);
	  return rtrimedStr;
}
	
function Compare(compareWith,compareString,message)
{
	if(compareWith == compareString )
		return true;
	else
	{
		if (message != "" )
			alert (message);
		return false;	
	}	
}

function rtrim(strt)
{
	var n,s,i;
	n=strt.length;
	for(i=n-1;i>=0;i--)
	{
		s=strt.charAt(i);
		if (s!=" ") 
		{
			return strt.substring(0,i+1);
		}
	}
	return "";
}


/*function checks whether the selected(CheckValue) id exists in Idstr*/
	function checkForIdExists(IdStr,CheckValue)
	{
		
		var arr = new Array()
		arr = IdStr.split(",")
		for(k=0;k<arr.length;k++)
		{
			if(parseInt(arr[k])== parseInt(CheckValue))
			{	
				return true;
			}
		}	
		return false;		
	}

// This Function Compare two dates
// If dateStr1 > dateStr2 then returns 1, If dateStr1 < dateStr2 then returns -1 If dateStr1 = dateStr2 then returns 0
// Dates should be in the format DD-MON-YEAR

function dateCompare( fromval , toval )
{

    if (fromval=="" || toval=="")
	{
	return false;
	}

	fromdate    =    new Date(fromval);    
    todate      =    new Date(toval); 

	datediff = todate - fromdate;
	//return (datediff < 0? -1:datediff=0?=:1)
	
	if (datediff < 0)
	{
		return -1 ; 
	}
	else if (datediff == 0) {
		return 0;
	}else {
		return 1;		
	}	
}

function validateDate(MonValue,DayValue,YearValue)
	{
		
		if (MonValue == 2 &&   (YearValue % 4) != 0 )
	  	{ //if feb and day selected is greater than 28 (if the year selected is not a leap year)
			if (DayValue > 28 )
			{
			  	return false;
			}
		}
		else if (MonValue == 2)
		{
			if (DayValue > 29)
			{
				return false;
			}
		}
		else if (MonValue == 4 || MonValue == 6 || MonValue==9 || MonValue ==11)
		{
			if (DayValue > 30 || DayValue <= 0)
			{
				return false;
			}
		}
		else if ((MonValue==1 || MonValue == 3 || MonValue == 5 || MonValue ==7 || MonValue==8 || MonValue == 10 || MonValue == 12) && YearValue>0)
		 {
	        if (DayValue >31 || DayValue <= 0 )
	        {
				return false;
			}    
		}
		else if (MonValue <= 0 || MonValue > 12)
		{
			return false;
		}
		
		if (YearValue.length != 4 )
		{
			return false;
		}
		return true;
	}
	
function GetMonthName(MonthNo)
{
	
	if(MonthNo==1)
		return "Jan"
	if(MonthNo==2)
		return "Feb"
	if(MonthNo==3)
		return "Mar"
	if(MonthNo==4)
		return "Apr"
	if(MonthNo==5)
		return "May"
	if(MonthNo==6)
		return "Jun"
	if(MonthNo==7)
		return "Jul"		
	if(MonthNo==8)
		return "Aug"		
	if(MonthNo==9)
		return "Sep"		
	if(MonthNo==10)
		return "Oct"		
	if(MonthNo==11)
		return "Nov"		
	if(MonthNo==12)
		return "Dec"												
	
}

function ValidateDateStr(DateVal)
{
	var dateStr = DateVal;
	if (dateStr.indexOf("/") < 1 || dateStr.lastIndexOf("/") > 5)
	{
		return false;
	}
	else
	{
		for (k=0;k<dateStr.length;k++)
		{
			var oneChar = dateStr.charAt(k);
			if (oneChar != "/")
			{
				if(oneChar < "0" || oneChar > "9" )
				{	
					return false;
				}
			}	
		}
	}
	
	var day,month,year; 
	day = dateStr.substring(0,dateStr.indexOf("/"));
	month = dateStr.substring(day.length+1,dateStr.lastIndexOf("/"));
	year = dateStr.substring(dateStr.lastIndexOf("/")+1,dateStr.length);	
	if (validateDate(month,day,year) == false)
	{
		return false;
	}
	return true;
}



// This function returns the date in the format ( eg: 1 Jan 2001)
function customdateformat(date, month, year)
	{
	var months = new Array("January", "February", "March", "April", "May", "June", "July",
	 "August", "September", "October", "November", "December");
	 var formateddate = date+' '+months[month]+' '+ year
	 return(formateddate)
	}


// function to validate for time in HH:mm(24 hr) format.
	function validate24HourTime(Lstrtime) {
		
		var LarrTime;
		LarrTime = Lstrtime.split(":");
		
		if (isNaN(LarrTime[0]) || isNaN(LarrTime[1]) ){
			// If the hour part or the minute part is not a number, it is an invalid time
			// value.
			return false;
		}else{
			// If the hour part and minute part are valid number check if they fall within
			// the respective range.. hour should be >= 0 and <=23 
			// and minute should be >=0 and <=59
			if (parseInt(LarrTime[0]) <0 ||  parseInt(LarrTime[0]) > 23 || parseInt(LarrTime[1]) <0 || parseInt(LarrTime[1]) >59 ) {
				return false;
			}else{
				// If the hour or minute value doesnt fall within the range, return false.
				return true;
			}
		}
	}


	// **********START OF VALIDATION FUNCTIONS FOR TIME FORMAT*****************
	
	// FUnction that validate the input time duration value is in HH:MM format.
	function validatetimeinHHMM(InputVal)
	{
		var TimeVal=InputVal;
 		
		if (TimeVal.indexOf(":")==-1 )
			{
  				return false;
			}
		if (IsPosInteger(TimeVal)== false)
			{
  				return false;
			}
  		
  			ArrTimeVal=TimeVal.split(":");
 			for (i=0;i<ArrTimeVal.length;i++)
 				{
 					FirstVal=ArrTimeVal[0];
 					SecondVal=ArrTimeVal[1];
 					if (SecondVal.length != 2)
 						{
 						return false;
 						}
   		//			if (FirstVal>23)
 		//				{
  		//				return false;
 		//				}
   					if (SecondVal>=60)
 						{
  						return false;
 						}
  				}
	}
	

// FUnction that validate the input time duration value is in Decimal format.
// The function consideres .1 = 6 minutes.
	function validatetimeinDEC(InputVal)
	{
		var TimeVal=InputVal
		
		if (IsPosDecimal(TimeVal)== false)
			{
  				return false;
			}
		
		if ((TimeVal.indexOf(".")==-1))
			{
				return true;
			}
		else
		{

  			ArrTimeVal=TimeVal.split(".");
  				
 			for (i=0;i<ArrTimeVal.length;i++)
 				{
 					SecondVal=ArrTimeVal[1]
   					if (SecondVal.length >2)
 						{
  						return false;
 						}
  				}
  		}
	}
	
	// **********END OF VALIDATION FUNCTIONS FOR TIME FORMAT*****************
function checkIfEmpty(theString) //Check if string is empty  
{
	var bIsOk=true;
	if( typeof(theString) == "string" )
	{
  	  	if( jtrim(theString).length > 0 ) //Remove extra spaces and check the length 
	 	bIsOk = false;
	}
	return bIsOk;
}
	
	
function CheckIfValidDate(dateStr, pattern, fieldname) 
{
	//Pattern can be MDY for month, date, year or DMY for date, month, year
	// Checks for the following valid date formats:
	// MM/DD/YY   MM/DD/YYYY   MM-DD-YY   MM-DD-YYYY
	// Also separates date into month, day, and year variables
	if( checkIfEmpty(dateStr)) return "OK";
	// To require a 2 digit year entry, use this line instead:
	//var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{2}|\d{4})$/;

	// requires a 4 digit year entry:
	var errmes;
	 var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{2,4})$/;
	
	var matchArray = dateStr.match(datePat); // is the format ok?
	if (matchArray == null)
	 {
		errmes = "- Please enter a valid date.";
		return errmes;
	 }
	if( pattern.charAt(0).toUpperCase() == "D" )
	{
		//DMY format
		day = matchArray[1]; // parse date into variables
		month = matchArray[3];
		year = matchArray[4];
	}
	else
	{
		//MDY format
		month = matchArray[1]; // parse date into variables
		day = matchArray[3];
		year = matchArray[4];	
	}
	if (month < 1 || month > 12) 
	{ 	// check month range
		errmes = "- Month must be between 1 and 12.";
		return errmes;
	}
	if (day < 1 || day > 31) 
	{
		errmes = "- Day must be between 1 and 31.";
		return errmes;
	}
	if ((month==4 || month==6 || month==9 || month==11) && day==31) 
	{
		errmes= "- Month "+month+" doesn't have 31 days!";
		return errmes;
	}
	if (month == 2) 
	{ 	// check for february 29th
		var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day>29 || (day==29 && !isleap)) 
		{
			errmes="- February " + year + " doesn't have " + day + " days!";
			return errmes;
		}
	}
return "OK";  // date is valid

}	



//FUNCTION TO VALIDATE THE EMAILID
		function validemail(emailval)
		{
        
        var tempStr,count;  //to get the count of the string entered and tempStr is to store the individual character.
        var blnmail,blnperiod; //checking for "@" and "."
        var lastoccofperiod,maxthree;
        var ampcount=0;
        var amppos;
        var servername = 1;
        var dots;
        
        count=emailval.length;
        blnperiod = 1;
        maxthree = 1;
        specialchar=0
        lastoccofperiod = 0;
        if (count==0)
        {
                return false;
        }
        
        
        //check for special characters that are not to be there in the email add
        
        for(i=0;i<count;i++)
        {
                tempStr = emailval.charAt(i);
                if ((tempStr >='a')&&(tempStr <='z'))
                {
                        specialchar=specialchar+1;
                }
                else
                {
                        if ((tempStr >='A')&&(tempStr <='Z'))
                        {
                                specialchar=specialchar+1;
                        }
                        else
                        {
                                if ((tempStr >= 0)&&(tempStr<=9))
                                {
                                        specialchar=specialchar+1;
                                }
                                else
                                {
                                        if ((tempStr=="_")||(tempStr=="-")||(tempStr==".")||(tempStr=="@"))
                                        {
                                             specialchar=specialchar+1;
                                        }
                                        else
                                        { 
											
											return false;
                                        }
                                }
                        }
                }
        }
        
        dots = emailval.indexOf("..");
        if (dots != -1)
        {
                //alert("Invalid Email");
                return false;
        }
        
        espace = emailval.indexOf(" ");
        if (espace != -1)
        {
           //     alert("Invalid Email");
                return false;
        }
        
        lastoccofperiod = emailval.lastIndexOf(".");
        if (lastoccofperiod <= 0)
        {
                blnperiod = 0;
        }
        
        if (((count - lastoccofperiod) > 4)||((count - lastoccofperiod) < 3))
        {
                maxthree = 0;
        }
        
        for(i=0;i<=count;i++)
        {
                tempStr = emailval.charAt(i)
                if (tempStr=="@")
                        ampcount=ampcount + 1;
        }
        
        
        amppos = emailval.indexOf("@");
        if (emailval.charAt(amppos+1) == ".") 
                servername = 0;
                
        //checking whether the "@" sign is the last one
        if (count - emailval.charAt(amppos)< 5)
                servername = 0;
                
        if ((ampcount==1)&&(blnperiod==1)&&(maxthree==1)&&(servername==1))
        {
                blnmail=1;
        }
        else
        {
                blnmail=0;
        }
        
       
        if (blnmail==0)
        {
             
				return false;
        }
		else
		{
			return true;
		}
}

function redirecter(passval,objForm,navigationType)
	{
		//alert(objForm.action)
		objForm.action = passval;
		objForm.NavigationType.value = navigationType;
		objForm.hidPagingval.value = 1;
		objForm.submit();
		//location.href=passval
	}
	function OpenNewWin(Passval,OpenWin,ActId)
	{
		if(Passval == -1)
		{
			window.open ('?DisplayType=SaveSearchList',"EditSearchList","height=350,width=500,resizable=yes");
		}
		if(OpenWin == 1)
		{
			window.open ('?DisplayType=ADDSETCOLUMNS',"SetColumns","height=430,width=500,resizable=yes");
		}
		if(OpenWin == 2)
		{
			window.open ('?DisplayType=ResourceCalendar',"ResourceCalendar","height=390,width=600,resizable=yes");
		}
		if(OpenWin == 3)
		{
			window.open ('?DisplayType=AlternateResource',"AlternateResource","height=280,width=680,resizable=yes");
		}		
	}
	
	function submitForm(objFrm)
	{
		objFrm.submit()
	}
	
function RefreshParent(subFlag)

      {

            //alert(subFlag)

            //return false;

            if(subFlag == 1)

            {

                  self.opener.location.href = self.opener.location.href

            }     

            else if (subFlag == 2)

            {

                  var str = location.href

                  location.href = str

                  

            }

            else if (subFlag == 3)

            {

                  if(typeof(self.opener) != 'undefined')

                  {

                        if(typeof(self.opener.document)== 'object' && typeof(self.opener.document.getElementsByTagName("input")["datecorrectionfactor"])=='object')

                        {

                              var str = self.opener.location.href

                              str = str.replace("ActivityId","")

                              str = str.replace("rowcount","")

                              self.opener.location.href=str;

                              //alert('Successfully Submitted.');

                              window.close();

                        }

                        else

                        {

                              var str = location.href

                              str = str.replace("ActivityId","")

                              str = str.replace("rowcount","")                

                              location.href = str

                        }

                  }

                  else

                  {

                        var str = location.href

                        str = str.replace("ActivityId","")

                        str = str.replace("rowcount","")                

                        location.href = str

                  }

            }//gets called after activity is forwarded.

            else if (subFlag == 4)

            {

                  //If activitui opened in a seperate page then refresh the parent page

                  if(typeof(self.opener.document)== 'object')

                  {

                        if(typeof(self.opener.document.getElementsByTagName("input")["datecorrectionfactor"])=='undefined')

                        {

                              self.parent.location.href = self.parent.location.href;                  

 

                        }

                        else

                        {

                              //If activitui opened in a same page then refresh the parent page

                              var str = self.opener.location.href

                              str = str.replace("ActivityId","")

                              str = str.replace("rowcount","")

                              self.opener.location.href=str;

                        }

                  }

                  else

                  {

                        //If activitui opened in a same page then refresh the parent page

                        var str = self.opener.location.href

                        str = str.replace("ActivityId","")

                        str = str.replace("rowcount","")

                        self.opener.location.href=str;

                                          

                  }

            }

            else if (subFlag == 5)

            {

                  if(typeof(self.opener) != 'undefined')                

                  {

                        if(typeof(self.opener.document)== 'object' && typeof(self.opener.document.getElementsByTagName("input")["datecorrectionfactor"])=='object')

                        {

                              var str = self.opener.location.href

                              str = str.replace("ActivityId","")

                              str = str.replace("rowcount","")

                              self.opener.location.href=str;                        

                              //alert('Successfully Submitted.');

                              window.close();

                        }

                        else

                        {

                              var str = self.parent.location.href

                              str = str.replace("ActivityId","")

                              str = str.replace("rowcount","")

                              self.parent.location.href = str

                        }

                  }

                  else

                  {

                        var str = self.parent.location.href

                        str = str.replace("ActivityId","")

                        str = str.replace("rowcount","")

                        self.parent.location.href = str

                  }                 

            }

            else if (subFlag == 6)

            {

                  if(typeof(self.opener) != 'undefined' && typeof(self.opener.document.getElementsByTagName("input")["datecorrectionfactor"])=='object')

                  {

                        var str = self.opener.location.href

                        self.opener.location.href=str;            

                        //alert('Successfully Submitted.');                   

                  }

                  else

                  {

                        var str = self.parent.location.href

                        self.parent.location.href = str

                  }                 

            }

      }

	
	
	
	function ShowDetailedWindow()
	{
			if (document.layers)
			{
				obj = document.layers["div1"]
				obj2= document.layers["div2"] 
				obj.visibility = "visible" ;
				obj2.visibility = "hidden" ;
			}
			else
			{
				if (navigator.userAgent.indexOf("Netscape") > 0 )
				{
					document.all = document.getElementsByTagName("*");
				}
				obj = document.all["div1"]
				obj.style.visibility = "visible" ;
				obj2 = document.all["div2"]
				obj2.style.visibility = "hidden" ;
			}
			
	}
	function CloseDetailedWindow()
	{
			if (document.layers)
			{
				obj = document.layers["div1"]
				//obj2= document.layers["div2"] 
				obj.visibility = "hidden" ;
				//obj2.visibility = "visible" ;
			}
			else
			{
				if (navigator.userAgent.indexOf("Netscape") > 0 )
				{
					document.all = document.getElementsByTagName("*");
				}
				obj = document.all["div1"]
				obj.style.visibility = "hidden" ;
				//obj2 = document.all["div2"]
				//obj2.style.visibility = "visible" ;
				
				
			}
			
	}
	
	function loadcontent(src,pageview)
	{
		if(pageview == "Seperate")
		{
			//Open in new window if the view property is set
			window.open (src +"&DisplayType=SEPERATEVIEW","ActivityView","height=375,width=780,resizable=yes,scrollbars=yes");
		}
		else if(pageview == "NewPage")
		{
			location.href=src
		}
		else
		{
			var obj = document.getElementsByTagName("input")["datecorrectionfactor"].form
			obj.action = src;
			if (location.href.indexOf("adv=1") > 0 )
				document.getElementsByTagName("input")["hidPagingval"].value = 1;
			else
				document.getElementsByTagName("input")["hidPagingval"].value = 0;
			obj.submit();
		}		
			
			
	}
	function SubmitPage(objFrm,ExecutionDetailsId,RowCount)
	{
			objFrm.hidExecutionDetailsId.value = ExecutionDetailsId;
			objFrm.hidRowCount.value = RowCount;
			objFrm.submit();
					
	}
	function opencontentinnewwindow()
	{
		var myframe;
		myframe = eval("contentframe");
		window.open (myframe.location,"ActivitiesContent","height=400,width=700,resizable=yes");
	}
	
	function validateForm(pagename)
	{
		
		
		var ObjFromMth = document.getElementsByTagName("select")["selMonthFrm"]
		var ObjFromDay = document.getElementsByTagName("select")["selDayFrm"]
		var ObjFromYear = document.getElementsByTagName("select")["selYearFrm"]
		
		FromMth = ObjFromMth[ObjFromMth.selectedIndex].value 
		FromDay = ObjFromDay[ObjFromDay.selectedIndex].value 
		FromYear = ObjFromYear[ObjFromYear.selectedIndex].value
		
		if (FromMth != "0" || FromDay != "0" || FromYear != "0" )
		{
			if (FromMth < 10)
			{
				FromMth = "0"+FromMth
			}
			if (FromDay < 10)
			{
				FromDay = "0"+FromDay
			}
			if (CheckIfValidDate(FromMth +"-"+ FromDay +"-"+ FromYear ,"MM-DD-YY","FromDate") != "OK")
			{
				alert(CheckIfValidDate(FromMth +"-"+ FromDay +"-"+ FromYear,"MM-DD-YY","FromDate"))
				return false;
			}
		}
		
		var ObjToMth = document.getElementsByTagName("select")["selMonthTo"]
		var ObjToDay = document.getElementsByTagName("select")["selDayTo"]
		var ObjToYear = document.getElementsByTagName("select")["selYearTo"]
		
		ToMth = ObjToMth[ObjToMth.selectedIndex].value 
		ToDay = ObjToDay[ObjToDay.selectedIndex].value 
		ToYear = ObjToYear[ObjToYear.selectedIndex].value
		
		
		if(ToMth != "0" || ToDay != "0" || ToYear != "0" )
		{	
			if (ToMth < 10)
			{
				ToMth = "0"+ToMth
			}
			if (ToDay < 10)
			{
				ToDay = "0"+ToDay
			}
			if (CheckIfValidDate(ToMth +"-"+ ToDay +"-"+ ToYear ,"MM-DD-YY","FromDate") != "OK")
			{
				alert(CheckIfValidDate(ToMth +"-"+ ToDay +"-"+ ToYear,"MM-DD-YY","FromDate"))
				return false;
			}
		}
		document.getElementsByTagName("input")["datecorrectionfactor"].form.action = pagename;
	}
	function validateReportForm(objform)
	{
		
		
		FromMth = objform.selMonthFrm[objform.selMonthFrm.selectedIndex].value 
		FromDay = objform.selDayFrm[objform.selDayFrm.selectedIndex].value 
		FromYear = objform.selYearFrm[objform.selYearFrm.selectedIndex].value
		
		if (FromMth != "0" || FromDay != "0" || FromYear != "0" )
		{
			if (FromMth < 10)
			{
				FromMth = "0"+FromMth
			}
			if (FromDay < 10)
			{
				FromDay = "0"+FromDay
			}
			if (CheckIfValidDate(FromMth +"-"+ FromDay +"-"+ FromYear ,"MM-DD-YY","FromDate") != "OK")
			{
				alert(CheckIfValidDate(FromMth +"-"+ FromDay +"-"+ FromYear,"MM-DD-YY","FromDate"))
				return false;
			}
		}
		
		ToMth = objform.selMonthTo[objform.selMonthTo.selectedIndex].value 
		ToDay = objform.selDayTo[objform.selDayTo.selectedIndex].value 
		ToYear = objform.selYearTo[objform.selYearTo.selectedIndex].value
		
		
		if(ToMth != "0" || ToDay != "0" || ToYear != "0" )
		{	
			if (ToMth < 10)
			{
				ToMth = "0"+ToMth
			}
			if (ToDay < 10)
			{
				ToDay = "0"+ToDay
			}
			if (CheckIfValidDate(ToMth +"-"+ ToDay +"-"+ ToYear ,"MM-DD-YY","FromDate") != "OK")
			{
				alert(CheckIfValidDate(ToMth +"-"+ ToDay +"-"+ ToYear,"MM-DD-YY","FromDate"))
				return false;
			}
		}
		
	}
	
	function Validate(objForm)
	{
		
		
		if(trim(objForm.TxtShiftName.value) == '')
			{
				alert('Please enter Organization Shift Description');
				objForm.TxtShiftName.focus();
				ConvertTimeToUTC(objForm);
				return false;
			} 
		else 
		{
			return ConvertTimeToUTC(objForm);
		}
		
	}
	function ConvertTimeToUTC(objForm)
	{
		
		var start_time_arr = new Array()
		var end_time_arr = new Array()
		
		fromtime = objForm.selFromTime.value
		ToTime = objForm.selToTime.value
		//alert(fromtime);
		//alert(ToTime);
		start_time_arr = fromtime.split(":")
		end_time_arr = ToTime.split(":")
		
		if(start_time_arr[0] > 13 && end_time_arr[0] < 13)
		{
			
		}
		else
		{
			if(fromtime > ToTime)
			{
				alert('Please enter valid shift Details')
				return false;
			
			}
		}		
		var FromTime_UTC =  new Array()
		var ToTime_UTC =  new Array()
		FromTime_UTC = getUTC(1900,1,1,start_time_arr[0],start_time_arr[1])
		ToTime_UTC =  getUTC(1900,1,1,end_time_arr[0],end_time_arr[1])
		
		//Utc Time 
		objForm.UTCFromTime.value =  FromTime_UTC[3] +":"+ FromTime_UTC[4]
		objForm.UTCToTime.value =  ToTime_UTC[3] +":"+ ToTime_UTC[4]
		
		//alert(objForm.UTCFromTime.value)
		//alert(objForm.UTCToTime.value)
		return true;
		
	}
	
	//AssignDate_UTC1= get_UTCDate(AssignedOnDate1)
	//alert(AssignDate_UTC1[2])
	//alert(AssignDate_UTC1[1])
	//alert(cutoffutcval(convertutctoclientdate(AssignDate_UTC[2])))

// This function returns an array which contain the UTC value for
// the given date parameters.

function getUTC(cyear,cmonth,cday,chour,cmin)
{ 
	var newdate = new Date(cyear,cmonth,cday,chour,cmin)
	var Ret_arr =  new Array()
	// Getting UTC values and append them to an array
	
	Ret_arr[0]= newdate.getUTCMonth()
	Ret_arr[1]= newdate.getUTCDate()
	Ret_arr[2]= newdate.getUTCFullYear()
	Ret_arr[3]= Appendzero(newdate.getUTCHours())
	Ret_arr[4]= Appendzero(newdate.getUTCMinutes())	
	// Array is returned.
	return  Ret_arr;
	
}

//alert(UTCTimeDemo())
function UTCTimeDemo()
{
   var d, s = "Current Universal Coordinated Time (UTC) is: ";
   var c = ":";
   d = new Date();
   s += d.getUTCHours() + c;
   s += d.getUTCMinutes() + c;
   s += d.getUTCSeconds() + c;
   s += d.getUTCMilliseconds();
   return(s);
}

function Appendzero(val)
	{
		if(val < 10 && val >= 0)
		{
			val = "0"+val
		}
		return val;
	}
	
	
function convertutctoclientdate(utcdatetime)
{
	//alert( "inside function" + utcdatetime );
	//return false;
	if (utcdatetime=='') return '';
	var d1 = new Date()

	var strtemp
	//getTimezoneOffset gives the Time Difference in Minutes
	if (d1.getTimezoneOffset()<=0)
		sign=1
	else
		sign=-1
	offsettime=Math.abs(d1.getTimezoneOffset())

	//Hours
	offsettime2=offsettime/60

	strtemp=offsettime2.toString()
	strtemp2=""
	strtemp2=strtemp.split(".")
	if (strtemp2.length>0)
		offsethrs=eval(strtemp2[0])	
	else
		offsethrs=eval(strtemp)

	offsethrs=sign*offsethrs

	//Minutes
	offsetmins=sign*(offsettime%60)

	var d2 = new Date(utcdatetime)
	d2.setHours(d2.getHours()+offsethrs)	
	d2.setMinutes(d2.getMinutes()+offsetmins)
	formatstring(d2.getMinutes(),2);

	return d2
}

//function to cutoff the 'UTC' string from date string
function cutoffutcval(getval)
{
														
	var timeVal="";
	timeVal=""+getval
	var UTCpos;
	//get the postions for cutting off
	UTCpos= timeVal.indexOf('UTC')
	newtimeStamp = trim(timeVal.substr(0,UTCpos))
	SpacePos = newtimeStamp.lastIndexOf(" ");
	return newtimeStamp.substr(SpacePos,newtimeStamp.length);
		
}
function formatstring(strtemp,n)
{
	var s,s2,i;
	s=strtemp.toString()
	s2='';
	if (s.length<n)
	{
		for(i=1;i<=n-s.length;i++)
		s2=s2+'0';
	}
	return (s2+s)
}
//For time display, set the DisplayType as 0 and for Date and time it's 1
function WriteClientTime(TimeVal,DisplayType)
{
			var writeTime = convertutctoclientdate(TimeVal)
			TodaysDate =  new Date();
			
			var assigneddate = writeTime.getDate() +"/"+ writeTime.getMonth()+ 1 +"/"+ writeTime.getFullYear();
			var TodaysDateValue = TodaysDate.getDate() +"/"+ TodaysDate.getMonth()+ 1 +"/"+ TodaysDate.getFullYear();
			var dn="AM" 
			hours  = writeTime.getHours();
			minutes = writeTime.getMinutes();
			seconds = writeTime.getSeconds();
			if (hours >= 12)
			{
				dn="PM"
				hours=hours-12
			//this is so the hours written out is 
			//in 12-hour format, instead of the default //24-hour format.
			}
			if (hours == 0 )
					hours = 12
			//this is so the hours written out 
			//when hours=0 (meaning 12a.m) is 12
			if (minutes <= 9)
				minutes="0"+ minutes
			if (seconds <= 9)
				seconds="0"+ seconds		
			var assignedtime = hours +":"+ minutes +":"+ seconds +" "+ dn ;
			if (DisplayType == 0)
			{
				document.write(assignedtime)
			}		
			else
			{
				
				
				//document.write(writeTime.getHours())
				if (TodaysDateValue == assigneddate)
				{
					//document.write(writeTime.toLocaleTimeString())
					document.write(assignedtime)
				}
				else
				{
					
					if (TodaysDate.getFullYear() == writeTime.getFullYear())
					{
						document.write(GetMonthName(writeTime.getMonth()+ 1) +"-"+ writeTime.getDate() +", "+ assignedtime)
					}
					else
					{
						document.write(writeTime.getDate() +"-"+ GetMonthName(writeTime.getMonth()+ 1) +"-"+ writeTime.getFullYear() +", "+ assignedtime )
					}
				}
			 }
	
	/*if (DisplayType == 0)
	{
		document.write(writeTime.toLocaleTimeString())
	}		
	else
	{
		
		TodaysDate =  new Date();
		if (writeTime.toDateString() == TodaysDate.toDateString())
		{
			document.write(writeTime.toLocaleTimeString())
		}
		else
		{
			
			if (TodaysDate.getFullYear() == writeTime.getFullYear())
			{
				document.write(GetMonthName(writeTime.getMonth()+ 1) +" - "+ writeTime.getDate() +" , "+ writeTime.toLocaleTimeString())
			}
			else
			{
				document.write(writeTime.getDate() +"-"+ GetMonthName(writeTime.getMonth()+ 1) +"-"+ writeTime.getFullYear() +" , "+ writeTime.toLocaleTimeString() )
			}
			
			
		}		
		
	}*/
	
}
function ValidateChecklist(objform)
{
	var mandfileds = objform.mandatoryQuestions.value ;
	filedArray = mandfileds.split(';');
	for(k=0;k<filedArray.length;k++)
	{
		
		//alert(filedArray[k])
		fieldtype = filedArray[k].split('#');
		if(fieldtype[1] == "dropdown")
		{
			tempobj = eval("objform." + fieldtype[0])
			value = tempobj[tempobj.selectedIndex].value
			if(value =="" )
			{
				alert('Please select any one of the Options for fields marked as * , entry not found for '+ fieldtype[2])
				eval("objform."+ fieldtype[0] +".focus()")
				return false;	
			}
		}
		else if(fieldtype[1] == "dropdown" || fieldtype[1] == "checkbox" || fieldtype[1] == "radio")
		{
			
			if(isNaN(eval("objform."+ fieldtype[0] +".length")))
			{
				//If single check box or drop down
				if(!(eval("objform."+ fieldtype[0] +".checked")))
				{
					alert('Please select any one of the Options for fields marked as * , Option not selected for '+ fieldtype[2])
					return false;
				}				
			}
			else 
			{
				//If multiple check box or drop down
				var notcheckval = true;
				for(l=0;l < eval("objform."+ fieldtype[0] +".length") ;l++)	
				{
					temp = eval("objform."+ fieldtype[0])
					if(temp[l].checked)
					{
						notcheckval = false;
						break;	
					}
				}
				if(notcheckval)
				{
					alert('Please select any one of the Options for fields marked as * , Option not selected for '+ fieldtype[2]);
					return false;
				}
				
			}
			
		}
		else if(fieldtype[1] == "textbox")
		{
			if(trim(eval("objform."+ fieldtype[0]+".value")) =="")
			{
				alert('Please enter value for fields marked as * , entry not found for '+ fieldtype[2])
				eval("objform."+ fieldtype[0] +".focus()")
				return false;
			}
		}	
		else if(fieldtype[1] == "memo")
				{
					if(trim(eval("objform."+ fieldtype[0]+".value")) =="")
					{
						alert('Please enter value for fields marked as * , entry not found for '+ fieldtype[2])
						eval("objform."+ fieldtype[0] +".focus()")
						return false;
					}
		}	
	}	
	
}
		//Returns the current offset for the resource
		function GetUTCOffSet()
		{
			d1 = new Date()
			var strtemp
			//getTimezoneOffset gives the Time Difference in Minutes
			offsettime=Math.abs(d1.getTimezoneOffset())

			//Hours
			offsettime2=offsettime/60

			strtemp=offsettime2.toString()
			strtemp2=""
			strtemp2=strtemp.split(".")
			if (strtemp2.length>0)
				offsethrs=eval(strtemp2[0])
			else
				offsethrs=eval(strtemp)

			offsethrs=offsethrs

			//Minutes
			offsetmins=(offsettime%60)
			if (d1.getTimezoneOffset()<=0)
				return  "-00."+ offsethrs +":"+ offsetmins +":00"
			else
				return  "00."+ offsethrs +":"+ offsetmins +":00"

	}
function openActivityUINewWindow(OpenWin,execid,actid,application,workflowname)
	{
		//alert(OpenWin)
		var myframe;
		if(OpenWin ==1)
		{
			window.open ('?DisplayType=ForwardActivity&ActivityId='+ actid +'&application='+ application +'&workflow='+ workflowname +'',"ForwardActivity","height=500,width=700,resizable=yes");			
		}
		if(OpenWin == 2)
		{
			window.open ('?DisplayType=RESOURCELIST&ExecDetailsid='+ execid +'&ActivityId='+ actid +'&application='+ application +'&workflow='+ workflowname ,"ResourcesList","height=400,width=700,resizable=yes");
		}		
		
	}
function selected(oRow,mycol){ oRow.className='N-ListBGCOLORCOLSELECTED'; }
function deselected(oRow, mycol) { oRow.className = mycol; }
function OpenDownloadPage(uri) {
    var rawurl = window.location.href;
    var queryEnd = rawurl.indexOf("/Default/");
    if (queryEnd > 0) {
        var finalUrl = rawurl.slice(0, queryEnd + 9);

        var w, h;
        if (document.all || document.layers) {
            w = screen.availWidth;
            h = screen.availHeight;
        }
        winHeight = (h * 15 / 100);
        winWidth = (w * 25 / 100);

        var randomnumber = Math.floor(Math.random() * 100000);
        var date = new Date();
        var ticks = date.getTime();

        var builtUrl = '';
        builtUrl = finalUrl + "SkeltaForms/" + uri + "&radrandomcache=" + randomnumber + ticks;

        var downloadwin = window.open(builtUrl, 'DownloadFile', 'height=' + winHeight + ',width=' + winWidth, 'recal');
        return downloadwin;
    }
}
	
