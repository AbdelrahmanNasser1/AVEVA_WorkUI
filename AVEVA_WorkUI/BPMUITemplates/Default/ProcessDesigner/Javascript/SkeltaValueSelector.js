// JScript File
var divOpened=0;
var selectedId = 0;
 var pvrsCtrlID="";
 var defaultInputCtrlForTreeView="cmbLHS_Input";
 var defaultImageCtrlForTreeView="cmbLHS_Image";
        function ValueType(CtrlId)
        {
          this.ID=CtrlId;
        }        
//****************************************************** 
        function changeDiv(divname, divvar)
		{
//alert(divname+" , "+divvar);
			oexpr2 = document.getElementById(divname);	
				
			oexpr2.innerHTML = eval(divvar);
			if(document.getElementById("IframeShim")!=null)
			    document.getElementById("IframeShim").style.visibility = "hidden";
			
		}
		
		function ReplaceString(xpath)
		{

		  xpath = xpath.replace('$','.')

		  var l = xpath.length;

		  for (var i=0; i<l; i++)
		  {
			var ch = xpath.charAt(i);

			if(ch=='$')
			{

				xpath = xpath.replace(ch,'.')
			}
		  }
		  return xpath;
		}
		
		function changeDivforXmlVarible(divname, divvar,controlId)
		{
		  	oexpr2 = document.getElementById(divname);	
           
			var innerHtml ="<table width=100% border=0 cellspacing=0 cellpadding=0><tr><td width=15% valign=middle>"+eval(divvar)+"</td>";
			var imgs = "";
			
			if(CmbDIR_IMAGES =="")
			{
			    imgs = "../../Common/Images/down-arrowLatest.gif";
			    CmbIMG_PLUS    =   "../../Common/Images/btnPlus.gif";
                CmbIMG_MINUS   =   "../../Common/Images/btnMinus.gif";
                CmbangleImage = CmbDIR_IMAGES+"angle.gif";
                CmbMenuGif = CmbDIR_IMAGES+"9.gif";
                CmbimgPlus.src = CmbIMG_PLUS;
                CmbimgMinus.src = CmbIMG_MINUS;
			}
			else
			    imgs = CmbDIR_IMAGES+"down-arrowLatest.gif";    
			  
			//alert(controlId);
			//alert(window.innerWidth);
			var xmlVarDrDwnWdth = 150;
			if (controlId.toLowerCase().indexOf("webapioutputsavein") > -1)
			{
			    xmlVarDrDwnWdth = GetXmlVarDropDownWidth();
			}
			//alert(xmlVarDrDwnWdth);
			innerHtml += "<td style='text-align:Left;'><input value=\"\" class=\"inputselect\" id=\"" + defaultInputCtrlForTreeView + controlId + "\" name=\"" + defaultInputCtrlForTreeView + controlId;
			innerHtml += "\"  style=\"width:" + xmlVarDrDwnWdth + "px;\"";
			innerHtml += " onclick=\"ToggleTreeView('" + controlId + "')\" onmouseenter=\"javascript:ShowAlttext(this)\"  onkeydown=\"javascript:HideAlttext(this)\" onmousedown=\"javascript:HideAlttext(this)\" onmouseleave=\"javascript:HideAlttext(this)\" onmouseout=\"javascript:HideAlttext(this)\" onfocusout=\"javascript:HideAlttext(this)\"/></td><td><img alt=\"\" id=\"" + defaultImageCtrlForTreeView + controlId + "\" style=\"visibility:hidden\" src=\"" + imgs + "\" class=\"ComboBoxImageNew\" onclick=\"ToggleTreeView('" + controlId + "')\"/></td>";
			  //commented to remove the hard coded control id  
			//innerHtml+=   "<td><input value=\"\" class=\"ComboBoxInputNew\" id=\"cmbLHS_Input"+controlId+"\" name=\"cmbLHS_Input"+controlId+"\"  style=\"width:150px;\" onclick=\"ToggleTreeView('"+controlId+"')\" onmouseenter=\"javascript:ShowAlttext(this)\"  onkeydown=\"javascript:HideAlttext(this)\" onmousedown=\"javascript:HideAlttext(this)\" onmouseleave=\"javascript:HideAlttext(this)\" onmouseout=\"javascript:HideAlttext(this)\" onfocusout=\"javascript:HideAlttext(this)\"/></td><td><img alt=\"\" id=\"cmbLHS_Image"+controlId+"\" src=\""+imgs+"\" class=\"ComboBoxImageNew\" onclick=\"ToggleTreeView('"+controlId+"')\"/></td>";
			//innerHtml+=   "<div id=\"treeDiv" style=\"position:absolute; visibility: hidden; border: solid 1px; width:164px; background: white; height: 150px;overflow:auto\"></div>";
            innerHtml+="</td></tr></table>";
           
    		oexpr2.innerHTML = innerHtml;
			
			if(document.getElementById("IframeShim")!=null)
			        document.getElementById("IframeShim").style.visibility = "hidden";
			
			var selectCtrl = document.getElementById("valueinput"+controlId);
			OnChangeVaraiable(controlId,selectCtrl);
		}

		function GetXmlVarDropDownWidth()
		{
		    var widthPercent = 34;
		    var windowWidth = window.innerWidth;
		    //if (windowWidth > 500)
		    //    widthPercent = 50;
		    //alert(windowWidth);
		    var drWidth = window.innerWidth * widthPercent / 100
		    return drWidth;
		}
		
		function OnChangeVaraiable(controlId,selectCtrl)
		{
		    var selectedvar = selectCtrl.value;
		    document.getElementById(defaultInputCtrlForTreeView+controlId).value="";
		    //Commented to remove the hard coded value of cmbLHS_Input for reusing in another pages
		  //  document.getElementById("cmbLHS_Input"+controlId).value="";
		    //var divName = "treeDiv"+controlId;
		    
		   // document.getElementById(divName).innerHTML = "";
		   /* if(selectedvar!="")
		    {
		    
		    if(CmbDIR_IMAGES =="")
			{
			    imgs = "../../Common/Images/down-arrowLatest.gif";
			    CmbIMG_PLUS    =   "../../Common/Images/btnPlus.gif";
                CmbIMG_MINUS   =   "../../Common/Images/btnMinus.gif";
                CmbangleImage = CmbDIR_IMAGES+"angle.gif";
                CmbMenuGif = CmbDIR_IMAGES+"9.gif";
                CmbimgPlus.src = CmbIMG_PLUS;
                CmbimgMinus.src = CmbIMG_MINUS;
			}
			else
			    imgs = CmbDIR_IMAGES+"down-arrowLatest.gif";  
			      
			    document.getElementById("cmbLHS_Input"+controlId).value="";
		        
		        if(varcount==0)
		        {
		            eval("obj"+selectedvar).buildDOM(divName);
		            CmbobjLocalTree = eval("obj"+selectedvar);
                    var strInnerHTML = document.getElementById(divName).innerHTML;
                    document.getElementById(divName).innerHTML = strInnerHTML.replace("<DIV><DIV>",""); 
                }
                varcount = parseInt(varcount)+1;
            }*/
		}


		function ToggleTreeView(controlID) {
            //if(document.getElementById("treeDiv")!=null)
			  //  document.getElementById("treeDiv").style.visibility = "hidden";
			HideAlttext(controlID);
			if (document.getElementById("treeDiv").style.visibility == "visible") {
			    HideTreeView(controlID);
			}
			else {
			    ShowTreeView(controlID);
			    Maximize(true, "treeDiv");
			}
        }
		
		
		function windowmouseclickhandler(e)
        {
            if( !e ) e=event;   
           // if(divOpened==1)
                //alert(divOpened);         
        }	


		
		
		
		function ShowTreeView(controlID)
        {
            var iframeObj=document.getElementById("IframeShim");
            
	        var divControlObj = document.getElementById("treeDiv");	 
	       
	        var inputObj = document.getElementById(defaultInputCtrlForTreeView+controlID); 
	        //Commented to remove the hard coded value of cmbLHS_Input for reusing in another pages      
//	        var inputObj = document.getElementById("cmbLHS_Input"+controlID);
            
            var scrollLeft = 0;

            if(document.getElementById("divWhere")!=null)
            {
                scrollLeft=document.getElementById("divWhere").scrollLeft;
            }	        	        
	        
	        var x = findPosX(inputObj)-scrollLeft;
	        var y = findPosY(inputObj);
	        
	        iframeObj.style.visibility = "visible";
	        divControlObj.style.visibility = "visible";
	        divControlObj.style.display="block"; 
	        divControlObj.style.position="absolute";
        	
        	divControlObj.style.left = x + "px";
        	
        	if(document.body.offsetHeight< parseInt(divControlObj.offsetHeight + y))
        	{
        	    divControlObj.style.top  = parseInt(y - divControlObj.offsetHeight)+ "px";    
        	}
        	else
        	    divControlObj.style.top  = parseInt(y+18)+ "px";  
        	
        	
            var varname ="";
            //Handled existence
            if(document.getElementById("valueinput"+controlID)!=null)
                varname = document.getElementById("valueinput"+controlID).value;
	        
	        divName = "treeDiv";
	         if(CmbDIR_IMAGES =="")
			{
			    imgs = "../../Common/Images/down-arrowLatest.gif";
			    CmbIMG_PLUS    =   "../../Common/Images/btnPlus.gif";
                CmbIMG_MINUS   =   "../../Common/Images/btnMinus.gif";
                CmbangleImage = CmbDIR_IMAGES+"angle.gif";
                CmbMenuGif = CmbDIR_IMAGES+"9.gif";
                CmbimgPlus.src = CmbIMG_PLUS;
                CmbimgMinus.src = CmbIMG_MINUS;
			}
			else
			    imgs = CmbDIR_IMAGES+"down-arrowLatest.gif";  
			    //if(eval("var"+varname)==0)
		        //{
		            if(varname!="")
		            {
	                    document.getElementById(divName).innerHTML="";
	                    eval("obj"+varname).buildDOM(divName);
	                    eval("obj"+varname).AssignObject(eval("obj"+varname));
	                    var strInnerHTML = document.getElementById(divName).innerHTML;
                        document.getElementById(divName).innerHTML = strInnerHTML.replace("<DIV><DIV>",""); 
                        eval("var"+varname+"=1");
                    }
                //}    
                
	        divControlObj.style.zIndex="100";
	        iframeObj.style.width = divControlObj.offsetWidth ;  
	        iframeObj.style.height = divControlObj.offsetHeight ;
	        iframeObj.style.top = divControlObj.style.top;
	        iframeObj.style.left = divControlObj.style.left;
	        iframeObj.style.zIndex = divControlObj.style.zIndex - 1;
	        iframeObj.style.display = "block";
	        divOpened=1; 
	          
	        selectedId =controlID; 
	           	  if(document.getElementById("Max"+controlID)!=null)
							        {

							        	hrefText="<A href=\"#\" onclick=\"Maximize(true,'"+ "treeDiv"+controlID +"')\">";
							        	document.getElementById("Max"+controlID).innerHTML= hrefText+ "<span style=\"font-family:verdana; font-size:7pt; text-decoration:none;\">"+"Maximize"+"</span></a>";
				        }
	        
	        
        }	

        function HideTreeView(controlID)
        {
            //var Div=document.getElementById("treeDiv");
            Maximize(false,"treeDiv");
	    document.getElementById("treeDiv").style.display="none";
	        document.getElementById("treeDiv").style.visibility = "hidden";
	        document.getElementById("IframeShim").style.visibility = "hidden";
	        
        }
        
        
       function LoadTreeview(datatype,nodetext,xpath)
		{
        	var nodeText = "XmlVariables"+"."+document.getElementById("valueinput"+selectedId).value+ ReplaceString(xpath.replace('$$','.'));

			selectedvariableText = nodeText;
			
			Maximize(false, "treeDiv");
			document.getElementById("treeDiv").style.display="none";
			document.getElementById("treeDiv").style.visibility = "hidden";
			
			document.getElementById(defaultInputCtrlForTreeView+selectedId).value = selectedvariableText;
			//Commented to remove the hardcoded text
//			document.getElementById("cmbLHS_Input"+selectedId).value = selectedvariableText;
			
			document.getElementById("IframeShim").style.visibility = "hidden";
			
			var strExpr=GetFormatedString("XmlVariable");
			strExpr+=GetFormatedString(document.getElementById(defaultInputCtrlForTreeView+selectedId).value);
			//Commented to remove the hardcoded text
//		    strExpr+=GetFormatedString(document.getElementById("cmbLHS_Input"+selectedId).value);
		    document.getElementById(selectedId+"_hValue").value=strExpr;
		}

        function Select_onclick(selectname,divname,sCtrlID)        
		{
            if(document.getElementById("IframeShim")!=null)
			    document.getElementById("IframeShim").style.visibility = "hidden";
			
			if(document.getElementById("treeDiv")!=null)
			    document.getElementById("treeDiv").style.visibility = "hidden";
			
		    var oselect3 = document.getElementById(selectname);		    
			switch(oselect3.value)
			{
			
				case "Value": changeDiv(divname,"valuediv"+sCtrlID);
				                    
							break;
							
				case "Variable": changeDiv(divname,"variablediv"+sCtrlID);
				            SelectVarCont_onclick('valueinput'+sCtrlID,sCtrlID);
								break;
								
				case "Content": changeDiv(divname,"contentdiv"+sCtrlID);
				            SelectVarCont_onclick('valueinput'+sCtrlID,sCtrlID);
								break;
								
				case "XmlVariable": changeDivforXmlVarible(divname,"XmlVariablediv"+sCtrlID,sCtrlID);
				            	break;				
				            									
				case "Select": changeDiv(divname,"Selectdiv"+sCtrlID);
							break;
							
			    case "Password": changeDiv(divname,"Passworddiv"+sCtrlID);
			                    SelectVarCont_onclick('valueinput'+sCtrlID,sCtrlID);
			                    break;
                case "SendTo":                             
                            changeDiv(divname,"SendTodiv"+sCtrlID);
                            SelectVarCont_onclick('valueinput'+sCtrlID,sCtrlID);
							break;			
								
			}
			return false;
		}
		
		function Select_onclickInitialize(selectname,divname,sCtrlID)        
		{		
//alert(selectname + " - " + divname + " - " + sCtrlID);		
			var oselect3 = document.getElementById(selectname);
			switch(oselect3.value)
			{
			
			
				case "Value": changeDiv(divname,"valuediv"+sCtrlID);
				                
							break;
				case "Variable": changeDiv(divname,"variablediv"+sCtrlID);
				            //SelectVarCont_onclick('valueinput'+sCtrlID,sCtrlID);
								break;
				case "Content": changeDiv(divname,"contentdiv"+sCtrlID);
				            //SelectVarCont_onclick('valueinput'+sCtrlID,sCtrlID);
								break;
				case "Select": changeDiv(divname,"Selectdiv"+sCtrlID);
							break;
				case "SendTo": changeDiv(divname,"SendTodiv"+sCtrlID);
							break;
				case "Password":changeDiv(divname,"Passworddiv"+sCtrlID);
				                    
				                break;			
			    case "XmlVariable": changeDivforXmlVarible(divname,"XmlVariablediv"+sCtrlID,sCtrlID);
		            	    break;				
								
			}
			return false;
		}

