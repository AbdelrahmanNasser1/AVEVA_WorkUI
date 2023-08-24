<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.RepositoryList"
    EnableEventValidation="false" %>

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    
    <title>
        <%=GetLangSpecText("ec_newHeader")%>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
  
    <script type="text/javascript">
        var winObj;
        function SetRepositoryValues(provtext, repo, instanceName, providerName, repositoryGuid) {
            try {
                document.getElementById('hdnrepo').value = repo;
                document.getElementById('hdnprov').value = providerName;
                document.getElementById('hdnprovtext').value = provtext;
                document.getElementById('hdnInstanceName').value = instanceName;
                var strWidth = screen.availWidth;
                var strHeight = screen.availHeight;
                //if repo name is having special character then window was not opening
                /*var winName = repo.replace(" ","");
                winName = winName.replace(".","");
                winName = winName.replace("-","");*/
                //don't set window name as repository name then each repository will open in different pages but usercontext will be the latest repository information, to fix this issue make window name as static.
                var winName = "repository"; //repositoryGuid;
                if (providerName === "connectuserprovider" || providerName == "aadprovider") {
                    window.location.href = 'Login.aspx?_repo=' + repo + '&_instanceName=' + instanceName + '&_provtext=' + provtext + '&_prov=' + providerName, '_self';
                }
                else
                {
                    if (navigator.appName != 'Netscape') {
                        if (winObj == undefined)
                            winObj = window.open('Login.aspx?_repo=' + repo + '&_instanceName=' + instanceName + '&_provtext=' + provtext + '&_prov=' + providerName, winName, 'top=0,left=0,width=' + strWidth + ',height=' + strHeight + ',location=0, status=1, scrollbars=0, resizable=yes');
                        else {
                        
                            if (winObj.closed) {
                                winObj = window.open('Login.aspx?_repo=' + repo + '&_instanceName=' + instanceName + '&_provtext=' + provtext + '&_prov=' + providerName, winName, 'top=0,left=0,width=' + strWidth + ',height=' + strHeight + ',location=0, status=1, scrollbars=0, resizable=yes');
                            }
                            else {
                                winObj = window.open('Login.aspx?_repo=' + repo + '&_instanceName=' + instanceName + '&_provtext=' + provtext + '&_prov=' + providerName, winName, 'top=0,left=0,width=' + strWidth + ',height=' + strHeight + ',location=0, status=1, scrollbars=0, resizable=yes');
                                winObj.location = winObj.location; // If this is not given, then on clicking of AD repository, it is directly redirecting to HomePage3
                            }
                        }
                    }
                    else {
                        winObj = window.open('Login.aspx?_repo=' + repo + '&_instanceName=' + instanceName + '&_provtext=' + provtext + '&_prov=' + providerName, winName, 'top=0,left=0,width=' + strWidth + ',height=' + strHeight + ',location=0, status=1, scrollbars=0, resizable=yes');
                    }

                    if (winObj == null)
                        alert('<%=popupBlockedMsg %>');
                    //window.location.href = 'Login.aspx?_repo='+repo+'&_instanceName='+instanceName+'&_provtext='+provtext+'&_prov='+providerName,'_self';
                }                
            }
            catch (e)
	          { }
        }

    </script>
    <style type="text/css">
        
       
</style>
</head>
<body class="bodyRepositoryListing">
    <form id="form2" name="form2" runat="server" method="post" action="login.aspx">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>

        <link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />        
               
        
        <div class="divECTitle">
            <span class="ECTitleFont"><%=GetLangSpecText("ec_newHeader")%></span>
        </div>
        <br />
                
	        <div class="divHeading">
    	        <div class="repo-title"><%=GetLangSpecText("ec_main_repoheader_text")%></div>
    	        <div class="authentication-title"><%=GetLangSpecText("ec_main_provider_text")%></div>
            </div>
        

        <% WriteRepositories();%>

        
    
    <asp:HiddenField ID="hdnrepo" runat="server" />
    <asp:HiddenField ID="hdnprov" runat="server" />
    <asp:HiddenField ID="hdnprovtext" runat="server" />
    <asp:HiddenField ID="hdnInstanceName" runat="server" />
    </form>
</body>
</html>
