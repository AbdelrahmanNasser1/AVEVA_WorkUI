function MenuItem()
{
	this.id = '';
	this.description = '';
	this.imageUrl = '';
	this.navigationUrl = '';
	this.title = '';
	this.tooltip = '';
	this.context = '';
	this.mode = '';
	this.subItems = [];
	this.level = 0;
}

MenuItem.prototype.GetId = function() {
	return this.id;
};
   
MenuItem.prototype.SetId = function(val) {
	this.id = val;
};
	
MenuItem.prototype.GetDescription = function() { 
	return this.description;
};

MenuItem.prototype.SetDescription = function(val) {
	this.description = val;
};

MenuItem.prototype.GetImageUrl = function() {
	return this.imageUrl;
};

MenuItem.prototype.SetImageUrl = function(val) {
	this.imageUrl = val; 
};

MenuItem.prototype.GetNavigateUrl = function() {
	return this.navigationUrl;
};

MenuItem.prototype.SetNavigateUrl = function(val) {
	this.navigationUrl = val;
};

MenuItem.prototype.GetTitle = function() {
	return this.title;
};

MenuItem.prototype.SetTitle = function(val) {
	this.title = val;
};

MenuItem.prototype.GetToolTip = function() {
	return this.tooltip;
};

MenuItem.prototype.SetToolTip = function(val) {
	this.tooltip = val;
};

MenuItem.prototype.GetContext = function() {
	return this.context;
};

MenuItem.prototype.SetContext = function(val) {
	this.context = val;
};

MenuItem.prototype.GetOpenMode = function() { 
	return this.mode;
};

MenuItem.prototype.SetOpenMode = function(val) {
	this.mode = val;
};

MenuItem.prototype.GetSubItems = function() {
	return this.subItems;
};

MenuItem.prototype.SetSubItems = function(val) {
	this.subItems = val;
};

MenuItem.prototype.GetLevel = function() {
	return this.level;
};
   
MenuItem.prototype.SetLevel = function(val) {
	this.level = val;
};