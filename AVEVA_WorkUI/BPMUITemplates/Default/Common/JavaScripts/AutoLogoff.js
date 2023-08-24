(function ()
{
    function isSharePointEnvironment()
    {
        var isSP = false;

        try
        {
            var res = window.location.pathname.match(/_layouts\/[0-9][0-9]\/BPMUI/i);

            if (!isUndefined(res) && res.length > 0)
            {
                isSP = true;
            }
            else if (!isUndefined(window.SP) && !isUndefined(window.SP.ClientContext))
            {
                isSP = true;
            }
            else if (!isUndefined(window._spPageContextInfo) && !isUndefined(window._spPageContextInfo.layoutsUrl))
            {
                isSP = true;
            }
        }
        catch (e)
        {
            // Nothing
        }

        return isSP;
    }

    var pluses = /\+/g,
        timeoutForReCheckInMS = 5000,
        timOutForClosingInMS = 10000,
        origCookieValue = "";

    function parseCookieValue(s)
    {
        if (s.indexOf('"') === 0)
        {
            s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\');
        }

        try
        {
            s = decodeURIComponent(s.replace(pluses, ' '));
            return s.trim();
        } catch (e) { }
    }

    function getCookieValue(docObj, cookieName)
    {
        var result = "",
			cookies = docObj.cookie ? docObj.cookie.split('; ') : [],
			i = 0,
			l = cookies.length;

        for (; i < l; i++)
        {
            var parts = cookies[i].split('='),
				name = decodeURIComponent(parts.shift()),
				cookie = parts.join('=');

            if (cookieName === name)
            {
                result = parseCookieValue(cookie);
                break;
            }
        }

        return result;
    }

    function setOriginalCookieValue()
    {
        var winObj = window.top,
                ptrCookieValue = getCookieValue(winObj.document, "skpointerucontextinfo");

        if (ptrCookieValue !== "")
        {
            origCookieValue = getCookieValue(winObj.document, ptrCookieValue);
        }
    }

    function checkOnPageExpiry()
    {
        try
        {
            var winObj = window.top,
                ptrCookieValue = getCookieValue(winObj.document, "skpointerucontextinfo"),
                invalidContextMsg = "You have been logged out from the application. Please log on to the Enterprise Console and try again.";

            if (ptrCookieValue !== "")
            {
                var cookieVal = getCookieValue(winObj.document, ptrCookieValue);

                if ((cookieVal === "") || (cookieVal !== origCookieValue))
                {
                    $(document).off(".sklogoff");

                    if (window.se && window.se.ui && window.se.ui.messageDialog)
                    {
                        setTimeout(function ()
                        {
                            winObj.close();
                            winObj.location = "about:blank";
                        }, timOutForClosingInMS);

                        se.ui.messageDialog.showAlert(document.title, invalidContextMsg, function ()
                        {
                            winObj.close();
                            winObj.location = "about:blank";
                        });
                    }
                    else
                    {
                        alert(invalidContextMsg);
                        winObj.close();
                        winObj.location = "about:blank";
                    }

                    return false;
                }
            }
        }
        catch (err)
        {
            console.log(err.message);
        }

        return true;
    }

    function performExpirationChecks()
    {
        if (window.location.href.indexOf('FromArchestrA') < 0 && typeof (Storage) !== "undefined")
        {
            if (!isSharePointEnvironment())
            {
                if (checkOnPageExpiry())
                {
                    setTimeout(performExpirationChecks, timeoutForReCheckInMS);
                }
            }
        }
    }

    window.ResetUserIdleTime = function ()
    {
        if (window.location.href.indexOf('FromArchestrA') < 0 && typeof (Storage) !== "undefined")
        {
            setStorageItem("SE_userIdleTime", 0);
        }
    };

    function getWindowForAutoLogoff()
    {
        var winObj = window;

        if (window.top === window)
        {
            return window;
        }

        if (!isUndefined(window.top.ResetUserIdleTime))
        {
            return window.top;
        }

        if (!isUndefined(winObj.parent) && !isUndefined(winObj.parent.ResetUserIdleTime))
        {
            winObj = winObj.parent;
        }

        return winObj;
    }

    $(document).ready(function ()
    {
        var isLoadedFromECString = getSessionStorageItem("SE_LoadedFromEC");

        if (isUndefined(isLoadedFromECString) || isLoadedFromECString.toLowerCase() != "true")
        {
            return;
        }

        ResetUserIdleTime();
        $(this).on("mousemove.sklogoff", function (e)
        {
            ResetUserIdleTime();
        });

        $(this).on("keydown.sklogoff", function (e)
        {
            ResetUserIdleTime();
        });

        if (window === getWindowForAutoLogoff())
        {
            setOriginalCookieValue();

            setTimeout(performExpirationChecks, 1000);
        }
    });

    function isUndefined(obj)
    {
        return ((typeof obj === "undefined") || (obj === null));
    }

    if (isUndefined(String.prototype.trim)) {
        String.prototype.trim = function () {
            return this.replace(/^\s+|\s+$/g, '');
        };
    }

    function getStorageItem(key)
    {
        try
        {
            var storageItem = localStorage[key];
            return isUndefined(storageItem) ? sessionStorage[key] : storageItem;
        } catch (e)
        {
            console.log(e.message);
            return sessionStorage[key];
        }
    };

    function getSessionStorageItem(key)
    {
        try
        {
            var storageItem = sessionStorage[key];
            return storageItem;
        }
        catch (e)
        {
            console.log(e.message);
            return null;
        }
    };

    function setStorageItem(key, value)
    {
        try
        {
            localStorage[key] = value;
        } catch (e)
        {
            sessionStorage[key] = value;
            console.log(e.message);
        }
    };

    function removeStorageItem(key)
    {
        try
        {
            localStorage.removeItem(key);
        } catch (e)
        {
            sessionStorage.removeItem(key);
            console.log(e.message);
        }
    };
})();