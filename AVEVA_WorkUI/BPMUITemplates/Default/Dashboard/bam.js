// JScript File

function changedropdown(el,txtInput)
{
    if( el.value == "NotSet" )
    {
        txtInput.value = "";
        txtInput.disabled=true;
        txtInput.style.visibility="hidden";
    }
    else
    {
        txtInput.style.visibility="visible";
        txtInput.disabled=false;
        txtInput.focus();
    }
}

function changepsdd(el,txtInput)
{
    if( el.value == "Remaining" || el.value=="Disable" )
    {
        txtInput.value = "";
        txtInput.disabled=true;
        txtInput.style.visibility="hidden";
    }
    else
    {
        txtInput.style.visibility="visible";
        txtInput.disabled=false;
    }
}