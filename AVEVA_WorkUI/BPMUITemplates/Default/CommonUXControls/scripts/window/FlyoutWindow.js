/*
 * Popup Window Flyout v1.0
 * 
 * Copyright © 2014 Vectorform
 * All rights reserved.
 * 
 */

function FlyoutWindow(id, url, html, maxWidth) {
	this._id = id;
	this._maxWidth = (typeof maxWidth == 'undefined') ? 400 : maxWidth;
	this._url = ((typeof url == 'undefined') || url == null) ? null : url;
	this._html = ((typeof html == 'undefined') || html == null) ? "" : html;

	/*** Popup Background ***/

	this._fWindowBg = $("<div/>");
	this._fWindowBg.attr("id", this._id);
	this._fWindowBg.attr("class", "fWindowBg");

	/*** Popup ***/

	this._fWindow = $("<div/>");
	this._fWindow.attr("id", this._id + "Fly");
	this._fWindow.attr("class", "fWindow");
	
	if (this._url != null)
		this._fWindow.load(this._url);
	else
		this._fWindow.html(this._html);

	$(this.fWindowBg).append(this._fWindow);

	var fWindow = this;

	$(window).resize(function() {
		fWindow.resize();
	});

	this.isVisible = false;
}

FlyoutWindow.prototype.resize = function() {
	if(this.isVisible) {
		this.docWidth = $(document).width();
		this.docHeight = $(document).height();
		this.docScrollTop = $(document).scrollTop();
		this.docScrollLeft = $(document).scrollLeft();
		this.winScrollHeight = $(window).height();
		this.winScrollWidth = $(window).width();
		this.docScrollWidth = this.docWidth - this.winScrollWidth;
		this.docScrollHeight = this.docHeight - this.winScrollHeight;

		var maxPossibleWidth = Math.min(this._maxWidth, this.docWidth - this.docScrollWidth);
		var maxPossibleHeight = this.docHeight - this.docScrollHeight;
		
		$(this._fWindow).css({ "width" : maxPossibleWidth + "px", "height" : maxPossibleHeight + "px" });

		$(this._fWindow).css({ 
			"left" : (this.docWidth - maxPossibleWidth - this.docScrollWidth) + "px", 
			"top" : "0px" 
		});

		$(this._fWindowBg).css({
			"left": this.docScrollLeft + "px",
			"top": this.docScrollTop + "px",
			"width": (this.docWidth - this.docScrollWidth) + "px",
			"height": (this.docHeight - this.docScrollHeight) + "px"
		});

		$("body").addClass("fBodyFixed").css({ 
			"top": (-this.docScrollTop) + "px",
			"left": (-this.docScrollLeft) + "px"
		});
	}
};

FlyoutWindow.prototype.setHTML = function(html) {
	this._url = null;
	this._html = ((typeof html == 'undefined') || html == null) ? "" : html;
	this._fWindow.html("");
	this._fWindow.html(this._html);
};

FlyoutWindow.prototype.setURL = function(url) {
	this._html = null;
	this._url = ((typeof url == 'undefined') || url == null) ? null : url;
	this._fWindow.html("");
	if (this._url != null)
		this._fWindow.load(this._url);
};

FlyoutWindow.prototype.show = function(callbackAction) {
	var _parent = this;
	this._callbackAction = ((typeof callbackAction == 'undefined') || callbackAction == null) ? null : callbackAction;
	
	$("body").append(this._fWindowBg);
	
	this.docWidth = $(document).width();
	this.docHeight = $(document).height();
	this.docScrollTop = $(document).scrollTop();
	this.docScrollLeft = $(document).scrollLeft();
	this.winScrollHeight = $(window).height();
	this.winScrollWidth = $(window).width();
	this.docScrollWidth = this.docWidth - this.winScrollWidth;
	this.docScrollHeight = this.docHeight - this.winScrollHeight;

	var maxPossibleWidth = Math.min(this._maxWidth, this.docWidth - this.docScrollWidth);
	var maxPossibleHeight = this.docHeight - this.docScrollHeight;
	
	$(this._fWindow).css({ "width" : maxPossibleWidth + "px", "height" : maxPossibleHeight + "px" });

	$(this._fWindow).css({ 
		"left" : (this.docWidth + maxPossibleWidth - this.docScrollWidth) + "px", 
		"top" : "0px" 
	});

	$(this._fWindowBg).css({
		"left": this.docScrollLeft + "px",
		"top": this.docScrollTop + "px",
		"width": (this.docWidth - this.docScrollWidth) + "px",
		"height": (this.docHeight - this.docScrollHeight) + "px",
		"opacity": "0.0"
	});

	if(this.docScrollWidth > 0) 
		$("html").addClass("fHTMLFixedX");

	if(this.docScrollHeight > 0) 
		$("html").addClass("fHTMLFixedY");

	$("body").addClass("fBodyFixed").css({ 
		"top": (-this.docScrollTop) + "px",
		"left": (-this.docScrollLeft) + "px"
	});

	$(this._fWindowBg).append(this._fWindow);

	$(this._fWindowBg).show().animate({
		"opacity": "1.0"
	}, 700, function () {
		_parent.isVisible = true;
	});

	$(this._fWindow).show().animate({
		"left": (_parent.docWidth - $(_parent._fWindow).width() - _parent.docScrollWidth) + "px"
	}, 1000);

	$(this._fWindowBg).click(function(e) {
		_parent.hide();
	});

	$(this._fWindow).click(function(e) {
		e.stopPropagation();
	});
};

FlyoutWindow.prototype.hide = function() {
	var _parent = this;
	$(this._fWindow).animate({
		"left": (_parent.docWidth + $(_parent._fWindow).width() - _parent.docScrollWidth) + "px"
	}, 1000, function() {
		$(this).hide();
	});

	$(this._fWindowBg).animate({
		"opacity": "0.0"
	}, 700, function () {
		$(this).hide();
		$(this).remove();
		$("html").removeClass("fHTMLFixedX").removeClass("fHTMLFixedY");

		$("body").removeClass("fBodyFixed").css({
			"top": "",
			"left": ""
		});

		$("body,html").scrollTop(_parent.docScrollTop);
		$("body,html").scrollLeft(_parent.docScrollLeft);
	
		_parent.isVisible = false;

		if (typeof _parent._callbackAction != 'undefined' && _parent._callbackAction != null) {
			_parent._callbackAction();
		}
	});
};