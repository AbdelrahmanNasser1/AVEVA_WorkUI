/*
 * Context Menu v1.0
 * 
 * Copyright © 2014 Vectorform
 * All rights reserved.
 * 
 */

var ContextMenu = {
	init: function() {
		if ($("#_contextMenu", $("body")).length > 0) {
			$("#_contextMenu", $("body")).html("");
			$("#_contextMenu", $("body")).remove();
		}

		this._contextMenu = $("<div/>");
		this._contextMenu.attr("id", "_contextMenu");
		this.isVisible = false;

		$("body").append(this._contextMenu);

		$(window).resize(function() {
			ContextMenu.resize();
		});

		$(window).on("click", function(event) {
			ContextMenu.checkClick(event);
		});
	},

	show: function(json, parent) {
		this.menuItems = [];
		this.parent = parent;

		this._arrow = $("<div/>");
		this._arrow.attr("id", "arrow");
		this._arrow.addClass("arrowUp");
		
		var arrowInner = $("<div/>");
		this._arrow.append(arrowInner);

		this._contextMenu.append(this._arrow);

		this._contextMenuMain = $("<div/>");
		this._contextMenuMain.addClass("_contextMenuMain");
		this._contextMenu.append(this._contextMenuMain);

		this._menuContent = $("<div/>");
		this._menuContent.addClass("_menuContent");
		this._contextMenuMain.append(this._menuContent);

		$.each(json, function(index, value) {
			var contextMenuItem = new ContextMenuItem();
			contextMenuItem.SetIconPath(json[index].IconPath);
			contextMenuItem.SetName(json[index].Name);
			contextMenuItem.SetParentName(json[index].ParentName);
			contextMenuItem.SetProperties(json[index].Properties);
			contextMenuItem.SetType(json[index].Type);
			contextMenuItem.SetUri(json[index].Uri);
			contextMenuItem.SetValue(json[index].Value);

			if((typeof json[index].Tooltip) !== 'undefined')
				contextMenuItem.SetTooltip(json[index].Tooltip);

			if (json[index].ParentName == null || json[index].ParentName == '') {
				ContextMenu.menuItems.push(contextMenuItem);
			}
			else {
				result = $.grep(ContextMenu.menuItems, function(item) {
					return item.GetValue() === json[index].ParentName;
				});

				if (result != null && result.length > 0) {
					result[0].subItems.push(menuItem);
				}
			}
		});

		for(var i = 0; i < this.menuItems.length; i++) {
			var menuItem = $("<div/>");
			menuItem.attr("id", "_contextMenuItem" + i);
			menuItem.addClass("menuItem");

			if (this.menuItems[i].GetTooltip() != '') {
				menuItem.attr("title", this.menuItems[i].GetTooltip());
			}

			var icon = $("<img/>");
			icon.attr("src", this.menuItems[i].GetIconPath());
			icon.addClass("icon");
			menuItem.append(icon);

			var name = $("<div/>");
			name.html(this.menuItems[i].GetName());
			name.addClass("name");
			menuItem.append(name);

			menuItem.on("click", function(){
				var id = $(this).attr("id").replace("_contextMenuItem", "");
				window.location.href = ContextMenu.menuItems[parseInt(id)].GetUri();
			});

			ContextMenu._menuContent.append(menuItem);
		};

		var docWidth = $(document).width();

		this._contextMenu.show();

		//var docWidth = $(document).width();
		var docHeight = $(document).height();
		var docScrollTop = $(window).scrollTop();
		var docScrollLeft = $(window).scrollLeft();
		var winScrollHeight = $(window).height();
		var winScrollWidth = $(window).width();
		var docScrollWidth = docWidth - winScrollWidth;
		var docScrollHeight = docHeight - winScrollHeight;

		var posLeft = this.parent.offset().left + (this.parent.width() / 2) - (this._contextMenu.width() / 2);
		var arrowPosLeft = this.parent.offset().left - posLeft + (this.parent.width() / 2);
		var posTop = this.parent.offset().top + this.parent.height() + 5;

		if (this.parent.offset().left + (this.parent.width() / 2) + (this._contextMenu.width() / 2) > docScrollLeft + winScrollWidth)
		{
			var prevPosLeft = posLeft;
			posLeft = Math.max(winScrollWidth + docScrollLeft - this._contextMenu.width(),
				this.parent.offset().left - this._contextMenu.width() + 20);

			arrowPosLeft = arrowPosLeft + prevPosLeft - posLeft;
		}
		
		if (posLeft < 0) 
		{
			var prevPosLeft = posLeft;
			posLeft = 0;

			arrowPosLeft = arrowPosLeft + prevPosLeft - posLeft;
		}

		if (arrowPosLeft > this._contextMenu.width() - 20) {
			arrowPosLeft = this._contextMenu.width() - 20;
		}

		if (this.parent.offset().top + this.parent.height() + this._contextMenu.height() > docScrollTop + winScrollHeight)
		{
			if (this.parent.offset().top - this._contextMenu.height() > 0)
			{
				posTop = this.parent.offset().top - this._contextMenu.height();
				this._contextMenuMain.addClass("alignTop");
				this._arrow.addClass("arrowDown").removeClass("arrowUp");
			}
			else {
				this._contextMenuMain.removeClass("alignTop");
				this._arrow.addClass("arrowUp").removeClass("arrowDown");
			}
		}
		else {
			this._contextMenuMain.removeClass("alignTop");
			this._arrow.addClass("arrowUp").removeClass("arrowDown");
		}

		if (this._contextMenu.width() > docWidth || this._contextMenu.width() > winScrollWidth) {
			this._contextMenu.addClass("vertical");
			posLeft = this.parent.offset().left + (this.parent.width() / 2) - (this._contextMenu.width() / 2);
			arrowPosLeft = this.parent.offset().left - posLeft + (this.parent.width() / 2);

			if (this.parent.offset().left + (this.parent.width() / 2) + (this._contextMenu.width() / 2) > docScrollLeft + winScrollWidth)
			{
				var prevPosLeft = posLeft;
				posLeft = Math.max(winScrollWidth + docScrollLeft - this._contextMenu.width(),
					this.parent.offset().left - this._contextMenu.width() + 20);

				arrowPosLeft = arrowPosLeft + prevPosLeft - posLeft;
			}

			if (arrowPosLeft > this._contextMenu.width() - 20) {
				arrowPosLeft = this._contextMenu.width() - 20;
			}
		}

		this._contextMenu.css({
			"left": posLeft + "px",
			"top": posTop + "px"
		});

		this._arrow.css({
			"left": arrowPosLeft + "px"
		});

		this._contextMenu.animate({
			"opacity": 1.0
		}, 500, function() {
			ContextMenu.isVisible = true;
		});
	},

	hide: function() {
		this._contextMenu.animate({
			"opacity": 0.0
		}, 500, function() {
			$(this).hide();
			$(this).html("");
			ContextMenu.isVisible = false;
		});
	},

	resize: function() {
		if (this.isVisible) {
			this._contextMenu.hide();
			this._contextMenu.removeClass("vertical");
			var docWidth = $(document).width();
			
			this._contextMenu.show();
			
			var docHeight = $(document).height();
			var docScrollTop = $(window).scrollTop();
			var docScrollLeft = $(window).scrollLeft();
			var winScrollHeight = $(window).height();
			var winScrollWidth = $(window).width();
			var docScrollWidth = docWidth - winScrollWidth;
			var docScrollHeight = docHeight - winScrollHeight;

			var posLeft = this.parent.offset().left + (this.parent.width() / 2) - (this._contextMenu.width() / 2);
			var arrowPosLeft = this.parent.offset().left - posLeft + (this.parent.width() / 2);
			var posTop = this.parent.offset().top + this.parent.height() + 5;

			if (this.parent.offset().left + (this.parent.width() / 2) + (this._contextMenu.width() / 2) > docScrollLeft + winScrollWidth)
			{
				var prevPosLeft = posLeft;
				posLeft = Math.max(winScrollWidth + docScrollLeft - this._contextMenu.width(),
					this.parent.offset().left - this._contextMenu.width() + 20);

				arrowPosLeft = arrowPosLeft + prevPosLeft - posLeft;
			}
			
			if (posLeft < 0) 
			{
				var prevPosLeft = posLeft;
				posLeft = 0;

				arrowPosLeft = arrowPosLeft + prevPosLeft - posLeft;
			}

			if (arrowPosLeft > this._contextMenu.width() - 20) {
				arrowPosLeft = this._contextMenu.width() - 20;
			}

			if (this.parent.offset().top + this.parent.height() + this._contextMenu.height() > docScrollTop + winScrollHeight)
			{
				if (this.parent.offset().top - this._contextMenu.height() > 0)
				{
					posTop = this.parent.offset().top - this._contextMenu.height();
					this._contextMenuMain.addClass("alignTop");
					this._arrow.addClass("arrowDown").removeClass("arrowUp");
				}
				else {
					this._contextMenuMain.removeClass("alignTop");
					this._arrow.addClass("arrowUp").removeClass("arrowDown");
				}
			}
			else {
				this._contextMenuMain.removeClass("alignTop");
				this._arrow.addClass("arrowUp").removeClass("arrowDown");
			}

			if (this._contextMenu.width() > docWidth || this._contextMenu.width() > winScrollWidth) {
				this._contextMenu.addClass("vertical");
				posLeft = this.parent.offset().left + (this.parent.width() / 2) - (this._contextMenu.width() / 2);
				arrowPosLeft = this.parent.offset().left - posLeft + (this.parent.width() / 2);

				if (this.parent.offset().left + (this.parent.width() / 2) + (this._contextMenu.width() / 2) > docScrollLeft + winScrollWidth)
				{
					var prevPosLeft = posLeft;
					posLeft = Math.max(winScrollWidth + docScrollLeft - this._contextMenu.width() - (docScrollHeight > 0 ? 20 : 0),
						this.parent.offset().left - this._contextMenu.width() + 20);

					arrowPosLeft = arrowPosLeft + prevPosLeft - posLeft;
				}

				if (arrowPosLeft > this._contextMenu.width() - 20) {
					arrowPosLeft = this._contextMenu.width() - 20;
				}
			}

			this._contextMenu.css({
				"left": posLeft + "px",
				"top": posTop + "px"
			});

			this._arrow.css({
				"left": arrowPosLeft + "px"
			});
		}
	},

	checkClick: function(event) {
		if (this.isVisible) {
			var target = $(event.target);
			if (target.closest("#_contextMenu").length == 0) {
				this.hide();
			}
		}
	}
};

$(function() {
	ContextMenu.init();
});