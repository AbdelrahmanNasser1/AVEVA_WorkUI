<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.WorkItemList.ProcessWorkItem" Theme="" StylesheetTheme=""%>



<html>
<head id="Head1" runat="server">
    <title>Process Work Item</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body>
    <script type="text/javascript">

        function ShowBellyBarErrorMessage(title, message) {
            self.parent.ShowBellyBarErrorMessage(title, message);
        }

        function ShowBellyBarAlertMessageWithCallBack(title, message) {
            self.parent.ShowBellyBarAlertMessageWithCallBack(title, message);
        }

        function ShowBellyBarAlertMessage(title, message) {
            self.parent.ShowBellyBarAlertMessage(title, message);
        }

    </script>
    <form id="form1" runat="server">
    <div>
        
    </div>
    </form>
</body>
</html>
