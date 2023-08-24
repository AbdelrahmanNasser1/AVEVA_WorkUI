<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserLookup.aspx.cs" Inherits="BPMUITemplates_Default_NextGenForms_UserLookup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Providers List</title>
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/knockout.min.js" type="text/javascript"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <link href="css/SkeltaForms.min.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div class="userlookup">
        <div class="userlookupHeader">
            User Lookup
        </div>
        <div class="content">
            <div class="contentDivision">
                <div class="ul-label">
                    Provider
                </div>
                <div class="ul-control">
                    <%--<select data-bind="options: providers, optionsText: 'Name', optionsCaption: 'Available Providers', value: selectedProviders">
                    </select>--%>
                    <select data-bind="options: providers , optionsText: 'Name' ,  optionsValue: 'Value' , value: selectedProviders">
                    </select>
                </div>
            </div>
            <div class="contentDivision">
                <div class="ul-label">
                    Search for
                </div>
                <div class="ul-control">
                    <input data-bind="value: searchText,hasfocus:lostfocus" /></div>
                <div class="ul-label" style="display: block !important;" data-bind="validationMessage:lostfocus">
                </div>
            </div>
            <div class="contentDivision">
                <div class="ul-label">
                    in</div>
                <div class="ul-control">
                    <%--<select data-bind="options: resourceProperties, optionsText: 'Name',optionsValue: 'Value', optionsCaption: 'Available Resources', value:selectedresourceProperties ">
                </select>--%>
                    <select data-bind="options: resourceProperties , optionsText: 'Name' ,  optionsValue: 'Value' , value: selectedresourceProperties">
                    </select>
                </div>
            </div>
            <div class="contentDivision">
                <div class="ul-search">
                    <button data-bind="click: searchClick">
                        Search</button></div>
            </div>
        </div>
        <div data-bind="visible: showResult">
            <div class="ul-resource">
                <div class="ul-resourceheading">
                    Resources
                </div>
                <div class="ul-resourcelist">
                    <ul data-bind="foreach: availableResourcesList">
                        <li>
                            <input type="radio" name="ResourceList" data-bind="checked :$root.selectedAvailableResourcesList, attr: {value: Value}" />
                            <span data-bind="text: Name"></span></li>
                    </ul>
                </div>
            </div>
            <div class="ul-button">
                <div style="float: left;">
                    <button data-bind="click: SubmitForm">
                        Save</button></div>
                <div style="float: right;">
                    <button data-bind="click: CancelForm">
                        Cancel</button></div>
            </div>
        </div>
        <div data-bind="visible: NoResult">
            <p>
                No Results found.
            </p>
        </div>
    </div>
    </form>
</body>
</html>
