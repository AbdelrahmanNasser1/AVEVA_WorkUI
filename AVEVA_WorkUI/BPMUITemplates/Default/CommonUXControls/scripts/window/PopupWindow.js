/*
 * Popup Window Standard v1.0
 * 
 * Copyright © 2014 Vectorform
 * All rights reserved.
 * 
 */

function PopupWindow(id, url, html, maxWidth, maxHeight) {
	this._id = id;
	this._maxWidth = (typeof maxWidth == 'undefined') ? 400 : maxWidth;
	this._maxHeight = (typeof maxHeight == 'undefined') ? 400 : maxHeight;
	this._originalWidth = this._maxWidth;
	this._originalHeight = this._maxHeight;

	this._url = ((typeof url == 'undefined') || url == null) ? null : url;
	this._html = ((typeof html == 'undefined') || html == null) ? "" : html;

	/*** Popup Background ***/

	this._pWindowBg = $("<div/>");
	this._pWindowBg.attr("id", this._id);
	this._pWindowBg.attr("class", "pWindowBg");

	/*** Popup ***/

	this._pWindow = $("<div/>");
	this._pWindow.attr("id", this._id + "Sta");
	this._pWindow.attr("class", "pWindow");

	if (this._url != null)
		this._pWindow.load(this._url);
	else
		this._pWindow.html(this._html);

	$(this.pWindowBg).append(this._pWindow);

	var pWindow = this;

	$(window).resize(function() {
		pWindow.resize(false);
	});

	this.isVisible = false;
}

PopupWindow.prototype.resize = function(animate) {
	if(this.isVisible) {
		this.docWidth = $(document).width();
		this.docHeight = $(document).height();
		this.docScrollTop = $(document).scrollTop();
		this.docScrollLeft = $(document).scrollLeft();
		this.winScrollHeight = $(window).height();
		this.winScrollWidth = $(window).width();
		this.docScrollWidth = this.docWidth - this.winScrollWidth;
		this.docScrollHeight = this.docHeight - this.winScrollHeight;

		var maxPossibleWidth = Math.min(this._maxWidth, this.docWidth - this.docScrollWidth - 50);
		var maxPossibleHeight = Math.min(this._maxHeight, this.docHeight - this.docScrollHeight - 50);
		
		$(this._pWindow).animate({ 
			"width" : maxPossibleWidth + "px", 
			"height" : maxPossibleHeight + "px",
			"left" : ((this.docWidth - maxPossibleWidth - this.docScrollWidth) / 2) + "px", 
			"top" : ((this.docHeight - maxPossibleHeight - this.docScrollHeight) / 2) + "px" 
		}, (animate) ? 500 : 0);

		$(this._pWindowBg).animate({
			"left": this.docScrollLeft + "px",
			"top": this.docScrollTop + "px",
			"width": (this.docWidth - this.docScrollWidth) + "px",
			"height": (this.docHeight - this.docScrollHeight) + "px"
		}, (animate) ? 500 : 0);

		$("body").addClass("pBodyFixed").animate({ 
			"top": (-this.docScrollTop) + "px",
			"left": (-this.docScrollLeft) + "px"
		}, (animate) ? 500 : 0);
	}
};

PopupWindow.prototype.setHTML = function(html) {
	this._url = null;
	this._html = ((typeof html == 'undefined') || html == null) ? "" : html;
	this._pWindow.html("");
	this._pWindow.html(this._html);
};

PopupWindow.prototype.setURL = function(url) {
	this._html = null;
	this._url = ((typeof url == 'undefined') || url == null) ? null : url;
	this._pWindow.html("");
	if (this._url != null)
		this._pWindow.load(this._url);
};

PopupWindow.prototype.show = function(callbackAction) {
	var _parent = this;
	this._callbackAction = ((typeof callbackAction == 'undefined') || callbackAction == null) ? null : callbackAction;

	$("body").append(this._pWindowBg);
	
	this.docWidth = $(document).width();
	this.docHeight = $(document).height();
	this.docScrollTop = $(document).scrollTop();
	this.docScrollLeft = $(document).scrollLeft();
	this.winScrollHeight = $(window).height();
	this.winScrollWidth = $(window).width();
	this.docScrollWidth = this.docWidth - this.winScrollWidth;
	this.docScrollHeight = this.docHeight - this.winScrollHeight;

	var maxPossibleWidth = Math.min(this._maxWidth, this.docWidth - this.docScrollWidth - 50);
	var maxPossibleHeight = Math.min(this._maxHeight, this.docHeight - this.docScrollHeight - 50);
	
	$(this._pWindow).css({ 
		"width" : maxPossibleWidth + "px", 
		"height" : maxPossibleHeight + "px" 
	});

	$(this._pWindow).css({ 
		"left" : ((this.docWidth - maxPossibleWidth - this.docScrollWidth) / 2) + "px", 
		"top" : ((this.docHeight - maxPossibleHeight - this.docScrollHeight) / 2) + "px" 
	});

	$(this._pWindowBg).css({
		"left": this.docScrollLeft + "px",
		"top": this.docScrollTop + "px",
		"width": (this.docWidth - this.docScrollWidth) + "px",
		"height": (this.docHeight - this.docScrollHeight) + "px",
		"opacity": "0.0"
	});

	if(this.docScrollWidth > 0) 
		$("html").addClass("pHTMLFixedX");

	if(this.docScrollHeight > 0) 
		$("html").addClass("pHTMLFixedY");

	$("body").addClass("pBodyFixed").css({ 
		"top": (-this.docScrollTop) + "px",
		"left": (-this.docScrollLeft) + "px"
	});

	$(this._pWindowBg).append(this._pWindow);

	$(this._pWindowBg).show().animate({
		"opacity": "1.0"
	}, 700, function() {
		_parent.isVisible = true;
	});

	$(this._pWindow).fadeIn(700);

	$(this._pWindowBg).click(function(e) {
		_parent.hide();
	});

	$(this._pWindow).click(function(e) {
		e.stopPropagation();
	});
};

PopupWindow.prototype.hide = function() {
	var _parent = this;
	$(this._pWindow).fadeOut(700);

	$(this._pWindowBg).animate({
		"opacity": "0.0"
	}, 700, function () {
		$(this).html("");
		$(this).hide();
		$(this).remove();
		$("html").removeClass("pHTMLFixedX").removeClass("pHTMLFixedY");

		$("body").removeClass("pBodyFixed").css({
			"top": "",
			"left": ""
		});

		$("body,html").scrollTop(_parent.docScrollTop);
		$("body,html").scrollLeft(_parent.docScrollLeft);
	
		_parent.isVisible = false;

		_parent._maxWidth = _parent._originalWidth;
		_parent._maxHeight = _parent._originalHeight;

		if (typeof _parent._callbackAction != 'undefined' && _parent._callbackAction != null) {
			_parent._callbackAction();
		}
	});
};

PopupWindow.prototype.setSize = function(maxWidth, maxHeight) {
	this._maxWidth = (typeof maxWidth == 'undefined') ? this._maxWidth : maxWidth;
	this._maxHeight = (typeof maxHeight == 'undefined') ? this._maxHeight : maxHeight;

	this.resize(true);
};