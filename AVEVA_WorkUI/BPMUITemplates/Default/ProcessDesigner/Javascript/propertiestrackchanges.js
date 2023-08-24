var changed = 0;
function recordChange() 
{ 
	changed = 1;
}
function recordChangeIfChangeKey(myevent) 
{ 
    if( !myevent ) myevent = event;
    
    
    if( myevent.keyCode == 8 ) recordChange(); //Backspace key
    if( myevent.keyCode == 46 ) recordChange(); //DEL key
	if (myevent.which && !myevent.ctrlKey && !myevent.ctrlKey)  recordChange(myevent);
	
}

function ignoreChange() 
{ 
	changed = 0;
}

function lookForChanges() 
{ 
    addHandler(document,'keydown',recordChangeIfChangeKey);   
	var origfunc; 
	for (var i = 0; i < document.forms.length; i++) 
	{  
		for (var j = 0; j < document.forms[i].elements.length; j++) 
		{   
			var formField=document.forms[i].elements[j];   
			var formFieldType=formField.type.toLowerCase();   
			if (formFieldType == 'checkbox' || formFieldType == 'radio') 
			{    
				addHandler(formField, 'click', recordChange);   
			} 
			else if (formFieldType == 'text' || formFieldType == 'textarea') 
			{    
				if (formField.attachEvent) 
				{     
					addHandler(formField, 'keypress', recordChange);    
				} 
				else 
				{     
					addHandler(formField, 'keypress', recordChangeIfChangeKey);    
				}   
			} 
			else if (formFieldType == 'select-multiple' || formFieldType == 'select-one') 
			{    
				addHandler(formField, 'change', recordChange);   
			}  
		}  
		addHandler(document.forms[i], 'submit', ignoreChange); 
	}
}

function warnOfUnsavedChanges() 
{ 
	if (changed) 
	{  
	    window.frameElement.style.visibility="visible";
		return "You have some pending changes in the currently displayed properties, Pleas click Ok to Ignore these Changes, or Cancel to remain on the same property page";
	}
}

function addHandler(target, eventName, handler) 
{ 
	if (target.attachEvent) 
	{  
		target.attachEvent('on'+eventName, handler); 
	} 
	else 
	{  
		target.addEventListener(eventName, handler, false); 
	}
}


function checksize()
{
    window.frameElement.style.visibility="visible";
    if( document.body.clientHeight < document.body.scrollHeight )
    {
	    document.body.scroll="yes";
    }
}


function ArePropertiesDirty()
{
    return changed;
}