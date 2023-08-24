var jsonObj = [
{
    "New": {
        "Id": "33af82d3-8e44-4339-b94e-b353ae63f314",
        "Text": "New",
        "Image": "../../HTML5Controls/images/AB-New.png",
        "Action": "",
        "OpenMode": "Popup",
        "SubItems": [
            {
                "Id": "a2824b04-e1de-463a-8257-ca149813c325",
                "Text": "New",
                "Image": "../../HTML5Controls/images/AB-New.png",
                "Action": "javascript: ExecuteAction('_sys_new')",
                "OpenMode": "Popup",
                "SubItems": []
            },
            {
                "Id": "5291a6b6-87a7-481f-a55a-f69129942bfa",
                "Text": "Design",
                "Image": "../../HTML5Controls/images/AB-Design.png",
                "Action": "javascript: ExecuteAction('_sys_newipworkflow')",
                "OpenMode": "Popup",
                "SubItems": []
            },
            {
                "Id": "ec16a007-deb0-4ad5-85c4-58465de2a8ac",
                "Text": "Associate",
                "Image": "../../HTML5Controls/images/AB-Associate.png",
                "Action": "javascript: ExecuteAction('_sys_newlistworkflow')",
                "OpenMode": "Popup",
                "SubItems": []
            },
			{
                "Id": "ec16a007-deb0-4ad5-85c4-59465de2a8ac",
                "Text": "FileWatcher",
                "Image": "../../HTML5Controls/images/AB-FileWatcher.png",
                "Action": "javascript: ExecuteAction('_sys_newlistworkflow')",
                "OpenMode": "Popup",
                "SubItems": []
            }
			
        ]
    }
},

{
            "Action": 
            {
                "Id": "33af82d3-8e44-4339-b94e-b353ae63f324",
                "Text": "Design",
                "Image": "../../HTML5Controls/images/AB-Design.png",
                "Action": "",
                "OpenMode": "Popup",
                "SubItems": 
		 [
                    {
                        "Id": "a2824b04-e1de-463a-8257-ca149814c325",
                        "Text": "Design",
                        "Image": "../../HTML5Controls/images/AB-Design.png",
                        "Action": "javascript: ExecuteActionForSelectedRow('_sys_designworkflow')",
                        "OpenMode": "Popup",
                        "SubItems": [
                            
                        ]
                    },
                    {
                        "Id": "5291a6b6-87a7-481f-a55a-f69129952bfa",
                        "Text": "Edit",
                        "Image": "../../HTML5Controls/images/AB-Edit.png",
                        "Action": "javascript: ExecuteAction('_sys_edit’)",
                        "OpenMode": "Popup",
                        "SubItems": [
                            
                        ]
                    },
                    {
                        "Id": "ec16a007-deb0-4ad5-85c4-58465df2a8ac",
                        "Text": "View",
                        "Image": "../../HTML5Controls/images/AB-Preview.png",
                        "Action": "javascript: ExecuteAction('_sys_view_designer')",
                        "OpenMode": "Popup",
                        "SubItems": [
                            
                        ]
                    },
					{
                        "Id": "ec16a007-deb0-4ad5-87c4-58465df2a8ac",
                        "Text": "Delete",
                        "Image": "../../HTML5Controls/images/AB-Delete.png",
                        "Action": "javascript: ExecuteAction('_sys_delete')",
                        "OpenMode": "Popup",
                        "SubItems": [
                            
                        ]
                    }
                ]
                }
            },
			
			{
            "Associate": 
            {
                "Id": "33af82d3-8e44-4439-b94e-b353ae63f324",
                "Text": "Associate",
                "Image": "../../HTML5Controls/images/AB-Associate.png",
                "Action": "",
                "OpenMode": "Popup",
                "SubItems": 
				[
                    {
                        "Id": "a2824b04-e1ee-463a-8257-ca149814c325",
                        "Text": "Associate",
                        "Image": "../../HTML5Controls/images/AB-Associate.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_create_assn')",
                        "OpenMode": "Popup",
                        "SubItems": [
                            
                        ]
                    }
                ]
                }
            },
			{
            "Security": 
            {
                "Id": "33af92d3-8e44-4439-b94e-b353ae63f324",
                "Text": "Security",
                "Image": "../../HTML5Controls/images/AB-Security.png",
                "Action": "",
                "OpenMode": "Popup",
                "SubItems": 
				[
                    {
                        "Id": "a2825b04-e1ee-463a-8257-ca149814c325",
                        "Text": "Security",
                        "Image": "../../HTML5Controls/images/AB-Security.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_security_settings')",
                        "OpenMode": "Popup",
                        "SubItems": [
                            
                        ]
                    }
                ]
            }
            }
            ];

$(function() {
	ActionBar.init(jsonObj, "actionBarDiv");

	$("#showRightMenu").on("click", function () {
		if(ActionBar._rightMenu) {
			ActionBar.hideRightMenu();
		}
		else {
			ActionBar.showRightMenu(jsonObj);
		}
	});
});