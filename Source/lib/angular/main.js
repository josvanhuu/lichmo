// Define the `phonecatApp` module
var app = angular.module('app', []);

app.controller('mainctrl', function ($scope, $http) {
	var main = this;
    
    //$scope.lstemp = "List Schedules";
	main.getData = function () {
	    $http.get('/getall.schedule').
        success(function (data) {
            main.datas = data.schedules;
        });
	};

	var roles = [];
	$scope.collectNumbers = function (contact, index) {
		if (contact.IsChecked) {
			 roles.push(index);
		}
		else {
			roles.pop(index);
		}
	};

	$scope.changestatusRoles = function () {
	    var link = '/changestatus.schedule?id=' + roles;
	    console.log(link);
	    $http.post(link).success(function () {
	        roles.length = 0;
	        $scope.search();
	        //main.getData();
	    });
	};

    $http.get('/getrooms.schedule').
    success(function (lstrooms) {
        lstrooms.room.unshift({ "Name": "Tất cả", "Floor": "1", "TableQuantity": 0, "Detail": null, "ID": 0 });
        main.rooms = lstrooms.room;
        main.selectedroom = 0;
    });

    $http.get('/getsciences.schedule').
    success(function (lstsciences) {
        lstsciences.science.unshift({ "Name": "Tất cả", "Floor": "1", "TableQuantity": 0, "Detail": null, "ID": 0 });
        main.sciences = lstsciences.science;
        main.selectedscience = 0;
    });
	
	$scope.search = function () {
	    var selectrooms = document.getElementById("cboRooms").value;
	    var selectscience = document.getElementById("cboScience").value;
	    var date = $("#date").datepicker({ dateFormat: 'dd,MM,yyyy' }).val();
	    var linksearch = '/getall.schedule?roomId=' + selectrooms + '&scienceId=' + selectscience + '&day=' + date;
	    $http.post(linksearch).success(function (data) {
	        main.datas = data.schedules;
	    });
	};
	$scope.print = function () {
	    window.print();
	};
    //demo
	$scope.report = function () {
	   // var content = document.getElementById("content").value;
	   // var scienceId = document.getElementById("cboScience").value;
	    var reportId = 5;//doc.getElementById('reportId').value;
        //insert
	    //var link = '/report.schedule?action=1&content=' + content + '&scienceId=' + scienceId;
        //update
	    //var link = '/report.schedule?action=2&reportId=' + reportId + '&content=' + content + '&scienceId=' + scienceId;
	    //delete
	    var link = '/report.schedule?action=3&reportId=' + reportId;
	    //getall
	    //var link = '/report.schedule';
	    console.log(link);
	    $http.post(link).success(function () {
	        roles.length = 0;
	        $scope.search();
	        //main.getData();
	    });
	};
	main.getData();    
})