<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Channel.ChannelDetail"  Theme="" StylesheetTheme="" %>

<html>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script> 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">       
</head>
<link href="<%:CssPath %>" rel="stylesheet" type="text/css">
<body style="height: 100%; width: 100%;">
    <form id="form1" runat="server">    
     <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <div class="ListHeaderCss">
    <span class="fontheading" style="padding-left: 5px; display: inline-block; margin-top: 10px" ><%= PageHeading %></span>
    </div>    

    <div style="margin-top:1.3em;height:95%; margin-left:0.3em;">

    <div class="description "><%= ChannelsDescription %></div>

    <div class="description"> <ul><li><%= WebChannelDescription %> </li>
                                        <li><%= MailChannelDescription %> </li>
                                        <li><%= MobileChannelDescription %>  </li>
                                    </ul></div>
     
    <div class="description"><%= CommonNote %>  </div>    
    </div>        
    </form>
</body>
</html>
