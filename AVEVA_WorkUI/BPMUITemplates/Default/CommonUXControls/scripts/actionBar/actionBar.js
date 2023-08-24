/*
 * Action Bar v1.0
 * 
 * Copyright © 2014 Vectorform
 * All rights reserved.
 * 
 */
var actionBarCollection = [];
var sourceSwap = function ()
{
    if ($(this).attr("disabled") === "disabled")
    {
        return;
    }

    var icon = $(".icon", $(this));
    var newSource = icon.data('alt-src');
    icon.data('alt-src', icon.attr('src'));
    icon.attr('src', newSource);
}

var ActionBar = {
    skActionItemIdAttribute: "data-SKActionID",
    init: function (json, parent, allowMobileUx)
    {
        if ($.inArray(this, actionBarCollection) === -1)
        {
            actionBarCollection.push(this);
        }
        var __actionBarInstance = this;
        this._parent = $("#" + parent);

        if (this._parent.closest(".actionBarWrapper").is(":visible") === false)
        {
            this._parent.closest(".actionBarWrapper").show();
        }

        if ($(".actionBar", this._parent).length > 0)
        {
            $(".actionBar", this._parent).html("");
            $(".actionBar", this._parent).remove();
        }

        this._allowMobileUX = (allowMobileUx === false) ? false : true;
        this.isMobile = false;
        this._actionBar = $("<div/>");
        this._actionBar.addClass("actionBar");

        if (this._parent.width() != null && this._parent.width() <= 320 && this._allowMobileUX)
        {
            this.isMobile = true;
            this._actionBar.addClass("mobile");
            $("body").append(this._actionBar);
        }
        else
        {
            this._actionBar.removeClass("mobile");
            this._parent.append(this._actionBar);
        }

        this._json = json;

        this._mainMenuItems = [];
        this._rightMenuItems = [];
        this._mainMenuItemsJson = [];
        this._rightMenuItemsJson = [];
        this.MoreItems = [];
        this.MoreItems.SubItems = [];
        this.SubMenu = [];
        this._selectedMenuItem = [];

        this._leftMenu = $("<div/>");
        this._leftMenu.addClass("leftMenu");
        this._leftMenu.attr("id", "leftMenu");
        this._actionBar.append(this._leftMenu);

        $.each(this._json, function (index, value)
        {
            $.each(value, function (subIndex, val)
            {

                var json = []
                __actionBarInstance._mainMenuItemsJson.push(json);
                var allSubItemsVisibility = false;
                $.each(val.SubItems, function (subItemIndex, subItem)
                {
                    if (!__actionBarInstance._mainMenuItemsJson[__actionBarInstance._mainMenuItemsJson.length - 1].SubItems)
                    {
                        __actionBarInstance._mainMenuItemsJson[__actionBarInstance._mainMenuItemsJson.length - 1].SubItems = [];
                    }

                    var subMenuItem = __actionBarInstance.createMenuItem(subItem, "SubItemLeft" + (__actionBarInstance._mainMenuItemsJson.length - 1) + __actionBarInstance._mainMenuItemsJson[__actionBarInstance._mainMenuItemsJson.length - 1].SubItems.length);
                    __actionBarInstance._mainMenuItemsJson[__actionBarInstance._mainMenuItemsJson.length - 1].SubItems.push(subMenuItem);
                    if (subItem.Visible === true)
                    {
                        allSubItemsVisibility = true;
                    }
                });

                var menuItem = __actionBarInstance.createMenuItem(val, "Left" + __actionBarInstance._mainMenuItems.length);
                if (!isUndefined(val.Visible) && allSubItemsVisibility === false && val.SubItems.length > 0)/*Hiding parent if all sub menus are hidden*/
                {
                    menuItem.hide();
                }
                __actionBarInstance._mainMenuItems.push(menuItem);
            });
        });

        __actionBarInstance.layoutMainMenu();


    },

    layoutMainMenu: function ()
    {
        var __actionBarInstance = this;
        this._leftMenu.html("");

        this.MoreItems.SubItems = [];

        var itemsWidth = 0; itemIndex = 0;
        var actionBarVisibility = false;

        while ((this._actionBar.width() > itemsWidth || this.isMobile) && itemIndex < this._mainMenuItems.length)
        {
            this._leftMenu.append(this._mainMenuItems[itemIndex]);
            if (this._mainMenuItems[itemIndex].is(":visible") === true)
            {
                actionBarVisibility = true;
            }
            $(this._mainMenuItems[itemIndex]).on("click", function ()
            {
                __actionBarInstance.menuItemClick(this);
            });

            if (this._leftMenu.width() < this._actionBar.width() || this.isMobile)
            {

                var separator = $("<div/>");
                separator.addClass("separator");
                this._leftMenu.append(separator);
                if (this._mainMenuItems[itemIndex].is(":visible") === false)
                {
                    separator.hide();
                }

                itemsWidth = this._leftMenu.width();
                itemIndex++;
            }
            else
            {
                this._mainMenuItems[itemIndex].remove();
                break;
            }
        }

        if (actionBarVisibility === false)/*Hiding actionbar warpper if parent items are hidden*/
        {
            this._parent.closest(".actionBarWrapper").hide();
        }

        /*if (itemIndex < ActionBar._mainMenuItems.length)
		{
			var menuItem = $("<div/>");
			menuItem.addClass("menuItem");
			menuItem.attr("id", "More");
			
			var content = $("<div/>");
			content.addClass("content");

			var icon = $("<img/>");
			icon.attr("src", "images/05.jpg");
			icon.addClass("icon");
			content.append(icon);

			var name = $("<div/>");
			name.html("More");
			name.addClass("name");
			content.append(name);

			menuItem.append(content);

			var downArrow = $("<div/>");
			downArrow.addClass("downArrow");

			menuItem.append(downArrow);

			ActionBar._leftMenu.append(menuItem);

			var separator = $("<div/>");
			separator.addClass("separator");
			ActionBar._leftMenu.append(separator);

			while(itemIndex < ActionBar._mainMenuItems.length) {
				ActionBar.MoreItems.SubItems.push(ActionBar._mainMenuItems[itemIndex]);
				itemIndex++;
			}
		}*/
    },

    layoutRightMenu: function ()
    {
        var __actionBarInstance = this;

        this._rightMenu.html("");

        var itemsWidth = this._leftMenu.width(); itemIndex = 0;

        if (this.MoreItems.SubItems.length == 0)
        {
            while ((this._actionBar.width() > itemsWidth || this.isMobile) && itemIndex < this._rightMenuItems.length)
            {
                this._rightMenu.append(this._rightMenuItems[itemIndex]);

                if (itemsWidth + this._rightMenu.width() + 20 < this._actionBar.width() || this.isMobile)
                {

                    this._rightMenuItems[itemIndex].remove();

                    var separator = $("<div/>");
                    separator.addClass("separator");
                    this._rightMenu.append(separator);

                    $(this._rightMenuItems[itemIndex]).on("click", function ()
                    {
                        __actionBarInstance.menuItemClick(this);
                    });

                    this._rightMenu.append(this._rightMenuItems[itemIndex]);

                    if ($(".icon", this._rightMenuItems[itemIndex]).attr("data-alt-src") && $(".icon", this._rightMenuItems[itemIndex]).attr("data-alt-src") != "")
                    {
                        $(this._rightMenuItems[itemIndex]).off("mouseenter mouseleave");
                        $(this._rightMenuItems[itemIndex]).hover(sourceSwap, sourceSwap);
                    }

                    itemsWidth = this._leftMenu.width() + this._rightMenu.width();
                    itemIndex++;
                }
                else
                {
                    this._rightMenuItems[itemIndex].remove();
                    break;
                }
            }
        }

        if (itemIndex < this._rightMenuItems.length)
        {
            if ($("#More", this._actionBar).length == 0)
            {
                var separator = $("<div/>");
                separator.addClass("separator");
                this._rightMenu.append(separator);

                var menuItem = $("<div/>");
                menuItem.addClass("menuItem");
                menuItem.attr("id", "More");

                var content = $("<div/>");
                content.addClass("content");

                var icon = $("<img/>");
                icon.attr("src", "images/more-icon.png");
                icon.addClass("icon");
                icon.attr("data-alt-src", "images/more-icon-hover.png");
                $(menuItem).hover(sourceSwap, sourceSwap);
                content.append(icon);

                var name = $("<div/>");
                name.html("More");
                name.addClass("name");
                content.append(name);

                menuItem.append(content);

                var downArrow = $("<div/>");
                downArrow.addClass("downArrow");

                menuItem.append(downArrow);

                $(menuItem).on("click", function ()
                {
                    __actionBarInstance.menuItemClick(this);
                });

                this._rightMenu.append(menuItem);

                var separator = $("<div/>");
                separator.addClass("separator");
                this._rightMenu.append(separator);

                if ($(".menuItem", this._rightMenu).length == 1)
                {
                    $(".separator", this._rightMenu).first().remove();
                }
            }

            while (itemIndex < this._rightMenuItems.length)
            {
                this.MoreItems.SubItems.push(this._rightMenuItems[itemIndex]);
                itemIndex++;
            }
        }
        else
        {
            var separator = $("<div/>");
            separator.addClass("separator");
            this._rightMenu.append(separator);
        }
    },

    showRightMenu: function (json)
    {
        var __actionBarInstance = this;

        if (this._rightMenu)
        {
            this._rightMenu.remove();
            this._rightMenuItems = [];
            this._rightMenuItemsJson = [];
            //delete this._rightMenu;
            this._rightMenu = null;
            this.MoreItems = [];
            this.MoreItems.SubItems = [];
            return;
        }

        this._rightMenu = $("<div/>");
        this._rightMenu.addClass("rightMenu");
        this._rightMenu.attr("id", "rightMenu");
        this._actionBar.append(this._rightMenu);

        this._rightJson = json;

        $.each(this._rightJson, function (index, value)
        {
            $.each(value, function (subIndex, val)
            {

                var json = [];
                __actionBarInstance._rightMenuItemsJson.push(json);

                $.each(val.SubItems, function (subItemIndex, subItem)
                {
                    if (!__actionBarInstance._rightMenuItemsJson[__actionBarInstance._rightMenuItemsJson.length - 1].SubItems)
                    {
                        __actionBarInstance._rightMenuItemsJson[__actionBarInstance._rightMenuItemsJson.length - 1].SubItems = [];
                    }

                    var subMenuItem = __actionBarInstance.createMenuItem(subItem, "SubItemRight" + (__actionBarInstance._rightMenuItemsJson.length - 1) + __actionBarInstance._rightMenuItemsJson[__actionBarInstance._rightMenuItemsJson.length - 1].SubItems.length);
                    __actionBarInstance._rightMenuItemsJson[__actionBarInstance._rightMenuItemsJson.length - 1].SubItems.push(subMenuItem);
                });

                var menuItem = __actionBarInstance.createMenuItem(val, "Right" + __actionBarInstance._rightMenuItems.length);

                __actionBarInstance._rightMenuItems.push(menuItem);
            });
        });

        this.layoutRightMenu();
    },

    hideRightMenu: function ()
    {
        this.hideSubMenus();

        if (this._rightMenu)
        {
            this._rightMenu.remove();
            this._rightMenuItems = [];
            this._rightMenuItemsJson = [];
            //delete this._rightMenu;
            this._rightMenu = null;
            this.MoreItems = [];
            this.MoreItems.SubItems = [];
        }
    },

    menuItemClick: function (menuItem)
    {
        if ($(menuItem).attr("disabled") === "disabled")
        {
            return;
        }

        var __actionBarInstance = this;

        var id = $(menuItem).parent().attr("id").replace("subMenu", "");

        var level = 0;
        if (!isNaN(id))
        {
            level = parseInt(id);
        }

        while (this.SubMenu.length - 1 >= level)
        {
            var identifier = this.SubMenu.length - 1;
            this.SubMenu[identifier].remove();
            this.SubMenu.pop(this.SubMenu[identifier]);
        }

        while (this._selectedMenuItem.length > 0 && this._selectedMenuItem.length > level)
        {
            var identifier = this._selectedMenuItem.length - 1;
            this._selectedMenuItem[identifier].removeClass("selected").removeClass("subSelected");

            if (this._selectedMenuItem.length == 1)
            {
                this._selectedMenuItem[identifier].prev().removeClass("selectedPrev");
                this._selectedMenuItem[identifier].next().removeClass("selectedNext");

                if ($(".menuItem", this._rightMenu).length == 1)
                {
                    $(".separator", this._leftMenu).last().removeClass("selectedPrev");
                }
            }

            if (this._selectedMenuItem[identifier].attr("id") == $(menuItem).attr("id"))
            {
                this._selectedMenuItem.pop(this._selectedMenuItem[identifier]);
                return;
            }

            this._selectedMenuItem.pop(this._selectedMenuItem[identifier]);
        }

        var SubMenu = $("<div/>");

        if (this.SubMenu.length == 0)
        {
            SubMenu.addClass("subMenu");
            $(menuItem).addClass("selected");

            $(menuItem).prev().addClass("selectedPrev");
            $(menuItem).next().addClass("selectedNext");

            if ($(".menuItem", this._rightMenu).length == 1)
            {
                $(".separator", this._leftMenu).last().addClass("selectedPrev");
            }
        }
        else
        {
            SubMenu.addClass("subSubMenu");
            $(menuItem).addClass("subSelected");
        }

        SubMenu.attr("id", "subMenu" + (this.SubMenu.length + 1));

        if (this.isMobile)
        {
            SubMenu.css({ "bottom": (parseInt($(menuItem).parent().height() - 1) * (this.SubMenu.length + 1)) + "px" });
        }
        else
        {
            SubMenu.css({ "top": (parseInt($(menuItem).parent().height() - 1) * (this.SubMenu.length + 1)) + "px" });
        }

        this.SubMenu.push(SubMenu);

        var SubItems = [];
        var Action;

        if ($(menuItem).attr("id") == "More")
        {
            SubItems = this.MoreItems.SubItems;
        }
        else
        {
            if ($(menuItem).attr("id").substring(0, 4) == "Left")
            {
                var index = parseInt($(menuItem).attr("id").replace("Left", ""));
                SubItems = this._mainMenuItemsJson[index].SubItems;
            }
            else if ($(menuItem).attr("id").substring(0, 5) == "Right")
            {
                var index = parseInt($(menuItem).attr("id").replace("Right", ""));
                SubItems = this._rightMenuItemsJson[index].SubItems;
            }
        }

        if (SubItems && (typeof SubItems != 'undefined') && SubItems.length > 0)
        {
            for (var i = 0; i < SubItems.length; i++)
            {
                $(SubItems[i]).on("click", function ()
                {
                    __actionBarInstance.menuItemClick(this);
                });
                $(SubItems[i]).removeClass("subSelected");
                if ($(menuItem).outerWidth() >= parseInt($(menuItem).css('max-width')))
                {
                    $(SubItems[i]).width($(menuItem).width());
                }

                SubMenu.append(SubItems[i]);
                if ($(".icon", SubItems[i]).attr("data-alt-src") && $(".icon", SubItems[i]).attr("data-alt-src") != "")
                {
                    $(SubItems[i]).off("mouseenter mouseleave");
                    $(SubItems[i]).hover(sourceSwap, sourceSwap);
                }
            }

            this._actionBar.append(SubMenu);

            var posLeft = ($(menuItem).offset().left - $(menuItem).parent().parent().offset().left) + ($(menuItem).outerWidth() / 2) - (SubMenu.outerWidth() / 2);

            if (posLeft < 0)
                posLeft = 0;
            else if (posLeft + SubMenu.outerWidth() > $(menuItem).parent().parent().outerWidth())
                posLeft = $(menuItem).parent().parent().outerWidth() - SubMenu.outerWidth() - (this.isMobile ? 0 : 1);

            SubMenu.css({ "left": posLeft + "px" });

            this._selectedMenuItem.push($(menuItem));
        }
        else
        {
            var onClickVal = $(menuItem).attr("skonclick");

            if (!isUndefined(onClickVal) && onClickVal !== "")
            {
                try
                {
                    var F = new Function(onClickVal);

                    retVal = (F());
                }
                catch (err)
                {
                    //alert(err.message);
                }
            }
            else
            {
                var onActionClick = $(menuItem).attr("action");
                if (!isUndefined(onActionClick) && onActionClick !== "")
                {
                    window.location.href = $(menuItem).attr("action");
                }
            }

            $(menuItem).removeClass("selected");
            $(menuItem).prev().removeClass("selectedPrev");
            $(menuItem).next().removeClass("selectedNext");
            /*closing child level after 1 sec*/
            if (level > 0)
            {
                setTimeout(function ()
                {
                    __actionBarInstance.hideSubMenus();
                }, 200);
            }

        }
    },

    createMenuItem: function (json, id)
    {
        var menuItem = $("<div/>");
        menuItem.addClass("menuItem");
        menuItem.attr("id", id);
        menuItem.attr(this.skActionItemIdAttribute, json.Id);
        menuItem.attr("action", json.Action);
        if (!isUndefined(json["OnClick"]))
        {
            menuItem.attr("skonclick", json.OnClick);

        }

        if ((typeof json.Tooltip) !== 'undefined')
        {
            menuItem.attr("title", json.Tooltip);
        }

        var content = $("<div/>");
        content.addClass("content");

        var icon;
        //icon.attr("src", "images/05.jpg"); // 
        if (!isUndefined(json.Css) && json.Css !== "")
        {
            icon = $("<div/>");
            menuItem.addClass(json.Css);
            icon.addClass("icon");
            content.append(icon);
        }
        else
        {
            icon = $("<img/>");
            icon.attr("src", json.Image);
            icon.addClass("icon");
            content.append(icon);
            if ((typeof json.HoverImage) !== 'undefined')
            {
                icon.attr("data-alt-src", json.HoverImage);
                $(menuItem).hover(sourceSwap, sourceSwap);
            }
        }

        var name = $("<div/>");
        name.text(json.Text);
        name.addClass("name");
        content.append(name);

        menuItem.append(content);

        if (json.SubItems.length > 0)
        {
            var downArrow = $("<div/>");
            downArrow.addClass("downArrow");

            menuItem.append(downArrow);
        }

        if (!isUndefined(json.Visible) && json.Visible === false)
        {
            menuItem.hide();
        }

        if (!isUndefined(json.Enable) && json.Enable === false)
        {
            menuItem.addClass("menuItemDisabled");
            menuItem.attr("disabled", "disabled");
        }

        return menuItem;
    },

    resize: function ()
    {
        this.hideSubMenus();
        if (this._parent.width() <= 320 && this._allowMobileUX)
        {
            this.isMobile = true;
            this._actionBar.html("");
            this._actionBar.remove();
            this._actionBar = null;
            this.init(this._json, this._parent.attr("id"), this._allowMobileUX);
        }
        else
        {
            this.isMobile = false;
            this._actionBar.html("");
            this._actionBar.remove();
            this._actionBar = null;
            this.init(this._json, this._parent.attr("id"), this._allowMobileUX);
        }

        if (this._rightMenu)
        {
            this._rightMenu.remove();
            this._rightMenuItems = [];
            this._rightMenuItemsJson = [];
            //delete this._rightMenu;
            this._rightMenu = null;
            this.MoreItems = [];
            this.MoreItems.SubItems = [];

            this.showRightMenu(this._rightJson);
        }


    },

    checkClick: function (event)
    {
        var target = $(event.target);

        if (target.closest(".actionBar").length == 0)
        {
            this.hideSubMenus();
        }
    },

    hideSubMenus: function ()
    {
        var level = 0;

        while (this.SubMenu.length - 1 >= level)
        {
            var identifier = this.SubMenu.length - 1;
            this.SubMenu[identifier].remove();
            this.SubMenu.pop(this.SubMenu[identifier]);
        }

        while (this._selectedMenuItem.length > 0 && this._selectedMenuItem.length > level)
        {
            var identifier = this._selectedMenuItem.length - 1;
            this._selectedMenuItem[identifier].removeClass("selected").removeClass("subSelected");

            if (this._selectedMenuItem.length == 1)
            {
                this._selectedMenuItem[identifier].prev().removeClass("selectedPrev");
                this._selectedMenuItem[identifier].next().removeClass("selectedNext");

                if ($(".menuItem", this._rightMenu).length == 1)
                {
                    $(".separator", this._leftMenu).last().removeClass("selectedPrev");
                }
            }

            this._selectedMenuItem.pop(this._selectedMenuItem[identifier]);
        }
    },

    getMenuItem: function (actionItem)
    {
        var __actionBarInstance = this;
        var actionmenuItem;
        /* looping through main menu items*/
        $.each(this._mainMenuItems, function (index, menuItem)
        {
            if (menuItem.attr(__actionBarInstance.skActionItemIdAttribute) === actionItem.id)
            {
                actionmenuItem = menuItem;
                return false;
            }
        });
        if (isUndefined(actionmenuItem))
        {
            /* looping through child items*/
            $.each(this._mainMenuItemsJson, function (subIndex, items)
            {
                var exitloop;
                if (items.SubItems && $.isArray([items.SubItems]))
                {
                    $.each(items.SubItems, function (subItemIndex, subItem)
                    {
                        if (subItem.attr(__actionBarInstance.skActionItemIdAttribute) === actionItem.id)
                        {
                            actionmenuItem = subItem;
                            exitloop = false;
                            return false;
                        }
                    });
                }

                if (exitloop === false)
                {
                    return false;
                }
            });
        }

        return actionmenuItem;
    },

    updateJSONData: function (id, newValue, property)
    {
        $.each(this._json, function (i, jsonItem)
        {
            var action = jsonItem[Object.keys(jsonItem)[0]];
            var updated = true;
            if (action.Id === id)
            {
                action[property] = newValue;
                return false;
            }
            $.each(action.SubItems, function (i, subJsonItem)
            {
                if (subJsonItem.Id === id)
                {
                    subJsonItem[property] = newValue;
                    updated = false;
                    return false;
                }
            });

            if (updated === false)
            {
                return false;
            }
        });
    },

    setVisibilityToActionItem: function (actionItem, isVisible)
    {
        /* update the collection */
        this.updateJSONData(actionItem.id, isVisible, "Visible");
        /* re-intializing the action bar due to child menus layout gets messed up when visibility is changed */
        this.resize();
    },

    setDisableToActionItem: function (actionItem, isEnable)
    {
        var actionmenuItem = this.getMenuItem(actionItem);
        if (!isUndefined(actionmenuItem))
        {
            /* update the collection */
            this.updateJSONData(actionItem.id, isEnable, "Enable");

            /* update enable in the dom */
            if (isEnable === true)
            {
                actionmenuItem.removeAttr("disabled");
                actionmenuItem.removeClass("menuItemDisabled");
                actionmenuItem.removeClass("selected").removeClass("subSelected");
            }
            if (isEnable === false)
            {
                actionmenuItem.addClass("menuItemDisabled");
                actionmenuItem.attr("disabled", "disabled");
            }
        }

    },

    setTextToActionItem: function (actionItem, newText)
    {
        var actionmenuItem = this.getMenuItem(actionItem);
        if (!isUndefined(actionmenuItem))
        {
            /* update the collection */
            this.updateJSONData(actionItem.id, newText, "Text");

            /* update text in the dom */
            actionmenuItem.find(".name").text(newText);
        }
    }
};

$(function ()
{
    $(window).resize(function ()
    {
        $.each(actionBarCollection, function (index, actionBarInstance)
        {
            actionBarInstance.resize();
        });
    });

    $(window).on("click", function (event)
    {
        $.each(actionBarCollection, function (index, actionBarInstance)
        {
            actionBarInstance.checkClick(event);
        });
    });
});


function isUndefined(obj)
{
    return ((typeof obj === "undefined") || (obj == null));
}