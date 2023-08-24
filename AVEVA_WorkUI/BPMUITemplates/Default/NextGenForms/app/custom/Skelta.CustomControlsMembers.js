/*!
// ------------------------------------------------------------------------------------------------------------
// <copyright company="Schneider Electric Software, LLC" file="Skelta.CustomControlsMembers.js">
//   � 2016 Schneider Electric Software, LLC. All rights reserved.
//
// THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
// KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.
// </copyright>
// <summary>
// This contains infrastructure to include custom controls members which helps in validating the syntax for scripting.
// </summary>
// ------------------------------------------------------------------------------------------------------------
*/
//(function ()
//{
//    var standardControlMembers = skelta.forms.constants.controlsCollection;
//    var genericControlFunctions = skelta.forms.constants.controlFunctions;//genericControlFunctions has properties - nonContainerFunctions and containerFunctions which is a collection of function names [{ name: "functionName"}]
//    var customControlMembers = {
//        functions: genericControlFunctions.nonContainerFunctions,//.concat([{ name: "functionName" }
//        isContainerControl: false,
//        controlType: "ToolBar",
//        properties: [{ propertyName: "xmlNodeBoundTo", propertyType: "2", isWritable: false },
//                     { propertyName: "tagName", propertyType: "0", isWritable: true },
//                     { propertyName: "id", propertyType: "2", isWritable: false },
//                     { propertyName: "value", propertyType: "0", isWritable: true },
//                     { propertyName: "isMandatory", propertyType: "0", isWritable: true },
//                     { propertyName: "readOnly", propertyType: "0", isWritable: true },
//                     { propertyName: "enable", propertyType: "0", isWritable: true },
//                     { propertyName: "resizable", propertyType: "0", isWritable: true },
//                     { propertyName: "visible", propertyType: "0", isWritable: true }]
//    }
//    standardControlMembers.push(customControlMembers);
//})();