function ContextMenuItem()
{
	this.iconPath = '';
	this.name = '';
	this.parentName = '';
	this.properties = '';
	this.type = '';
	this.uri = '';
	this.value = '';
	this.subItems = [];
	this.tooltip = '';
}

ContextMenuItem.prototype.GetIconPath = function() {
	return this.iconPath;
};
   
ContextMenuItem.prototype.SetIconPath = function(val) {
	this.iconPath = val;
};
	
ContextMenuItem.prototype.GetName = function() { 
	return this.name;
};

ContextMenuItem.prototype.SetName = function(val) {
	this.name = val;
};

ContextMenuItem.prototype.GetParentName = function() {
	return this.parentName;
};

ContextMenuItem.prototype.SetParentName = function(val) {
	this.parentName = val; 
};

ContextMenuItem.prototype.GetProperties = function() {
	return this.properties;
};

ContextMenuItem.prototype.SetProperties = function(val) {
	this.properties = val;
};

ContextMenuItem.prototype.GetType = function() {
	return this.type;
};

ContextMenuItem.prototype.SetType = function(val) {
	this.type = val;
};

ContextMenuItem.prototype.GetUri = function() {
	return this.uri;
};

ContextMenuItem.prototype.SetUri = function(val) {
	this.uri = val;
};

ContextMenuItem.prototype.GetValue = function() {
	return this.value;
};

ContextMenuItem.prototype.SetValue = function(val) {
	this.value = val;
};

ContextMenuItem.prototype.GetSubItems = function() {
	return this.subItems;
};

ContextMenuItem.prototype.SetSubItems = function(val) {
	this.subItems = val;
};

ContextMenuItem.prototype.GetTooltip = function() {
	return this.tooltip;
};

ContextMenuItem.prototype.SetTooltip = function(val) {
	this.tooltip = val;
};