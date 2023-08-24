/*
 * Popup Window MessageBox v1.0
 * 
 * Copyright © 2014 Vectorform
 * All rights reserved.
 * 
 */

var MessageBox = {
	init: function() {
		this._message = "";
		
		this._messageBoxBg = $("<div/>");
		this._messageBoxBg.addClass("messageBoxBg");

		this._messageBox = $("<div/>");
		this._messageBox.attr("id", "messageBox");

		this._messageBoxBg.append(this._messageBox);

		$("body").append(this._messageBoxBg);

		$(window).resize(function() {
			MessageBox.resize();
		});
	},

	show: function(message, header, category, okButtonText, okButtonCallback, synopsis, cancelButtonText, cancelButtonCallback) {
		
		this._messageBox.html("");

		this._messageTypeStrip = $("<div/>");
		this._messageTypeStrip.addClass("strip");

		switch (category.toLowerCase())
		{
			case "confirmation": {
				this._messageTypeStrip.addClass("confirm");
				break;
			}
			case "notification": {
				this._messageTypeStrip.addClass("notification");
				break;
			}
			case "warning": {
				this._messageTypeStrip.addClass("warning");
				break;
			}
			case "error": {
				this._messageTypeStrip.addClass("error");
				break;
			}
		
		}
		this._messageTypeStrip.addClass("");
		this._messageBox.append(this._messageTypeStrip);

		this._messageMain = $("<div/>");
		this._messageMain.addClass("messageMain");
		this._messageBox.append(this._messageMain);

		if (this._messageMain.height() == 0)
		{
			this._messageMain.css({ "height": (this._messageMain.parent().height() - 36) + "px" });
		}

		this._messageDiv = $("<div/>");
		this._messageDiv.addClass("messageDiv");
		this._messageMain.append(this._messageDiv);

		this._messageContent = $("<div/>");
		this._messageContent.addClass("messageContent");
		this._messageDiv.append(this._messageContent);

		if (this._messageContent.css("min-width") == "0px")
		{
			this._messageContent.css({ 
				"min-width": (this._messageContent.parent().width() - 280) + "px",
				"max-width": (this._messageContent.parent().width() - 280) + "px"
			});
		}

		this._header = $("<div/>");
		this._header.html(header);
		this._header.addClass("messageHeader");
		this._messageContent.append(this._header);

		this._message = $("<div/>");
		this._message.html(message);
		this._message.addClass("message");
		this._messageContent.append(this._message);

		this._separator = $("<div/>");
		this._separator.addClass("separator");
		this._messageDiv.append(this._separator);

		this._buttonDiv = $("<div/>");
		this._buttonDiv.addClass("buttonDiv");
		this._messageDiv.append(this._buttonDiv);

		if (typeof cancelButtonText != 'undefined' && cancelButtonText != null) {
			this._cancelButton = $("<button>" + ((typeof cancelButtonText == 'undefined') ? "cancel" : cancelButtonText) + "</button>");
			this._cancelButtonCallback = cancelButtonCallback;
			this._cancelButton.addClass("cancelButton");
			this._cancelButton.click(function(e) {
				if (typeof MessageBox._cancelButtonCallback != 'undefined' && MessageBox._cancelButtonCallback != null) {
					MessageBox._cancelButtonCallback();
				}
				MessageBox.hide();
			});
			this._buttonDiv.append(this._cancelButton);
		}

		this._okButton = $("<button>" + ((typeof okButtonText == 'undefined' || okButtonText == null) ? "ok" : okButtonText) + "</button>");
		this._okButtonCallback = okButtonCallback;
		this._okButton.addClass("okButton");
		this._okButton.click(function(e) {
			if (typeof MessageBox._okButtonCallback != 'undefined' && MessageBox._okButtonCallback != null) {
				MessageBox._okButtonCallback();
			}
			MessageBox.hide();
		});
		this._buttonDiv.append(this._okButton);

		if ((typeof synopsis != 'undefined') && synopsis != null) {
			this._synopsis = $("<div/>");
			this._synopsis.addClass("synopsis");
			this._synopsis.html(synopsis);
			this._messageBoxBg.append(this._synopsis);

			this._synopsisCloseBtn = $("<button/>");
			this._synopsisCloseBtn.addClass("synopsisCloseBtn");
			this._synopsis.append(this._synopsisCloseBtn);

			this._synopsisCLeft = $("<div class=\"left\"/>");
			this._synopsisCloseBtn.append(this._synopsisCLeft);

			this._synopsisCRight = $("<div class=\"right\"/>");
			this._synopsisCloseBtn.append(this._synopsisCRight);

			if ($(".synopsisBtn", this._messageBox).length > 0) {
				this._synopsisLink = $(".synopsisBtn", this._messageBox);
			}
			else {
				this._synopsisLink = $("<a/>");
				this._synopsisLink.attr("href", "#");
				this._synopsisLink.append("Click here for synopsis");
				this._message.append("&nbsp;").append(this._synopsisLink);
			}

			this._synopsisLink.click(function(e) {
				MessageBox.toggleSynopsis();
			});

			this._synopsisCloseBtn.click(function(e) {
				MessageBox.toggleSynopsis();
			});
		}

		this._messageBoxBg.show();

		var docWidth = $(document).width();
		var docHeight = $(document).height();
		var docScrollTop = $(window).scrollTop();
		var docScrollLeft = $(window).scrollLeft();
		var winScrollHeight = $(window).height();
		var winScrollWidth = $(window).width();
		var docScrollWidth = docWidth - winScrollWidth;
		var docScrollHeight = docHeight - winScrollHeight;

		this._messageBox.css({ 
			"left": (((docWidth - docScrollWidth) / 2) + docScrollLeft - (this._messageBox.width() / 2)) + "px", 
			"top": (((docHeight - docScrollHeight) / 2) + docScrollTop - (this._messageBox.height() / 2)) + "px"
		});

		this._messageBoxBg.animate({
			"opacity": 1.0
		}, 500);
	},

	hide: function() {
		this._messageBoxBg.animate({
			"opacity": 0.0
		}, 500, function() {
			$(this).hide();
			MessageBox._messageBox.html("");
			if (MessageBox._synopsis != null) {
				MessageBox._synopsis.remove();
				MessageBox._synopsis = null;
			}
		});
	},

	resize: function () {
		var docWidth = $(document).width();
		var docHeight = $(document).height();
		var docScrollTop = $(window).scrollTop();
		var docScrollLeft = $(window).scrollLeft();
		var winScrollHeight = $(window).height();
		var winScrollWidth = $(window).width();
		var docScrollWidth = docWidth - winScrollWidth;
		var docScrollHeight = docHeight - winScrollHeight;

		if ((typeof this._synopsis != 'undefined') && this._synopsis != null) {
			if(this._synopsis.height() == 0) {
				this._messageBox.css({ 
					"left": (((docWidth - docScrollWidth) / 2) + docScrollLeft - (this._messageBox.width() / 2)) + "px", 
					"top": (((docHeight - docScrollHeight) / 2) + docScrollTop - (this._messageBox.height() / 2)) + "px"
				});
			}
			else {
				this._synopsis.css({
					"height": (MessageBox._messageBoxBg.height() - MessageBox._messageBox.height() - 60) + "px"
				});
			}
		}
	},

	toggleSynopsis: function() {
		if (MessageBox._synopsis.height() == 0 || MessageBox._synopsis.css("display") == "none") {
			//MessageBox._messageBox.animate({
			//	"top": "60px"
			//}, 500, function() {
				MessageBox._synopsis.css({ "top" : (MessageBox._messageBox.offset().top + MessageBox._messageBox.height()) + "px", "height": "0px", "display" : "block" });

				MessageBox._synopsis.animate({
					"height": (MessageBox._messageBoxBg.height() - MessageBox._messageBox.height() - MessageBox._messageBox.offset().top - 60) + "px",
					"padding-Top":"30px",
					"padding-Bottom":"30px"
				}, 500);
			//});
		}
		else {
			var docWidth = $(document).width();
			var docHeight = $(document).height();
			var docScrollTop = $(window).scrollTop();
			var docScrollLeft = $(window).scrollLeft();
			var winScrollHeight = $(window).height();
			var winScrollWidth = $(window).width();
			var docScrollWidth = docWidth - winScrollWidth;
			var docScrollHeight = docHeight - winScrollHeight;

			MessageBox._synopsis.animate({
				"height": "0px",
				"padding-Top":"0",
				"padding-Bottom":"0"
			}, 500, function() {
				//MessageBox._messageBox.animate({
				//	"top": (((docHeight - docScrollHeight) / 2) + docScrollTop - (MessageBox._messageBox.height() / 2)) + "px"
				//}, 500);
			});
		}
	}
};

$(function() { 
	MessageBox.init();
});