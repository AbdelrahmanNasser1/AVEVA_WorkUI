<%@ Page Language="C#" Debug="true" AutoEventWireup="true" Inherits="BPMUITemplates_Default_Common_CustomErrors" CodeFile="CustomErrors.aspx.cs"%>
<%@ Import Namespace="Workflow.NET" %>
<!DOCTYPE html>
<html>

<head id="Head1" runat="server">
<script Language="JavaScript">
  var sw=window.screen.width;
  var sh=window.screen.height;
  window.resizeTo(sw*.96,sh*.96);
  window.moveTo(sw * .02, sh * .02);

  //window.resizeTo(sw * .66, sh * .66);
  //window.moveTo(sw * .09, sh * .09);
</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Error</title>
<STYLE TYPE="text/css">
.hiddenControl {display:none}
.expandable { text-decoration:underline; font-weight:bold; color:navy; cursor:hand; }
</STYLE>
</head>
<body >
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />  
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/StyleSheet/Global.css" />
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=messageDialogClose %>",
                okButtonCaption: "<%=messageDialogOk %>",
                cancelButtonCaption: "<%=messageDialogCancel %>",
                showDetailsCaption: "<%=messageDialogShowDetails %>",
                hideDetailsCaption: "<%=messageDialogHideDetails %>"
            }
        });
    </script>
    <form id="form1" runat="server">
    <br />
        <br />
        <br />
        <br />
<table width="650" border="0" align="center" cellpadding="8" cellspacing="1" bgcolor="#CCCCCC">
  <tr>
    <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="5">
      <tr>
        <td width="15%"><img src="images\Error-Msg-icon.png" width="78" height="78"/></td>
          <td width="85%" align="left"><font color='red' style="font-family:Roboto,'Segoe UI','Trebuchet MS';font-size:20px"><%=errorText%></font><br /><asp:Label ID="lblErr" runat="server" Font-Names="Roboto,'Segoe UI','Trebuchet MS'" Font-Size="12px" ></asp:Label></td>
           <td bgcolor="#FFFFFF">
              <asp:button id="backButton" runat="server" text="Back" 
OnClientClick="JavaScript:window.history.back(1);return false;"  class="inputbutton"></asp:button>
          </td>
          
      </tr>
      
        
      </table></td>
      
  </tr>
</table>
<br><div class="expandable" id="showDivmsg" runat="server" onclick="OnToggleTOCLevel1('dynamicCodeDiv')">Show details:</div>
        <div id="dynamicCodeDiv" runat="server" style="display: none;">
            <br>
            <table bgcolor="#ffffcc" >
                <tr>
                    <td >
                        <asp:TextBox Width="800" Height="600"  ID="preId" Font-Bold="true" ForeColor="red" ReadOnly="true" Wrap="true" runat="server" TextMode="MultiLine" Rows="20"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
</form>
</body>
</html>
 <script type="text/javascript">
    function OnToggleTOCLevel1(level2ID)
    {
      var elemLevel2 = document.getElementById(level2ID);
      if (elemLevel2.style.display == 'none')
      {
        elemLevel2.style.display = '';
      }
      else {
        elemLevel2.style.display = 'none';
      }
    }
    
    function Resize()
    {

        document.getElementById('preId').width = window.clientWidth;
            }
    </script>