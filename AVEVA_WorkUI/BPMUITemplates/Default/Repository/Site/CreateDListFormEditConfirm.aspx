<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateDListFormEditConfirm.aspx.cs" Inherits="BPMUITemplates_Default_Repository_Site_CreateDListFormEditConfirm" %>
<html>

    <link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet"  type="text/css"/>

<head runat="server">
    <title><%=PageTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    </head>
<body>
    <script language="javascript" type="text/javascript">
    var _listParams="<%=_listParams%>";
    var _formItemId = "<%=_formItemId%>";
        var _formEdit = "<%=_formEdit%>";
    function ShowFormsDesigner()
    {
        if (_formEdit == "FormEditNGFOk")
        {
            var url = "../../NextGenForms/FormsDesigner.htm?" + _listParams;
            url = url + "&formItemId=" + _formItemId;
            url = url + "&fromListDesigner=True";
            window.parent.location = url;
        }
        else
        {
            window.parent.close();
            window.close();
        }
    }
    
    </script>
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div><br />
        <table border="0" width="100%" align="center"> 
          <tr>
            <td align="left" >            
                <span class="subtitle" style="padding-left:14px;"> <%=SavedListChangesText%></span>             
            </td>
          </tr>
         <tr style="padding-top:100px">
            <td align="center" >
                             
            </td>
          </tr>
          <tr>
            <td> 
                <div style="position: fixed; bottom: 0px; left: 0px; right: 0px; height: 40px; padding-top: 0px; padding-right: 2px;">
                    <input id="btnYes" type="button" runat="server" value="Ok" lang="javascript" onclick="return ShowFormsDesigner()" class="inputbutton" style="float: right;margin-right:10px;" />
                </div>
            </td>
          </tr>
        </table>
    </div>
    </form>
</body>
</html>
