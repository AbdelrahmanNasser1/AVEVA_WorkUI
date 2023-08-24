<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.CreateList.EditListRegenerateForm" %>
<!DOCTYPE html >
<html>
<script type="text/javascript">

    function getCheckedRadioButtonValue() 
    {
      var radioButtons = document.getElementsByName("rdList");
      for (var x = 0; x < radioButtons.length; x ++) {
        if (radioButtons[x].checked) 
        {
          //alert("You checked " + radioButtons[x].id + " which has the value " + radioButtons[x].value);
          //confirmCallBackFn(radioButtons[x].value)
          var radioButtonCheckedValue = radioButtons[x].value;
          var oWindow = GetRadWindow();
          oWindow.close(radioButtonCheckedValue);
        }
      }
    }
    
    function returnFalse() 
    {
        var oWindow = GetRadWindow();
        oWindow.close('ReGenerateFormFalse');
    }

    function GetRadWindow()
    {
        var oWindow = null;
        oWindow = window.frameElement.radWindow;
        return oWindow;
    } 

</script>
   
<head runat="server">
    <title><%=pageTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style>
        #rdList input{
            vertical-align:top;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server"><link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>Common/StyleSheet/Global.css" rel="stylesheet"  type="text/css"/>
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <div>
    <table style="padding-left:12px; padding-top:5px;">
        <tr>
            <td id="tdSavedListChanges" runat="server" class="subtitle">
            <%=listSaved%>
            </td>
        </tr>
        <tr style="height:10px">
            <td>
            </td>
        </tr>
        <tr>
            <td id="tdRegenerateForm" runat="server" class="subtitle">
                <%=regeneratePrompt%>
            </td>
        </tr>
        <tr>
            <td>
            <table>
                <tr>
                    <td>
                        <asp:RadioButtonList  ID="rdList" runat="server" CssClass="inputradio">
                            <asp:ListItem Value="ReGenerateFormFalse" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="ReGenerateFormTrue" Selected="False"></asp:ListItem>                                                
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table> 
            </td>
         </tr>

        <tr>
            <td style="position: fixed; bottom: 0px; left: 0px; right: 0px; height: 32px; padding-top: 0px; padding-right: 15px; padding-bottom: 10px;">
                <asp:Button ID="btnOK" runat="server" CssClass="inputbutton" OnClientClick="getCheckedRadioButtonValue()" style="float: right;"/>                
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
