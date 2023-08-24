<%@ Control Language="C#" AutoEventWireup="true"  Inherits="Skelta.Repository.Web.Lookup.RoleLookupUserControl" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
 <telerik:RadCodeBlock ID="RadCodeBlock9" runat="server">
<link href="<%=roleLookupWebControl.GetCommonRelativeUrl("StyleSheet/Global.css")%>" rel="stylesheet" type="text/css">
</telerik:RadCodeBlock>
<div>
 <table width="100%" cellspacing="4" cellpadding="3" border="0">
     <tr>
         <td valign="bottom" height="20">
             <table cellspacing="0" width="100%" cellpadding="0" border="0">
                 <tr>
                    <td>
                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                            <tr>
                                <td class="subtitle" width="40%"> <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
                                    <img align="absmiddle" src="<%=ThemePath%>/Repository/ListControl/images/icons-ribbon/icon-role.png"
                                     border="0" />
                                    <%=strRoleHeaderText%>
                                    </telerik:RadCodeBlock>
                                </td>
                                <td width="60%">
                                    <asp:Label ID="lblDisplayError" runat="server" CssClass="errormsg "></asp:Label>
                                </td>
                            </tr>
                        </table>
                     </td>
                 </tr>
                 <tr>
                    <td>
                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                            <tr> <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                                <td class="description" height="25">
                                    <%=strRoleheaderDesc%>
                                </td>
                                <td class="description" align="right" style="display:<%=strProviderOptionDisplay%>">
                                    <asp:DropDownList ID="ddlProvider" runat="server" CssClass="inputselect" Width="190px" AutoPostBack="false">
                                    </asp:DropDownList>
                                </td>
                              </telerik:RadCodeBlock>
                            </tr>
                        </table>
                     </td>
                 </tr>
             </table>
         </td>
     </tr>
    <tr>
        <td>
            <table cellspacing="1" cellpadding="0" border="0" width="100%" class="tablebg">
                <tr>
                    <td>
                        <table cellspacing="0" cellpadding="2" border="0" width="100%">
                            <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
                            <tr style="display: <%=strDisplay%>; visibility: <%=strVisibility%>">
                                <td class="lefttdbg" style="width: 50%">
                                    <table cellspacing="1" cellpadding="1" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <span class="subtitle"> 
                                                    <%=strSearchFor%>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span class="description">
                                                    <%=strGlobalSearch%>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="lefttdbg" style="width: 50%" align="right">
                                    <asp:TextBox ID="txtName" runat="Server" CssClass="inputtext" Width="250px"></asp:TextBox>
                                </td>
                                <td class="lefttdbg" align="center"> <telerik:RadCodeBlock ID="RadCodeBlock6" runat="server">
                                    <asp:Button runat="server" Text="<%=strSearchButtontext%>" CssClass="inputbutton" ID="btnSearch" OnClick="btnSearch_Click"  />
                               </telerik:RadCodeBlock>
                               </td>
                            </tr>
                      </telerik:RadCodeBlock>
                     </table>
                    </td>
                </tr>
            </table>
            <table cellspacing="0" cellpadding="0" border="0" width="100%">
                <tr>
                    <td style="height: 10px">
                    </td>
                </tr>
            </table>
            <table cellspacing="1" cellpadding="4" border="0" width="100%" class="tablebg">
                <tr>
                    <td class="lefttdbg" align="center">
                        <table cellspacing="0" cellpadding="4" border="0" width="100%">
                            <tr>
                                <td style="text-align:left;padding-left:13px;">
                                    <span class="description"><telerik:RadCodeBlock ID="RadCodeBlock4" runat="server">
                                        <%=strAvailableResources%></telerik:RadCodeBlock></span>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <div id="divlistRole" style="overflow: auto; height: 171px; width: 240px">
                                        <asp:ListBox SelectionMode="Multiple" runat="Server" ID="lstselres" CssClass="">
                                        </asp:ListBox>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="lefttdbg" align="center" width="50">
                        <table border="0" cellpadding="1" cellspacing="0" width="100%" align="center">
                            <tr>
                                <td align="center">
                                    <asp:Button runat="server" Text=" > "  Width="36" CssClass="lookupnavigationbutton" ID="btnMoveright"
                                        OnClick="btnright_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button runat="server" Text=" >> " Width="36" CssClass="lookupnavigationbutton" ID="btnMoveAllRight"
                                        OnClick="btnmoveallright_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 15px">
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button runat="server" CssClass="lookupnavigationbutton" ID="btnMoveLeft" Text=" < " Width="36"
                                        OnClick="btnleft_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button runat="server" CssClass="lookupnavigationbutton" ID="btnMoveAllLeft" Text=" << "
                                        Width="36" OnClick="btnmoveallleft_Click" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="lefttdbg" align="center">
                        <table cellspacing="0" cellpadding="4" border="0" width="100%">
                            <tr>
                                <td style="text-align:left;padding-left:13px;">
                                    <span class="description"><telerik:RadCodeBlock ID="RadCodeBlock5" runat="server">
                                        <%=strSelectedResources%></telerik:RadCodeBlock>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <div id="divselectedRole" style="overflow: auto; height: 171px; width: 240px">
                                        <asp:ListBox SelectionMode="Multiple" runat="Server" ID="lstselectedres" CssClass="">
                                        </asp:ListBox>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
         <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnSearch"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lblDisplayError"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lstselres"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lstselectedres"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
                </telerik:AjaxSetting>
          <telerik:AjaxSetting AjaxControlID="btnMoveright">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lstselectedres">
                    </telerik:AjaxUpdatedControl>
                </UpdatedControls>
           </telerik:AjaxSetting>
          <telerik:AjaxSetting AjaxControlID="btnMoveAllRight">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lstselectedres"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
           <telerik:AjaxSetting AjaxControlID="btnMoveLeft">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lstselectedres">
                    </telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnMoveAllLeft">
                <UpdatedControls>
                 <telerik:AjaxUpdatedControl ControlID="lstselectedres">
                 </telerik:AjaxUpdatedControl>
              </UpdatedControls> 
              </telerik:AjaxSetting>
         </AjaxSettings>
     </telerik:RadAjaxManager> 
