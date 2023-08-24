<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FormImport.aspx.cs" Inherits="FormImport" %>

<!DOCTYPE html>
<html class="skep">
<head>
    <title>Import</title>
    <meta http-equiv="content-type" content="Type=text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <script type="text/javascript" src="../Common/JavaScripts/spin.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/knockout.min.js"></script>
    <script type="text/javascript" src="js/xml2json.min.js"></script>
    <script type="text/javascript" src="app/Skelta.min.js"></script>
    <script type="text/javascript" src="js/kendodependencies.min.js"></script>
    <script type="text/javascript" src="js/kendo.all.min.js"></script>
    <script type="text/javascript" src="js/knockout-kendo.min.js"></script>
    <script type="text/javascript" src="js/date.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <link rel="stylesheet" href="css/SkeltaForms.min.css" />
    <link rel="stylesheet" href="css/SkeltaTabs.min.css" />
    <link rel="stylesheet" href="css/kendo.common.min.css" />
    <link rel="stylesheet" href="css/kendo.default.min.css" />
    <link rel="stylesheet" href="../CommonUXControls/StyleSheet/se.ui.min.css" />
    <link rel="stylesheet" href="../CommonUXControls/StyleSheet/UXControls.min.css" />
    <script type="text/javascript">
        var skeltaUtils = skelta.forms.utilities;
        var skeltaLocalize = skelta.localize;
        var logger = skeltaUtils.getLogger();
        var cacheKey, listName, versionstamp, paramApplicationName, paramUserId, paramFormName;

        $(document).ready(function ()
        {
            var spinnerEl = skeltaUtils.getLoaderObject();
            $("#skloader")[0].appendChild(spinnerEl);

            paramlcsuri = skeltaUtils.getUrlParameterValue(window, 'lcsuri');
            checkFormsAccessRights(paramlcsuri, "Web");
           
        });

        function checkFormsAccessRights(lcsuri, deviceType)
        {
            var params = skeltaUtils.createJsonRequestHelper({
                "secUri": lcsuri,
                "rightCodes": ["ActionEdit"],
                "deviceType": deviceType
            });

            skeltaUtils.callServerMethod("GET", "NextGenFormService.aspx/GetCurrentContextWithSecurityCheck", "application/json; charset=utf-8", params, "json", checkFormsAccessRightsSucceeded, null, null, false);
        }

        function checkFormsAccessRightsSucceeded(successData)
        {
            var result = JSON.parse(successData.d);
            if (result.IsSuccess === false)
            {
                skeltaUtils.showAlert(document.title, result.ErrorMessage, function () { closeImportWindow(); });
                skeltaUtils.pageLoadComplete("");

                return false;
            }
            else
            {
                skelta.userContext.setUserContextFor("appN", window.parent.skelta.userContext.getUserContextFor("appN"));
                skelta.userContext.setUserContextFor("uId", window.parent.skelta.userContext.getUserContextFor("uId"));
                skelta.userContext.setUserContextFor("fName", window.parent.skelta.userContext.getUserContextFor("fName"));
                skelta.userContext.setUserContextFor("vStamp", window.parent.skelta.userContext.getUserContextFor("vStamp"));
                skelta.userContext.setUserContextFor("itemId", window.parent.skelta.userContext.getUserContextFor("itemId"));
                skelta.userContext.setUserContextFor("listName", window.parent.skelta.userContext.getUserContextFor("listName"));

                paramApplicationName = skelta.userContext.getUserContextFor("appN");
                paramUserId = skelta.userContext.getUserContextFor("uId");
                paramFormName = skelta.userContext.getUserContextFor("fName");
                versionstamp = skelta.userContext.getUserContextFor("vStamp");
                cacheKey = skelta.userContext.getUserContextFor("itemId");
                listName = skelta.userContext.getUserContextFor("listName");
                skeltaUtils.loadPageDefault();
                $("#headerDiv").text(paramFormName + " - " + skelta.localize.getString("FormNGFHTImportTitle"));
                $("#btnImport").val(skelta.localize.getString("FormNGFHTImportTitle"));
                $("#slFormDiv").text(skelta.localize.getString("FormNGFSelectForm"));
                skeltaUtils.pageLoadComplete("");
            }
        }

        function closeImportWindow()
        {
            parent.document.getElementById("formimportframe").attributes["data-skfiw"].value = 0;
            window.top.$('#formimportframe').attr('src', '');
            window.top.$('#designwrapper').css("visibility", "hidden");
        }

        $(function ()
        {
            $('#filepath').change(function (event)
            {
                $("#btnImport").removeAttr("disabled");

            });
        });

        function RefreshFormsDesigner()
        {
            window.top.RefreshDesignerOnImport();
        }

        function import_ClientClick(sender)
        {
            $(sender).attr('disabled', true);
            setTimeout(function ()
            {
                $("#btnHidImport")[0].click();
            }, 0);
            return false;
        }

    </script>
</head>
<body>
    <div id="skloader" class="skloader" data-skloader="1" style="height: 100%; width: 100%; position: absolute;"></div>
    <form class="sksa" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div id="viewModel">
            <div class='skfc skcn skfdc skfas skfmd' data-skimf="1" data-sklp="2" data-skcnt="BaseForm" data-skem="0" data-skvm="0">
                <div class="skh">
                    <div class="sktt" id="headerDiv"></div>
                </div>
                <div class='skflx skfc skfdr skfas skcp'>
                    <div class="skctr skfdc">
                        <div class="skccon skfdr">
                            <div class="skfl" id="slFormDiv" style="padding-left: 15px"></div>
                            <div class="skffb skflx" data-skm="0">
                                <input id="filepath" type="file" class="ski skc" runat="server" />
                            </div>
                        </div>
                        <div id="msgDiv" runat="server" class="skfld" style="padding-left:30px;"></div>
                    </div>
                </div>
                <div class='skf'>
                    <div class="skfbtn">
                        <asp:Button class="skbtn" ID="btnCancel"  controlid="NF1cancelButton" runat="server" data-skbtnsz="0" data-sksal="0" type="button" OnClientClick ="closeImportWindow();">
                        </asp:Button>
                        <asp:Button class="skbtn" ID="btnImport" controlid="NF1defaultButton" data-skbtnsz="0" data-sksal="0" type="button" disabled runat="server" OnClientClick="return import_ClientClick(this);"></asp:Button>
                        <asp:Button class="skbtn" ID="btnHidImport" controlid="NF1defaultButton" data-skbtnsz="0" data-sksal="0" type="button" runat="server" OnClick="btnImport_Click" style="display:none"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
