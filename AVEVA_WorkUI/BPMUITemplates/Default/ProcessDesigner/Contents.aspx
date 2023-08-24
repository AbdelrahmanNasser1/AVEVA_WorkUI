<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Contents.aspx.cs" Inherits="SkeltaTemplates_Default_ProcessDesigner_Contents" Theme="" StylesheetTheme=""%>
<link rel="stylesheet" type="text/css" href="/SkeltaTestApp/BPMUITemplates/Default/ProcessDesigner/../Common/stylesheet/DecisonsStyle.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body>
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
    <table width=100% cellspacing=0 cellpadding=0>
            <tr>
                                                <td class="contenttext">
                                                
                                                       &nbsp;
                                                </td>
                                        
                                        </tr>
                                        
            <tr>
                    <td align="center">
                             <table width=90% cellspacing=0 cellpadding=0 align="center">
                                
                                        <tr>
                                                <td class="contenttext">
                                                
                                                        <b>Schema Definition</b>: &nbsp;   File  - <input type="text" id="file" class="contenttext"/> &nbsp;&nbsp; <b>OR</b> &nbsp;&nbsp;&nbsp;Type Text - <a href="#"><img src="/SkeltaTestApp/BPMUITemplates/Default/ProcessDesigner/../Common/Images/Expression-icon.gif" alt="Editor" border=0 /></a> &nbsp;(xml or xsd)
                                                </td>
                                        
                                        </tr>
                                        
                                           <tr>
                                                <td class="contenttext">
                                                
                                                       &nbsp;
                                                </td>
                                        
                                        </tr>
                                        
                                         <tr>
                                                <td class="contenttext">
                                                
                                                        <b>XSLT</b>: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  File - <input type="text" id="Text1" class="contenttext"/> &nbsp;&nbsp; <b>OR</b> &nbsp;&nbsp;&nbsp;Type Text - <a href="#"><img src="/SkeltaTestApp/BPMUITemplates/Default/ProcessDesigner/../Common/Images/Expression-icon.gif" alt="Editor" border=0 /></a>
                                                </td>
                                        
                                        </tr>
                                        
                                        
                             
                             </table>                   
                        
                    </td>
            
            </tr>
            <tr>
                    <td>
                            &nbsp;
                    </td>
            </tr>
            <tr>
                    <td>
                            &nbsp;
                    </td>
            </tr>
            <tr>
                    <td>
                            &nbsp;
                    </td>
            </tr>
            <tr>
                    <td valign=bottom>
                           <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                  <td width="100%"  id="Td2" align="center">
                                  
                                         <input type="button" id="btnOk" name="btnOk" value="&nbsp;Save&nbsp;" onClick="javascript:ClickOK();" class="input-buttonswork">
	                                      
                                  
                                  </td>
                           </tr>
                        </table>      
                    
                    </td>
            
            </tr>
    
    </table>    
    </div>
    </form>
</body>
</html>