//******************************************************

        function SetSelectedValueType(selectname,SelectValue)
        {
      
            var oselect3 = document.getElementById(selectname);
            oselect3.value=SelectValue
        }
        
        function SetSelectedValue(CtrlName,Value,ValueType)
        {
        
            var oselect3 = document.getElementById(CtrlName);
            if(ValueType=="XmlVariable")
             {
                  var variableName = "";
                  variableName = Value.substring(Value.indexOf('.')+1,Value.length);
                  variableName = variableName.substring(0,variableName.indexOf('.'));
                  oselect3.value=variableName; 
                  var inpuId = CtrlName.substring(10,CtrlName.length);
                  document.getElementById(defaultInputCtrlForTreeView+inpuId).value = Value; 
                  //Commented to remove the hardcoded id
//                  document.getElementById("cmbLHS_Input"+inpuId).value = Value; 
             }
             else
             {
                 oselect3.value=Value
             }    
        }
        
        function ValTypeText_onChange(ctrl,ctrlid)
	    {
	    
	    //modified for Password
	    if(ctrlid=="SecPwdValSel")
	       var strExpr=GetFormatedString("Password");
	       else
	        var strExpr=GetFormatedString("Value");
	       
		    strExpr+=GetFormatedString(ctrl.value);
		  
		    document.getElementById(ctrlid+"_hValue").value=strExpr;
	    };
        
	    /*function ValTypeText_onChange(ValTypeId,CtrlName)
	    {
	    alert(ValTypeId + " - " + CtrlName)
            var valTyp = null;
            valTyp = eval(ValTypeId);
            if (valTyp == null)
        	    return;
            valTyp.Text_onChange(ValTypeId,CtrlName);
	    };
        
        ValueType.prototype.Text_onChange= function(ValTypeId,CtrlName)
        {        
		    var o=document.getElementById(CtrlName);
		    var strExpr=GetFormatedString("Value");
		    strExpr+=GetFormatedString(o.value);
		    document.getElementById(ValTypeId+"_hValue").value=strExpr;
		    
//		 alert(o.name);
//		 alert(o.value);
		}
		*/
		
		
		function SelectVarCont_onclick(selectName,ValTypeId,ctrlValue)
	    {
	        var valTyp=document.getElementById("Select"+ValTypeId);	
	                
	        var strExpr=GetFormatedString(valTyp.value);	      
	        var val=document.getElementById(selectName);
            
            var tobegormattedstring = ""
            
            if(valTyp.value=="XmlVariable")
            {
                tobegormattedstring=ctrlValue;
            }
            else
            {
              tobegormattedstring = val.value;
            }
            
            strExpr+=GetFormatedString(tobegormattedstring);
		    document.getElementById(ValTypeId+"_hValue").value=strExpr;
	    }
	    
	    
	    function ConvertToString(number,width)
	    {
		    var str="";
		    var i;
    		
		    str=number.toString();
		    var l = str.length;
		    for(i=0;i<(width-l);i++)
		    {
			    str = "0" + str;
		    }	
		    return str.substring(0,width);
	    }
    	
	    function GetFormatedString(strVar)
	    {    	
	       return ConvertToString(strVar.length,4)+strVar;
	    }
	    
	    function findPosX(obj)
		{
		      var curleft = 0;
		      if (obj.offsetParent)
		      {
		            while (obj.offsetParent)
		            {
		                  curleft += obj.offsetLeft
		                  obj = obj.offsetParent;
		            }
		      }

		      else if (obj.x)
		            curleft += obj.x;

		      return curleft;
		}

		function findPosY(obj)
		{
		      var curtop = 0;
		      if (obj.offsetParent)
		      {
		            while (obj.offsetParent)
		            {
		                  curtop += obj.offsetTop
		                  obj = obj.offsetParent;
		            }
		      }
		      else if (obj.y)
		            curtop += obj.y;
		      return curtop;
		}