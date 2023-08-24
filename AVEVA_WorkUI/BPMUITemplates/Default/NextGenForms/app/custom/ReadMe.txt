=======================================================
Workflow Management Custom Control members for Forms Readme File
=======================================================
Copyright (C) AVEVA Group plc and its subsidiaries. All rights reserved.


This document contains information about Workflow Management Custom Control members for Forms. For more information see, Wonderware Skelta BPM Forms and Lists User Guide.

------------------------
HOW TO USE THIS DOCUMENT
------------------------

You can view the Readme file on-screen in Windows Notepad. To print the Readme file, open it in Notepad or another word processor, and then on the File menu, click Print.


--------
CONTENTS
--------

CUSTOM CONTROL MEMBERS

To add custom control members as whiteList for Check syntax validations

1. Open the file BPMUITemplates\Default\NextGenForms\app\custom\Skelta.CustomControlsMembers.js
2. Uncomment the self invoking function
3. genericControlFunctions has properties - nonContainerFunctions and containerFunctions which is a collection of function names - [{ name: "functionName"}]
4. controlType is your control name
5. Use the customControlMembers object as per the custom control - add property to proprties array.
	. propertyName is the name of the property.
	. propertyType is "0" for observable, "1" for observableArray and "2" for nonObservable.
	. isWritable is true or false - whether property is assignable or readonly.
6. push customControlMembers to standardControlMembers collection

