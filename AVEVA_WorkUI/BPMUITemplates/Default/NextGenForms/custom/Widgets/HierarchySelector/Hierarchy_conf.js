/** Hierarchy Selector Configuration File
 *   Configuration Name : Hierarchy
 *	Version : 1.1
 *
 *	Ver		Date		Comment
 *	1.0		25-Feb-22	Initial version
 *	1.1		15-Apr-22	Provide defaultParentDisabledColor and showGroupAsEnabled to show group color when property is disabled.
 **/
(function () {
  function getConf(confName, widgetObject, cwidget, myConf) {
    if (typeof window.conf === "undefined") {
      window.conf = {};
    }

    //Subscribe to confName property to handle changing of configuration file
    cwidget.on("confName", function () {
      if (myConf.confName != cwidget.confName) {
        myConf.confName = cwidget.confName;
        widgetObject.hs.init();
      }
    });

    //Subscribe to data property to handle new set of parent child node
    cwidget.on("data", function () {
      if (typeof cwidget.data != "undefined" && cwidget.data !== "") {
        try {
          // pass in data will be stringify
          widgetObject.hs.updateWidget(JSON.parse(cwidget.data));
        } catch (ex) {
          widgetObject.hs.showError(
            WW_localize("@@WidgetHSErrorSetDataConvertToObject@@")
          );
        }
      } else {
        widgetObject.hs.showError(
          WW_localize(
            "@@WidgetHSErrorSetDataConvertToObjectFromEmptyUndefined@@"
          )
        );
      }
    });

    var conf = {
      // Title, header and captions
      widgetTitle: WW_localize("@@WidgetHSWidgetTitle@@"),
      header: WW_localize("@@WidgetHSHeader@@"),
      parentCaption: WW_localize("@@WidgetHSParentCaption@@"),
      childCaption: WW_localize("@@WidgetHSChildCaption@@"),
      captionNoParentSelected: WW_localize(
        "@@WidgetHSCaptionNoParentSelected@@"
      ),
      noChildAvailable: WW_localize("@@WidgetHSNoChildAvailable@@"),
      noData: WW_localize("@@WidgetHSNoData@@"),

      // default disabled, select and non-select color for parent node
      defaultParentDisabledColor: "#E7E7E7",
      defaultParentNonSelectedColor: "#E0E0E0",
      defaultParentSelectedColor: "#E9EBFC",

      // default select and non-select color for child node if child color in nodesMapping or defaultNodesMapping is not defined
      defaultChildNonSelectedColor: "#E0E0E0",
      defaultChildSelectedColor: "#E9EBFC",

      // defaultNodesMapping is used to map property name use in incoming data.
      // It will be used if nodesMapping is NOT supplied
      defaultNodesMapping: {
        groupName: "", // required
        groupNodes: "", // required
        showGroupAsEnabled: "", // optional, map to property name to show group as disable/enable.. If it is provided, value of the property will be used to indicate enable or disable.
        childNodes: "", // required
        childName: "", // required
        childColor: "", // optional, it can be null or empty string. If null or empty string, defaultChildSelectedColor is used
        selectedChildNodeValue: "", // optional, property name of return object. If it is provided, value of the property will be return in Value1. If null or empty string or property name not found in returning child node, null is return in Value1.
      },

      // uncomment selectedChildNode function to provide own customization. The function will be called when child node is selected/deselected.
      // parameters:
      //            selectedChildObject - selected child node object. Null when deselected.
      //            selectedChildValue  - selected child node property value which property name is set in "selectedChildNodeValue" of defaultNodesMapping/nodesMapping
      // selectedChildNode : function(selectedChildObject,selectedChildValue)
      // {
      // }
    };

    // End hierarchical selector Configuration
    return conf;
  }

  //Widget config name
  if (typeof window.conf === "undefined") {
    window.conf = {};
  }

  if (typeof window.conf["Hierarchy"] === "undefined") {
    window.conf["Hierarchy"] = getConf;
  }
})();
