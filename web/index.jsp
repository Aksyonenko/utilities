<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Utilities app</title>

    <!-- Angular Material style sheet -->
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/angular_material/1.0.0/angular-material.min.css">

    <!-- Angular Material requires Angular.js Libraries -->
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-animate.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-aria.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-messages.min.js"></script>

    <!-- Angular Material Library -->
    <script src="http://ajax.googleapis.com/ajax/libs/angular_material/1.0.0/angular-material.min.js"></script>
    <script>
        var app = angular.module('utilitiesApp', ['ngMaterial']);


        app.controller('UtilitiesController', ['$scope', '$http', function ($scope, $http) {

            $scope.saveUtilities = function () {
                if ($scope.utilitiesForm.$invalid) {
                    console.log('utilitiesForm is invalid');
                    return;
                }
                $http({
                    method: 'POST',
                    url: 'utilitiesServlet',
                    datatype: "json",
                    data: $scope.utility
                }).success(function (data, status, headers, config) {
                    console.log('Utilities have been saved successfully');
                }).error(function (data, status, headers, config) {
                    console.log('Error while saving utilities');
                });
            };

            $scope.loadUtilities = function () {
                $http({
                    method: 'GET',
                    url: 'utilitiesServlet'
                }).success(function (data, status, headers, config) {
                    $scope.utility = data;
                    $scope.countSummary();
                }).error(function (data, status, headers, config) {
                    console.log('Error while loading utilities');
                });
            };

            $scope.clear = function () {
                $scope.utility = {};
            };
            $scope.countSummary = function () {
                console.log($scope.utility);
                $scope.utility.summary =
                        $scope.utility.electricity +
                        $scope.utility.gas +
                        $scope.utility.hotWater +
                        $scope.utility.coldWater +
                        $scope.utility.heating;
            };
        }]);

        app.config(function ($mdThemingProvider) {
            // Configure a dark theme with primary foreground yellow
            $mdThemingProvider.theme('docs-dark', 'default')
                    .primaryPalette('yellow')
                    .dark();
        });


    </script>
</head>
<body>
<div ng-app="utilitiesApp" ng-cloak>
    <md-content md-theme="docs-dark" layout-gt-sm="row" layout-padding ng-controller="UtilitiesController">
        <div>
            <form name="utilitiesForm">
                <md-input-container>
                    <label>Electricity</label>
                    <input ng-model="utility.electricity" type="number" step="1" ng-change="countSummary()"
                           ng-required="true" ng-model-options="{debounce: {'default': 1000, 'blur': 0}}">
                </md-input-container>
                <md-input-container>
                    <label>Gas</label>
                    <input ng-model="utility.gas" type="number" step="1" ng-change="countSummary()" ng-required="true">
                </md-input-container>
                <md-input-container>
                    <label>Hot water</label>
                    <input ng-model="utility.hotWater" type="number" step="1" ng-change="countSummary()"
                           ng-required="true">
                </md-input-container>
                <md-input-container>
                    <label>Cold water</label>
                    <input ng-model="utility.coldWater" type="number" step="1" ng-change="countSummary()"
                           ng-required="true">
                </md-input-container>
                <md-input-container>
                    <label>Heating</label>
                    <input ng-model="utility.heating" type="number" step="1" ng-change="countSummary()"
                           ng-required="true">
                </md-input-container>
                <md-input-container>
                    <label>Summary(disabled)</label>
                    <input ng-model="utility.summary" type="number" step="0.01" disabled
                           ng-model-options="{debounce: 5000}">
                </md-input-container>
                <md-button class="md-raised md-primary" ng-click="clear()">Clear</md-button>
                <md-button class="md-raised md-primary" ng-click="saveUtilities()">Save</md-button>
                <md-button class="md-raised md-primary" ng-click="loadUtilities()">Load</md-button>
            </form>
        </div>
    </md-content>
</div>
</body>
</html>
