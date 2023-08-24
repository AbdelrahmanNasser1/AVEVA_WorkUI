<%@ Control Language="C#"  AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ListHeader" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
 <link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
<script type="text/javascript">

    /*
        function OnLoad() {     
            
            var frame = document.getElementById("mainframe"); //.contentWindow.document.getElementById("gridframe");    
            var dd = window.document.getElementById("<%=ddView.ClientID%>");
    var viewId = dd.value;
    var canEditView="<%=CanEditView%>";
        if (viewId == "nv")
            document.getElementById('btnGo').style.visibility = 'hidden'; 
        else if(canEditView=="False")
            document.getElementById('btnGo').style.visibility =  'hidden';                
        else 
            document.getElementById('btnGo').style.visibility = 'visible';
        if (viewId != "cv") {
            if (frame != null) {
                var src = frame.attributes["src"].value;
                var gridString = src.split('&')[0];
                frame.attributes["src"].value = gridString + "&ViewItemId=" + viewId;
                //NavigateGrid('', 'x');
            }
        }
        }
    */

        //    function setCookie(c_name, value, exdays) {debugger;
        //        var exdate = new Date();
        //        exdate.setDate(exdate.getDate() + exdays);
        //        var c_value = escape(value);// + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());
        //        document.cookie = c_name + "=" + c_value;
        //    }
        function OpenFilterWindow(dropDownId, listName) {
            var dd = dropDownId; //window.document.getElementById(dropDownId); //("<%=ddView.ClientID%>");
        var viewId = dd.value;
        if (viewId != "nv") {
            var url = "<%=_ListControl.TemplateDirectory %>Repository/Site/CreateView.aspx?id=" + encodeURIComponent(viewId) + "&ln=" + encodeURIComponent(listName);  //escape("<%=_ListControl.ListName%>");
            OpenWindow(url);
        }
        return false;


    }

    function OpenWindow(path) {

        var width, height;
        var winLeft, winTop;
        var w, h;
        w = 900;
        h = 550;
        var oManager = $find("<%=RadListHeader.ClientID%>");
        var oWindow = oManager.getWindowByName("RadWindow1");
        oWindow.setUrl(path);
        oWindow.setSize(w, h);
        oWindow.show();
        oWindow.center();       
    }
</script>

<table style="width:100%; border-width:0;border-spacing:0; vertical-align:middle;" class="ListBreadCrumbCss">
  <tr>
    <td id="tdImage" runat="server" style="width:3%;text-align:right; vertical-align:top;display:none"></td>
    <td style="text-align:left;width:80%;vertical-align:top;">
        <table id="tableHeader" runat="server" style="border:0;border-spacing:0">
            <tr style="text-align:left;">               
                <td style="text-align:left;color:white;padding-top:9px;padding-left:20px;"><a href="javascript:NavigateGrid<%=controlId %>('','x')"  class='bclink'><%=ListName%></a></td>
                <td id="bcrumb" runat="server" style="padding-top:9px;"></td>
             </tr>
        
        </table>
    </td>
      <td style="text-align:left;vertical-align:top;width:10%;">
          <table>
              <tr id="trViewId" runat="server" style="display:none;">
                  <td style="text-align:left;vertical-align:top;padding-top:5px;">
                      <asp:DropDownList ID="ddView"  CssClass="inputselect" runat="server">
                      </asp:DropDownList>
                  </td>
                  <td style="text-align:right;vertical-align:top;padding-top:3px;">
                       <input id="btnGo" type="button" value="<%=_Skrm.GlobalResourceSet.GetString("lh_Go") %>" onclick="OpenFilterWindow(<%=ddView.ClientID%>, '<%= _ListControl.ListName%>'); return false;" style="visibility:hidden;" buttoninputgo-skbtn="submit" />
                  </td>
              </tr>
          </table>
      </td>
  </tr> 
</table>

<telerik:RadWindowManager ID="RadListHeader" Skin="AWTWindow" EnableEmbeddedSkins="false"
         runat="server" RenderMode="Classic" VisibleStatusbar="false">
    <Windows>
        <telerik:RadWindow  ID="RadWindow1" runat="server" UseEmbeddedScripts="true" Behaviors="Maximize,Move,Close,Minimize" Height="800px" Width="800px">
        </telerik:RadWindow>
    </Windows>
</telerik:RadWindowManager>

<script type="text/javascript" >

    function NavigateGrid(ListItemId, cnt) {
        try {
            
            document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.NavigateGrid(ListItemId, cnt);
        }
        catch (ex) {
            var qryStr = document.getElementById("mainframe").contentWindow.location.href;
            var qryStrArr = qryStr.split("?");

            document.getElementById("mainframe").contentWindow.document.location.href = "<%=templateDirectory%>listgridpage.aspx?" + qryStrArr[1];
            //document.getElementById("bcrumb").innerHTML = "";
            document.getElementById("<%=bcrumb.ClientID %>").innerHTML = "";

            breadCrumbArr.length = 0;
            cnt = 0;
            breadCrumbTemp = "";
        }
    }
</script>
 