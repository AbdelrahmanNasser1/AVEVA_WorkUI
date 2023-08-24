=======================================================
Workflow Management Custom Styles for Forms Readme File
=======================================================
Copyright (C) AVEVA Group plc and its subsidiaries. All rights reserved.


This document contains information about Wonderware Workflow Custom Styles for Forms. For more information see, Wonderware Skelta BPM Forms and Lists User Guide.

------------------------
HOW TO USE THIS DOCUMENT
------------------------

You can view the Readme file on-screen in Windows Notepad. To print the Readme file, open it in Notepad or another word processor, and then on the File menu, click Print.


--------
CONTENTS
--------

1. CUSTOM STYLE SHEETS

2. CUSTOM STYLES


----------------------
1. CUSTOM STYLE SHEETS
----------------------

Use Custom Style Sheets to change style for HTML elements of controls using CSS classes.

Custom style sheets help you to change the style of the forms user interface and customize the style according to your corporate style guidelines.


----------------
2. CUSTOM STYLES
----------------

To create a custom style

1. Create a style sheet in the <BPMUITemplates>/NextGenForms/custom/Themes/<ThemeName>/css/ folder.
2. Enter the name of the style sheet for the Custom Style Sheet property of the form. For example, enter MyCustomStyleSheet for MyCustomStyleSheet.css.
3. Enter the name of the identifier for the Custom Style Identifier property of the control.
4. Edit the style sheet to define styles for HTML elements of controls using CSS classes.


Important:

- Prefix the Custom Style Identifier of a control with the CSS Class name to apply the style to the specific control.
- Use the CSS Class name by itself to apply the style to all the controls.
- Suffix your CSS declarations with !important to ensure it takes precedence over normal declarations.