</div> 
<script src="../../Common/JavaScripts/jquery.min.js"></script>
<script src="../../Common/JavaScripts/AutoLogoff.js"></script>
<telerik:RadScriptBlock ID="radsc1" runat="server">
<script language="javascript">

    var textLengthLimitForMinimumWidth = 29;
    var listItemTextHeight = 19; //17

    SetLHSHeight();

    SetRHSHeight();

    function SetLHSHeight()
    {
        SetListBoxSize('divlistRole', '<%=lstselres.ClientID%>');
    }

    function SetRHSHeight()
    {
        SetListBoxSize('divselectedRole', '<%=lstselectedres.ClientID%>');
    }

    function GetValueFromHtmlPixelDimension(htmlPixelDimension)
    {
        try
        {
            return parseInt(htmlPixelDimension, 0);
        }
        catch (err)
        {
            return 0;
        }
    }

    function SetListBoxSize(divElementId, listBoxElementId)
    {
        var ListBoxMinWidthInPixels = GetValueFromHtmlPixelDimension(document.getElementById(divElementId).style.width) - 18;    // 201 - 18;
        var ListBoxMinHeightInPixels = GetValueFromHtmlPixelDimension(document.getElementById(divElementId).style.height) - 17;  // 101 - 17;

        var longTextCount = false;
        var shortTextcount = false;
        var lstAvailableNames = document.getElementById(listBoxElementId);

        if (lstAvailableNames != null)
        {
            if (lstAvailableNames.options.length >= 6)
            {
                for (var i = 0; i < lstAvailableNames.options.length; i++)
                {
                    if (lstAvailableNames.options[i].text.length < textLengthLimitForMinimumWidth)
                    {
                        shortTextcount = true;
                    }
                    else
                    {
                        longTextCount = true;
                    }
                }

                if (shortTextcount == true && longTextCount == false)
                {
                    document.getElementById(listBoxElementId).style.width = ListBoxMinWidthInPixels + "px";
                    var itemCount = eval(lstAvailableNames.options.length * listItemTextHeight) + 15;

                    if (itemCount <= ListBoxMinHeightInPixels)
                    {
                        document.getElementById(listBoxElementId).style.height = ListBoxMinHeightInPixels + "px";
                    }
                    else
                    {
                        document.getElementById(listBoxElementId).style.height = itemCount + "px";
                    }
                }
                else
                {
                    var itemCount = eval(lstAvailableNames.options.length * listItemTextHeight) + 15;
                    if (itemCount <= ListBoxMinHeightInPixels)
                    {
                        document.getElementById(listBoxElementId).style.height = ListBoxMinHeightInPixels + "px";
                    }
                    else
                    {
                        document.getElementById(listBoxElementId).style.height = itemCount + "px";
                    }
                }
            }
            else
            {
                document.getElementById(listBoxElementId).style.height = ListBoxMinHeightInPixels + "px";

                if (lstAvailableNames.options.length == 0)
                {
                    document.getElementById(listBoxElementId).style.width = ListBoxMinWidthInPixels + "px";
                }
                else if (lstAvailableNames.options.length > 1)
                {
                    for (var i = 0; i < lstAvailableNames.options.length; i++)
                    {
                        if (lstAvailableNames.options[i].text.length < textLengthLimitForMinimumWidth)
                        {
                            shortTextcount = true;
                        }
                        else
                        {
                            longTextCount = true;
                        }
                    }

                    if (shortTextcount == true && longTextCount == false)
                    {
                        document.getElementById(listBoxElementId).style.width = ListBoxMinWidthInPixels + "px";
                        var itemCount = eval(lstAvailableNames.options.length * listItemTextHeight);

                        if (itemCount <= ListBoxMinHeightInPixels)
                        {
                            document.getElementById(listBoxElementId).style.height = ListBoxMinHeightInPixels + "px";
                        }
                        else
                        {
                            document.getElementById(listBoxElementId).style.height = itemCount + "px";
                        }
                    }
                    else
                    {
                        var itemCount = eval(lstAvailableNames.options.length * listItemTextHeight);
                        if (itemCount <= ListBoxMinHeightInPixels)
                        {
                            document.getElementById(listBoxElementId).style.height = ListBoxMinHeightInPixels + "px";
                        }
                        else
                        {
                            document.getElementById(listBoxElementId).style.height = itemCount + "px";
                        }
                    }
                }
                else if (lstAvailableNames.options.length == 1)
                {
                    if (lstAvailableNames.options[0].text.length < textLengthLimitForMinimumWidth)
                    {
                        document.getElementById(listBoxElementId).style.width = ListBoxMinWidthInPixels + "px";
                    }
                }
            }

            if (GetValueFromHtmlPixelDimension(document.getElementById(listBoxElementId).style.width) < ListBoxMinWidthInPixels)
            {
                document.getElementById(listBoxElementId).style.width = ListBoxMinWidthInPixels + "px";
            }

            if (GetValueFromHtmlPixelDimension(document.getElementById(listBoxElementId).style.height) < ListBoxMinHeightInPixels)
            {
                document.getElementById(listBoxElementId).style.height = ListBoxMinHeightInPixels + "px";
            }
        }
    }       
</script></telerik:RadScriptBlock>