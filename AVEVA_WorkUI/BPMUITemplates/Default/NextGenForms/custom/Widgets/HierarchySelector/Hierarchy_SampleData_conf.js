/** Hierarchy Selector Configuration File
 *   Configuration Name : Hierarchy_SampleData
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
        groupName: "GroupName", // required
        groupNodes: "UtilizationReasonGroups", // required
        showGroupAsEnabled: "", // optional, map to property name to show group as disable/enable. If it is provided, value of the property will be used to indicate enable or disable.
        childNodes: "UtilizationReasons", // required
        childName: "Name", // required
        childColor: "EquipmentState.Color", // optional, it can be null or empty string. If null or empty string, defaultChildSelectedColor is used
        selectedChildNodeValue: "Name", // optional, property name of return object. If it is provided, value of selected child node property will be return in Value1. If null or empty string or property name not found in returning child node, null is return in Value1.
      },

      // uncomment selectedChildNode function to provide own customization. The function will be called when child node is selected/deselected.
      // parameters:
      //            selectedChildObject - selected child node object. Null when deselected.
      //            selectedChildValue  - selected child node property value which property name is set in "selectedChildNodeValue" of defaultNodesMapping/nodesMapping
      selectedChildNode: function (selectedChildObject, selectedChildValue) {
        // Provide customization on routing extra selected property to value3 and value4
        // (value3 and value4 need to be added in widget.json)
        cwidget.selectedObj = JSON.stringify(selectedChildObject);
        cwidget.selectedValue = JSON.stringify(selectedChildValue);

        if (
          selectedChildObject != null &&
          selectedChildObject.EquipmentState != null
        ) {
          cwidget.value3 = JSON.stringify(
            selectedChildObject.EquipmentState.Name
          );
          cwidget.value4 = JSON.stringify(
            selectedChildObject.EquipmentState.Color
          );
        } else {
          cwidget.value3 = JSON.stringify("");
          cwidget.value4 = JSON.stringify("");
        }
      },
    };

    // End hierarchical selector Configuration
    return conf;
  }

  var testData = {
    nodesMapping: {
      groupName: "GroupName",
      groupNodes: "UtilizationReasonGroups",
      showGroupAsEnabled: "IsEnable",
      childNodes: "UtilizationReasons",
      childName: "Name",
      childColor: "EquipmentState.Color",
      selectedChildNodeValue: "Name",
    },

    nodesValue: [
      {
        GroupName: "Changeover",
        IsEnable: false,
        UtilizationReasonGroups: [],
        UtilizationReasons: [
          {
            Name: "Changeover1",
            EquipmentState: {
              Name: "DOWNTIME",
              Color: "#DC0A0A",
            },
          },
          {
            Name: "Changeover2",
            EquipmentState: {
              Name: "RUNNING",
              Color: "#009848",
            },
          },
          {
            Name: "Planned Changeover",
            EquipmentState: {
              Name: "PLANNED DT",
              Color: "#F5A623",
            },
          },
          {
            Name: "Planned Cleaning",
            EquipmentState: {
              Name: "PLANNED DT",
              Color: "#F5A623",
            },
          },
        ],
      },
      {
        GroupName: "Cleaning",
        IsEnable: true,
        UtilizationReasonGroups: [],
        UtilizationReasons: [
          {
            Name: "Clean1",
            EquipmentState: {
              Name: "SPEED LOSS",
              Color: "#009848",
            },
          },
        ],
      },
      {
        GroupName: "Level 1a",
        IsEnable: false,
        UtilizationReasonGroups: [
          {
            GroupName: "Level 2",
            IsEnable: true,
            UtilizationReasonGroups: [
              {
                GroupName: "Level 3",
                IsEnable: true,
                UtilizationReasonGroups: [],
                UtilizationReasons: [
                  {
                    Name: "Level 3 check",
                    EquipmentState: {
                      Name: "SPEED LOSS",
                      Color: "#009848",
                    },
                  },
                ],
              },
            ],
            UtilizationReasons: [
              {
                Name: "Level 2 check",
                EquipmentState: {
                  Name: "SPEED LOSS",
                  Color: "#009848",
                },
              },
            ],
          },
        ],
        UtilizationReasons: [
          {
            Name: "Level 1a check",
            EquipmentState: {
              Name: "SPEED LOSS",
              Color: "#009848",
            },
          },
        ],
      },
      {
        GroupName: "Maintenance",
        IsEnable: true,
        UtilizationReasonGroups: [],
        UtilizationReasons: [
          {
            Name: "Main1",
            EquipmentState: {
              Name: "DOWNTIME",
              Color: "#DC0A0A",
            },
          },
          {
            Name: "Main2",
            EquipmentState: {
              Name: "RUNNING",
              Color: "#009848",
            },
          },
          {
            Name: "Planned Maintenance",
            EquipmentState: {
              Name: "PLANNED DT",
              Color: "#F5A623",
            },
          },
        ],
      },
      {
        GroupName: "Unplanned Stoppages1",
        IsEnable: true,
        UtilizationReasonGroups: [
          {
            GroupName: "Electrical Faults1",
            IsEnable: true,
            UtilizationReasonGroups: [],
            UtilizationReasons: [
              {
                Name: "Conveyor Motor Failure1",
                EquipmentState: {
                  Name: "UNEVENT",
                  Color: "#DC0A0A",
                },
              },
              {
                Name: "Equipment Failure1",
                EquipmentState: {
                  Name: "UNEVENT",
                  Color: "#DC0A0A",
                },
              },
              {
                Name: "Equipment Motor Failure1",
                EquipmentState: {
                  Name: "UNEVENT",
                  Color: "#DC0A0A",
                },
              },
            ],
          },
          {
            GroupName: "Mechanical Faults1",
            IsEnable: true,
            UtilizationReasonGroups: [],
            UtilizationReasons: [
              {
                Name: "Equipment Failure1",
                EquipmentState: {
                  Name: "UNEVENT",
                  Color: "#DC0A0A",
                },
              },
              {
                Name: "Infeed Conveyor Belt Broken1",
                EquipmentState: {
                  Name: "UNEVENT",
                  Color: "#DC0A0A",
                },
              },
              {
                Name: "Outfeed Conveyor Belt Broken1",
                EquipmentState: {
                  Name: "UNEVENT",
                  Color: "#DC0A0A",
                },
              },
            ],
          },
          {
            GroupName: "Process Failure1",
            IsEnable: true,
            UtilizationReasonGroups: [
              {
                GroupName: "Equipment1",
                IsEnable: true,
                UtilizationReasonGroups: [],
                UtilizationReasons: [
                  {
                    Name: "E Stop1",
                    EquipmentState: {
                      Name: "UNEVENT",
                      Color: "#DC0A0A",
                    },
                  },
                  {
                    Name: "Infeed Jam1",
                    EquipmentState: {
                      Name: "UNEVENT",
                      Color: "#DC0A0A",
                    },
                  },
                  {
                    Name: "Outfeed Jam1",
                    EquipmentState: {
                      Name: "UNEVENT",
                      Color: "#DC0A0A",
                    },
                  },
                ],
              },
            ],
            UtilizationReasons: [
              {
                Name: "Process Failure1",
                EquipmentState: {
                  Name: "UNEVENT",
                  Color: "#DC0A0A",
                },
              },
            ],
          },
        ],
        UtilizationReasons: [],
      },
      {
        GroupName: "Waste&Rework",
        IsEnable: true,
        UtilizationReasonGroups: [],
        UtilizationReasons: [
          {
            Name: "Waste",
            EquipmentState: {
              Name: "_STOPPAGES",
              Color: "#F5A623",
            },
          },
        ],
      },
    ],
  };

  //Widget config name
  if (typeof window.conf === "undefined") {
    window.conf = {};
  }

  if (typeof window.conf["Hierarchy_SampleData"] === "undefined") {
    window.conf["Hierarchy_SampleData"] = getConf;
  }

  if (typeof window.conf["Hierarchy_SampleData_testdata"] === "undefined") {
    window.conf["Hierarchy_SampleData_testdata"] = testData;
  }
})();
