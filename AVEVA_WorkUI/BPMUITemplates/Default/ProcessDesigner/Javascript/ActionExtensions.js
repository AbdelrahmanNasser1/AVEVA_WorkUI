// JScript File

function opensubprocess(templatebasehttppath, nodename, applicationname, workflowname, filename, uiculture, contextmenuname, designerdata, jsparam)
{
    //alert(templatebasehttppath+","+ nodename+","+ applicationname+","+ workflowname+","+ filename+","+ uiculture+","+ contextmenuname+","+  designerdata+","+jsparam);
    if(typeof designerdata == 'undefined' || designerdata == null) 
    {
        alert("Please specify Application & WorkflowName to Open the Sub Process Definition");
        return;
    }
    //alert(templatebasehttppath+","+ nodename+","+ applicationname+","+ workflowname+","+ filename+","+ uiculture+","+ contextmenuname+","+  designerdata+","+jsparam);
    
    var canloadprocess=0;
    //var applicationame="";
    //var workflowname="";
    var version="";
    var x=0,y=0;// default value
    var ah=500,aw=500;
    if( typeof designerdata["ApplicationNotAvailable"] == 'undefined' )
    {
        canloadprocess++;
        applicationame = designerdata["Application"];
    }
    
    if( typeof designerdata["WorkflowNotAvailable"] == 'undefined' )
    {
        canloadprocess++;
        workflowname = designerdata["Workflow"];
    }
    
    if( typeof designerdata["VersionNotAvailable"] == 'undefined' )    version=designerdata["Version"];
        
    if( canloadprocess == 2 )
    {
        
//        var strWin;
        
        
           aw= document.body.clientWidth +( document.body.clientWidth * 0.13);
           ah= document.body.clientHeight+( document.body.clientHeight * 0.11);
           x=(window.screen.width - aw )/2 ;
           y=(window.screen.height - ah)/2 ;
/*
      if(document.all)
        {
           aw= document.body.clientWidth +( document.body.clientWidth * 0.23);
           ah= document.body.clientHeight+( document.body.clientHeight * 0.11);
           x=(window.screen.width - aw )/2 ;
           y=(window.screen.height - ah)/2 ;
           strWin="\"height=400,width=400,left=100,top=100, resizable=yes, scrollbars=yes\""
        }
        else
        {
         
       
           aw= document.body.clientWidth +( document.body.clientWidth * 0.23);
           ah= document.body.clientHeight+( document.body.clientHeight * 0.11);
           x=(window.screen.width - aw )/2 ;
           y=(window.screen.height - ah)/2 ;
            strWin="width="+aw+",height="+ah+",left="+x+"screenX="+x+",top="+y+",screenY="+y+",resizable=yes,scrollbars=yes"
        } */
        
    //var myWindow=window.open(templatebasehttppath + "processdesigner/wizards/ChildProcessDesigner.aspx?appName="+ applicationname+"&workflowname="+ workflowname+ "&version="+ version,"","resizable=1,height="+ah+",width="+aw+",left="+x+",top="+y+"");
    var myWindow=window.open(templatebasehttppath + "Repository/site/ProcessDesigner.aspx?"+ designerdata["listencParam"],"","resizable=1,height="+ah+",width="+aw+",left="+x+",top="+y+""); 
 
    }
    else
    {
        alert("Please specify Application & WorkflowName to Open the Sub Process Definition");
    }
    
    
}