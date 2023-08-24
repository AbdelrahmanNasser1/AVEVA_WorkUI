var app = angular.module('myApp', ['ngMaterial', 'ngAnimate', 'ngAria']);

/* AriaProvider config to remove tabindex */

app.config(function ($ariaProvider)
{
    $ariaProvider.config({

        tabindex: false
    });
})

/* Angular Filter for searching item menus */

app.filter('customSearch', [function ()
{
    /** @data is the original data**/
    /** @skill is the search query for skill**/
    return function (data, skill) {
        var output = []; // store result in this
        /**@case1 if both searches are present**/
        if (!!skill) {
            skill = skill.toLowerCase();
            //loop over the original array

            for (var i = 0; i < data.length; i++) {
                if (data[i].title.toLowerCase().indexOf(skill) !== -1) {
                    //push data into results array
                    output.push(data[i]);
                }

                if (data[i].subItems.length > 0) {
                    for (var k = 0; k < data[i].subItems.length; k++) {
                        if (data[i].subItems[k].title.toLowerCase().indexOf(skill) !== -1) {
                            output.push(data[i].subItems[k]);
                        }

                        if (data[i].subItems[k].subItems.length > 0) {
                            for (var j = 0; j < data[i].subItems[k].subItems.length; j++) {
                                if (data[i].subItems[k].subItems[j].title.toLowerCase().indexOf(skill) !== -1) {
                                    output.push(data[i].subItems[k].subItems[j]);
                                }

                                if (data[i].subItems[k].subItems[j].subItems.length > 0) {
                                    for (var m = 0; m < data[i].subItems[k].subItems[j].subItems.length; m++) {
                                        if (data[i].subItems[k].subItems[j].subItems[m].title.toLowerCase().indexOf(skill) !== -1) {
                                            output.push(data[i].subItems[k].subItems[j].subItems[m]);
                                        }

                                        if (data[i].subItems[k].subItems[j].subItems[m].subItems.length > 0) {
                                            for (var n = 0; n < data[i].subItems[k].subItems[j].subItems[m].subItems.length; n++) {
                                                if (data[i].subItems[k].subItems[j].subItems[m].subItems[n].title.toLowerCase().indexOf(skill) !== -1) {
                                                   output.push(data[i].subItems[k].subItems[j].subItems[m].subItems[n]);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            output = data;
        }
        return output; // finally return the result     
    }
}]);

app.controller('AppCtrl', function ($scope, $timeout, $mdSidenav, $rootScope, $timeout)
{
    /*state initializing */
    $scope.customBackdrop = 0;
    $scope.backdrop = 0;
    $scope.iconClick = 0;
    $scope.frState = 0;
    $scope.scState = 0;
    $scope.trState = 0;
    $scope.foState = 0;
    $scope.state = 0;
    $scope.stateSecond = 0;
    $scope.searchState = 0;
    $scope.scIndex = 0;
    $scope.closingForm = 0;
    $rootScope.try = false;
    $scope.windowWidth = $(window).width();

   
    /* Click function to store value during click off log off*/

    $("#LogOffMenuItem").click(function ()
    {
        sessionStorage.setItem('logoutVar', 2);
    });

    var delays = [];
    $scope.random = function (i)
    {

        if (!delays[i]) {
            delays[i] = Math.random();
        }
        return delays[i];
    };

    /*Window Resize function for menu style */

    $(window).resize(function ()
    {
        $scope.windowWidth = $(window).width();

        /* JS to hide arrows and close menu during resize in small devices*/

        if ($(window).width() < 730)
        {
            $(".iconNavigation").css("display", "none");
            $("img.upIconNavigation").css("display", "none");

            if (!$("md-sidenav").hasClass("md-closed"))
            {
                $("img.menuIcon").click();
            }
        }
        if ($(window).width() > 730)
        {
            $(".iconNavigation").css("display", "block");
        }
        togglerForWindowSize();
    });

    /*md-sidenav Toggler function */

    function togglerForWindowSize()
    {
        if ($(window).width() > 730)
        {
            $scope.keepOpen = false;
            $scope.toggleLeft = toggleLeft;
            $scope.toggleLeftSubMenu = toggleLeftSubMenu;

            /*Function for toggle when click on hinged icons */

            function toggleLeftSubMenu(index, data)
            {               
                $mdSidenav('left').open();

                if (($('md-sidenav').hasClass('md-closed')))
                {
                    $timeout(function () {                       
                        $scope.toggleFirst(index, data);
                    }, 400);
                }

                else
                {                   
                    $scope.toggleFirst(index, data);
                }
            }

            function toggleLeft()
            {    
                $scope.backdropClick = 0;
                $scope.trStateClick = 0;
                $scope.scStateClick = 0;
                $scope.frStateClick = 0;
                $scope.foStateClick = 0;
                $scope.closingForm = 0;

                /*When fourth level menu is open */

                if ($scope.foState == 1 && $scope.trState == 1 && $scope.scState == 1)
                {
                    $scope.foState = 0;
                    $timeout(function ()
                    {
                        if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                        {
                            return;
                        }
                        $(".secondLevelMenu").css("z-index", 63);
                        $(".firstLevelMenu").css("z-index", 62);
                        $scope.trState = 0;
                        $scope.test = 1;
                    }, 400);

                    $timeout(function ()
                    {
                        if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                        {
                            return;
                        }
                        $(".secondLevelMenu").css("z-index", 61);
                        $scope.scState = 0;
                        $scope.test = 1;
                    }, 800);

                    $timeout(function ()
                    {
                        if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                        {
                            return;
                        }
                        $(".secondLevelMenu").css("z-index", 61);
                        $scope.frState = 0;
                        $scope.test = 1;
                        $(".firstLevelMenu").css("z-index", 2);
                    }, 1200);

                    $timeout(function ()
                    {
                        if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                        {
                            return;
                        }
                        $(".secondLevelMenu").css("z-index", 61);
                        $scope.foIndex = null;
                        $scope.fIndex = null;
                        $scope.scIndex = null;
                        $scope.trIndex = null;
                        buildToggler();
                    }, 1600);
                }

                /*When Third level menu is open */

                else if ($scope.trState == 1 && $scope.scState == 1 && $scope.foState == 0)
                {                 
                    $scope.trState = 0;
                    $timeout(function ()
                    {
                        if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                        {
                            return;
                        }
                        $(".secondLevelMenu").css("z-index", 61);
                        $(".firstLevelMenu").css("z-index", 62);
                        $scope.scState = 0;
                        $scope.test = 1;
                    }, 400);

                    $timeout(function ()
                    {
                        if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                        {
                            return;
                        }
                        $scope.frState = 0;
                        $scope.test = 1;
                        $(".firstLevelMenu").css("z-index", 2);
                    }, 800);

                    $timeout(function ()
                    {
                        if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                        {
                            return;
                        }
                        buildToggler();
                        $scope.foIndex = null;
                        $scope.fIndex = null;
                        $scope.scIndex = null;
                        $scope.trIndex = null;
                    }, 1200);
                }

                /*When second level menu is open */

                else if ($scope.scState == 1 && $scope.trState == 0 && $scope.foState == 0)
                {              
                    $scope.scState = 0;
                    $timeout(function ()
                    {
                        if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                        {
                            return;
                        }
                        $scope.frState = 0;
                        $scope.test = 1;
                    }, 400);

                    $timeout(function ()
                    {
                        if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                        {
                            return;
                        }
                        buildToggler();
                        $scope.foIndex = null;
                        $scope.fIndex = null;
                        $scope.scIndex = null;
                        $scope.trIndex = null;
                    }, 800);
                }

                /*When First level menu is open */

                else if ($scope.scState == 0 && $scope.trState == 0 && $scope.foState == 0 && $scope.frState == 1)
                {              
                    $scope.frState = 0;
                    $timeout(function ()
                    {
                        if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                        {
                            return;
                        }
                        buildToggler();
                        $scope.foIndex = null;
                        $scope.fIndex = null;
                        $scope.scIndex = null;
                        $scope.trIndex = null;
                    }, 400);
                }

                /*When  menu is open */

                else {     
                    buildToggler();
                    $scope.foIndex = null;
                    $scope.fIndex = null;
                    $scope.scIndex = null;
                    $scope.trIndex = null;
                }
            };
          
            function buildToggler()
            {
                if ($scope.backdropClick == 1)
                {                   
                    $mdSidenav('left').close();
                    $scope.backdropClick = 0
                }

                else
                {
                    $mdSidenav('left').toggle().then(function ()
                    {
                        $scope.keepOpen = !$scope.keepOpen;
                        if ($scope.keepOpen)
                        {
                            angular.element('md-backdrop.md-sidenav-backdrop-custom').removeClass('disabled');
                        }
                    });
                }
            }

            /*Function call when we click on backdrop */

            $scope.checkClosingForm = function (event)
            {
                $("md-backdrop.md-sidenav-backdrop").css("left", "3000px");
                $scope.backdropClick = 1;
                $scope.backdrop = 1;
                $scope.closingForm = 1;
                $scope.trStateClick = 0;
                $scope.scStateClick = 0;
                $scope.frStateClick = 0;
                $scope.foStateClick = 0;

                if (true)
                {
                    if ($scope.foState == 1 && $scope.trState == 1 && $scope.scState == 1)
                    {                     
                        $scope.foState = 0;
                        $timeout(function ()
                        {
                            if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                            {
                                return;
                            }
                            $(".secondLevelMenu").css("z-index", 63);
                            $(".firstLevelMenu").css("z-index", 62);
                            $scope.trState = 0;
                            $scope.test = 1;
                        }, 400);
                     
                        $timeout(function ()
                        {
                            if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                            {                               
                                return;
                            }                          
                            $(".secondLevelMenu").css("z-index", 61);
                            $scope.scState = 0;
                            $scope.test = 1;                           
                        }, 800);

                        $timeout(function ()
                        {
                            if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                            {
                                return;
                            }
                            $(".secondLevelMenu").css("z-index", 61);
                            $scope.frState = 0;
                            $scope.test = 1;
                            $(".firstLevelMenu").css("z-index", 2);
                        }, 1200);

                        $timeout(function ()
                        {
                            if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                            {                               
                                return;
                            }
                            $(".secondLevelMenu").css("z-index", 61);
                            $scope.foIndex = null;
                            $scope.fIndex = null;
                            $scope.scIndex = null;
                            $scope.trIndex = null;
                            $mdSidenav('left').close();
                        }, 1600);
                    }

                    else if ($scope.trState == 1 && $scope.scState == 1 && $scope.foState == 0)
                    {                        
                        $scope.trState = 0;

                        $timeout(function ()
                        {
                            if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                            {
                                return;
                            }
                            $(".secondLevelMenu").css("z-index", 61);
                            $(".firstLevelMenu").css("z-index", 62);
                            $scope.scState = 0;
                            $scope.test = 1;
                        }, 400);

                        $timeout(function ()
                        {
                            if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                            {
                                return;
                            }
                            $scope.frState = 0;
                            $scope.test = 1;
                            $(".firstLevelMenu").css("z-index", 2);
                        }, 800);

                        $timeout(function ()
                        {
                            if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                            {
                                return;
                            }
                            $mdSidenav('left').close();                          
                            $scope.foIndex = null;
                            $scope.fIndex = null;
                            $scope.scIndex = null;
                            $scope.trIndex = null;
                        }, 1200);
                    }

                    else if ($scope.scState == 1 && $scope.trState == 0 && $scope.foState == 0)
                    {                      
                        $scope.scState = 0;
                        $timeout(function () {
                            if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                            {
                                return;
                            }
                            $scope.frState = 0;
                            $scope.test = 1;
                        }, 400);

                        $timeout(function ()
                        {
                            if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                            {
                                return;
                            }
                            $mdSidenav('left').close();
                            $scope.backdropClick = 0
                            $scope.foIndex = null;
                            $scope.fIndex = null;
                            $scope.scIndex = null;
                            $scope.trIndex = null;
                        }, 800);
                    }

                    else if ($scope.scState == 0 && $scope.trState == 0 && $scope.foState == 0 && $scope.frState == 1)
                    {                      
                        $scope.frState = 0;
                        $timeout(function ()
                        {
                            if ($scope.trStateClick == 1 || $scope.scStateClick == 1 || $scope.frStateClick == 1 || $scope.foStateClick == 1)
                            {
                                return;
                            }
                            $mdSidenav('left').close()
                            $scope.foIndex = null;
                            $scope.fIndex = null;
                            $scope.scIndex = null;
                            $scope.trIndex = null;
                        }, 400);
                    }

                    else
                    {           
                        $mdSidenav('left').close();                         
                        $scope.foIndex = null;
                        $scope.fIndex = null;
                        $scope.scIndex = null;
                        $scope.trIndex = null;
                    }
                }             
            };
        }

        else
        {            
            $scope.keepOpen = false;
            $scope.toggleLeft = toggleLeft;

            function toggleLeft()
            {    
                $scope.foState = 0;
                $scope.trState = 0;
                $scope.scState = 0;
                $scope.foIndex = null;
                $scope.fIndex = null;
                $scope.scIndex = null;
                $scope.trIndex = null;
                $scope.frState = 0;               
                buildToggler();
            };

            function buildToggler()
            {     
                $mdSidenav('left').toggle().then(function ()
                {
                    $scope.keepOpen = !$scope.keepOpen;

                    if ($scope.keepOpen)
                    {
                        angular.element('md-backdrop.md-sidenav-backdrop-custom').removeClass('disabled');
                    }
                });
            }

            $scope.checkClosingForm = function ()
            {
                if (true)
                {
                    $scope.foState = 0;
                    $scope.trState = 0;
                    $scope.scState = 0;
                    $scope.frState = 0;
                    $scope.foIndex = null;
                    $scope.fIndex = null;
                    $scope.scIndex = null;
                    $scope.trIndex = null;
                    toggleLeft();
                }
            };
        }
    }
    togglerForWindowSize();

    /*Function called when sidenav open or close */

    $scope.$watch('isSidenavOpen', function (isSidenavOpen)
    { 
        $scope.state = 0;

        if ($scope.state == 0)
        {
            $("md-sidenav.md-sidenav-left").css("overflow-y", "auto");
        }

        if ($scope.state == 1)
        {
            $("md-sidenav.md-sidenav-left").css("overflow-y", "hidden");
        }

        /*Function called when sidenav closing */

        if (!($('md-sidenav').hasClass('md-closed')))
        {
            $timeout(function () {
                $(".parentSide button.menuTextButton.md-button-toggle.md-button.md-ink-ripple").css("display", "none");
                $(".parentSide .upArrowPng").css("display", "none");               
            }, 250);  
            $(".smallArrow").css("display", "block");
            $("md-backdrop.md-sidenav-backdrop").css("left", "245px");
            $scope.searchState = 0;
            $("img.iconNavigation").css("display", "block");
            $("md-sidenav.md-sidenav-left").css("overflow-y", "hidden");
            $scope.collapseAll(false, 0);         

            /*function to collapse menu items in mobile */

            $scope.collapseAll = function (data, index)
            {
                for (var i in $scope.accordianData)
                {
                    if ($scope.accordianData[i] != data)
                    {
                        $scope.accordianData[i].expanded = false;
                    }
                }
                data.expanded = false;
            };
        }

          /*Function called when sidenav opening */

        if (($('md-sidenav').hasClass('md-closed')))
        {
            $(".parentSide button.menuTextButton.md-button-toggle.md-button.md-ink-ripple").css("display", "block");
            $(".parentSide .upArrowPng").css("display", "block");
            $(".smallArrow").css("display", "none");

            if ($(".iconCol").width() > 5)
            {
                $scope.class = "show";
            }
            $scope.searchState = 1;
            $("img.iconNavigation").css("display", "none");
            $("img.upIconNavigation").css("display", "none");

            $scope.collapseAll = function (data, index)
            {
                for (var i in $scope.accordianData)
                {
                    if ($scope.accordianData[i] != data)
                    {
                        $scope.accordianData[i].expanded = false;
                    }
                }

                data.expanded = !data.expanded;
                var totalheight = (index + 1) * 56;

                $timeout(function ()
                {
                    var scrollTop = $('.header-greenband').scrollTop() + $('.header-greenband').height()
                    elementOffset = totalheight,
                        distance = (elementOffset - scrollTop);
                    $('md-sidenav.md-sidenav-left').animate(
                    {
                        scrollTop: distance
                    },
                        'slow');
                }, 25);
            };

        }
        if ($(window).width() < 730) {
            $(".iconNavigation").css("display", "none");

        }
    });

    $timeout(function ()
    {
        if ($(window).width() > 730) {
            $("img.iconNavigation").css("display", "block");

        }
    
        $("md-sidenav.md-sidenav-left").css("overflow-y", "hidden");
    }, 50);

    $timeout(function ()
    {
        $scope.searchState = 0;
    }, 10);

    /*
    $scope.toggleNew = function (index) {
        $rootScope.scrollPosi = $("md-sidenav.md-sidenav-left").scrollTop();
        $scope.nIndex = index
        $scope.state = 1;
        $("md-sidenav.md-sidenav-left").css("overflow-y", "hidden");

        $timeout(function () {
            $(".superSubCol").css("top", $rootScope.scrollPosi);
        }, 5);
    }
    */

    /*Function to toggle to first level Menu */

    $scope.toggleFirst = function (index, data)
    {
        angular.element('md-backdrop.md-sidenav-backdrop-custom').removeClass('disabled');
        var numItems = $('md-backdrop').length;
        if (numItems > 1)
        {
            $("md-backdrop:nth-child(1)").remove();
        }
        $scope.backdrop = 1;
        $scope.leader = {};
        $scope.fIndex = index
        $scope.frState = 1;
        $scope.frStateClick = 1
        $scope.scState = 0;
        $scope.trState = 0;
        $scope.foState = 0;
        $scope.scIndex = null;
        $scope.trIndex = null;
        angular.copy(data, $scope.leader);
        $scope.users = angular.copy($scope.leader);
        $("md-backdrop.md-sidenav-backdrop").css("left", "491px");
    }

    /*Function to toggle to second level Menu */

    $scope.toggleSecondLevel = function (index, data)
    {
        angular.element('md-backdrop.md-sidenav-backdrop-custom').removeClass('disabled');
        var numItems = $('md-backdrop').length;
        if (numItems > 1)
        {
            $("md-backdrop:nth-child(1)").remove();
        }
        $scope.leader = {};
        $scope.scIndex = index
        $scope.scState = 1;
        $scope.scStateClick = 1;
        $scope.trState = 0;
        $scope.foIndex = null;
        $scope.trIndex = null;
        $scope.foState = 0;
        angular.copy(data, $scope.leader);
        $scope.usersecond = angular.copy($scope.leader);
        $scope.titlesecond = $scope.usersecond.title;
        $("md-backdrop.md-sidenav-backdrop").css("left", "735px");
    }

    /*Function to toggle to Third level Menu */

    $scope.toggleThirdLevel = function (index, data)
    {
        angular.element('md-backdrop.md-sidenav-backdrop-custom').removeClass('disabled');
        var numItems = $('md-backdrop').length;
        if (numItems > 1)
        {
            $("md-backdrop:nth-child(1)").remove();
        }
        $(".secondLevelMenu").css("z-index", 62);
        $scope.leader = {};
        $scope.trIndex = index
        $scope.trState = 1;
        $scope.trStateClick = 1;
        $scope.foState = 0;
        $scope.foIndex = null;
        angular.copy(data, $scope.leader);
        $scope.userthird = angular.copy($scope.leader);
        $scope.titlethird = $scope.userthird.title;
        $("md-backdrop.md-sidenav-backdrop").css("left", "980px");
        $scope.scState = 1;  
    }

    /*Function to toggle to fourth level Menu */

    $scope.toggleFourthLevel = function (index, data)
    {
        var numItems = $('md-backdrop').length;
        if (numItems > 1)
        {
            $("md-backdrop:nth-child(1)").remove();
        }
        angular.element('md-backdrop.md-sidenav-backdrop-custom').removeClass('disabled');
        $(".thirdLevelMenu").css("z-index", 62);
        $scope.leader = {};
        $scope.foIndex = index
        $scope.foState = 1;
        $scope.foStateClick = 1;
        angular.copy(data, $scope.leader);
        $scope.userfourth = angular.copy($scope.leader);
        $scope.titlefourth = $scope.userfourth.title;
        $("md-backdrop.md-sidenav-backdrop").css("left", "1225px");
    }

    /*
    $scope.toggleSecond = function (index) {
        $scope.sIndex = index
        $scope.stateSecond = 1;
        $timeout(function () {
            $(".superSubCol").css("top", $rootScope.scrollPosi);
        }, 5);
    }

    $scope.toggleBackSecond = function () {

        $scope.stateSecond = 0;
        $("md-sidenav.md-sidenav-left").scrollTop($rootScope.scrollPosi);

    }
    */

    $scope.mobileToggleBack = function ()
    {
        $scope.scIndex = null;
        $scope.scState = 0;
    }
    $scope.mobileToggleBackSecond = function ()
    {
        $scope.trIndex = null;
        $scope.trState = 0;
    }
    $scope.mobileToggleBackThird = function ()
    {
        $scope.foState = 0;
        $scope.foIndex = null;
    }

    $scope.toggleBack = function ()
    {
        $("md-sidenav.md-sidenav-left").css("overflow-y", "auto");
        $("md-sidenav.md-sidenav-left").scrollTop($rootScope.scrollPosi);
        $scope.state = 0;
    }

    /*Function called to get data from Json */

    $scope.UIIcon = function (json, parentId)
    {
        $scope.accordianData = [];
        this.menuObject = [];
        extractMenuItems(this.menuObject, json, 1);

        for (var i = 0; i < this.menuObject.length; i++)
        {
            var obj = this.menuObject[i];
            $scope.accordianData.push(obj);
        }
        $rootScope.safeApply();
        $timeout(function ()
        {
            $scope.windowHeight = $("md-sidenav").height();
            $scope.iconHeight = $('md-content').height();
        }, 1050);
    }

    /*Function to navigate to aspx page */

    $scope.navigationFunc = function (location)
    {
        sessionStorage.setItem('spId', location.id);
        sessionStorage.setItem('logoutVar', 1);
        window.location.href = location.navigationUrl;
    }

    /*Function to change color icon of selected item while changing the home page as any form */

    $timeout(function ()
    {
        var aTags = $("button.menuTextButton.md-button-toggle.md-button.md-ink-ripple");
        var searchText = "Dashboard";
        var i = 0;

        for (i = 0; i < aTags.length; i++)
        {
            if (aTags[i].textContent.replace(/\s/g, '') == searchText)
            {
                break;
            }
        }

        if ((sessionStorage.getItem('spId') == null) || sessionStorage.getItem('logoutVar') == 2)
        {
            $("md-toolbar").attr("data-isselected", false);
            var position = i + 1;
            $(".md-accordion:nth-child(" + position + ") md-toolbar").attr("data-isselected", true);
        }
    }, 1500);

    if ((sessionStorage.getItem('spId') != null) && sessionStorage.getItem('logoutVar') != 2)
    {
        $scope.isNavItemSelected = function (itemId)
        {
            return (itemId == sessionStorage.getItem('spId'));
        };
    }

    $scope.isNavChildItemSelected = function (itemId)
    {
        return (itemId == sessionStorage.getItem('spId'));
    };

    $rootScope.safeApply = function (fn)
    {
        var phase = this.$root.$$phase;
        if (phase == '$apply')
        {
            if (fn) {
                fn();
            }
        } else {
            this.$apply(fn);
        }
    };
   
      
        var step = 25;
        var scrolling = false;

        // Wire up events for the 'scrollUp' link:
        $(".upIconNavigation").bind("click", function (event) {
            event.preventDefault();
            // Animates the scrollTop property by the specified
            // step.
            $('md-sidenav').animate({
                scrollTop: "-=" + step + "px"
            });
        }).bind("mouseover", function (event) {
            $timeout(function () {
                $("img.iconNavigation").css("display", "block");
            }, 150);
            scrolling = true;
            scrollContent("up");
        }).bind("mouseout", function (event) {
            scrolling = false;
            });
    
            $('md-sidenav').scroll(function () {
                
                if ($('md-sidenav').scrollTop() > 0) {
                    if ($(window).width() > 730) {
                        if ($("md-sidenav").hasClass("md-closed")) {
                            $(".upIconNavigation").css("display", "block");
                        }
                    }
                }
                var intvalue = Math.floor($("md-sidenav").scrollTop() + $("md-sidenav").height()) + 1;
                if (intvalue >= $("md-content").height()) {
                    $("img.iconNavigation").css("display", "none");
                }
            });
      


        $(".iconNavigation").bind("click", function (event) {
            event.preventDefault();
            $('md-sidenav').animate({
                scrollTop: "+=" + step + "px"
            });
        }).bind("mouseover", function (event) {
            scrolling = true;
            scrollContent("down");
        }).bind("mouseout", function (event) {
            scrolling = false;
        });

        $('md-sidenav').scroll(function () {

            if ($('md-sidenav').scrollTop() == 0) {
                $(".upIconNavigation").css("display", "none");
            }
        });
        function scrollContent(direction) {
            var amount = (direction === "up" ? "-=1px" : "+=1px");
            $('md-sidenav').animate({
                scrollTop: amount
            }, 1, function () {
                if (scrolling) {
                    scrollContent(direction);
                }
            });
        }
    
    $timeout(function ()
    {
        $scope.collapseAll = function (data, index)
        {
            for (var i in $scope.accordianData)
            {
                if ($scope.accordianData[i] != data)
                {
                    $scope.accordianData[i].expanded = false;
                }
            }
            data.expanded = false;
        };
        }, 50);
});

function extractMenuItems(parent, menuItemJson, level) {
    $.each(menuItemJson, function (index, value) {
        var menuItem = new MenuItem();
        menuItem.SetId(menuItemJson[index].Id);
        menuItem.SetDescription(menuItemJson[index].MenuDescription);
        menuItem.SetImageUrl(menuItemJson[index].MenuImageUrl);
        menuItem.SetNavigateUrl(menuItemJson[index].MenuNavigateUrl);
        menuItem.SetTitle(menuItemJson[index].MenuTitle);
        menuItem.SetToolTip(menuItemJson[index].ToolTip);
        menuItem.SetContext(menuItemJson[index].MenuContext);
        menuItem.SetOpenMode(menuItemJson[index].OpenMode);
        menuItem.SetLevel(level);
        extractMenuItems(menuItem.subItems, menuItemJson[index].SubItems, level + 1);
        parent.push(menuItem);
    });
}
