// Define the `phonecatApp` module
var app = angular.module('app', []);

app.controller('mainctrl', function ($scope, $http) {
    var main = this;

    debugger
    //$scope.lstemp = "List Schedules";
    main.getData = function () {
        $http.get('/report.schedule').
        success(function (data) {
            main.datas = data.handoverreport;
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

    //$http.get('/getrooms.schedule').
    //success(function (lstrooms) {
    //    lstrooms.room.unshift({ "Name": "Tất cả", "Floor": "1", "TableQuantity": 0, "Detail": null, "ID": 0 });
    //    main.rooms = lstrooms.room;
    //    main.selectedroom = 0;
    //});

    //$http.get('/getsciences.schedule').
    //success(function (lstsciences) {
    //    lstsciences.science.unshift({ "Name": "Tất cả", "Floor": "1", "TableQuantity": 0, "Detail": null, "ID": 0 });
    //    main.sciences = lstsciences.science;
    //    main.selectedscience = 0;
    //});

    //$scope.search = function () {
    //    var selectrooms = document.getElementById("cboRooms").value;
    //    var selectscience = document.getElementById("cboScience").value;
    //    var date = $("#date").datepicker({ dateFormat: 'dd,MM,yyyy' }).val();
    //    var linksearch = '/getall.schedule?roomId=' + selectrooms + '&scienceId=' + selectscience + '&day=' + date;
    //    $http.post(linksearch).success(function (data) {
    //        main.datas = data.schedules;
    //    });
    //};
    $scope.print = function () {
        window.print();
    };
    $scope.edit_report = function (id) {
        var link = '/report.schedule?id=' + id + '&action=4';
        $http.post(link).success(function (data) {
            $("#myModal3").modal({ backdrop: "static" });
            $('.summernote').summernote({
                height: 150,   //set editable area's height
                codemirror: { // codemirror options
                    theme: 'monokai'
                },
            });
            console.log(data.handoverreport);
            $("#handoverid").val(id);
            $("#titleInput").val(data.handoverreport.Title);
            $(".summernote").summernote("code", data.handoverreport.ContentReport);
        });
    }
    $scope.delete_report = function (id) {
        alert('Delete' + id);
    }
    $scope.addnew_report = function () {
        $("#myModal3").modal({ backdrop: "static" });
        $('.summernote').summernote({
            height: 150,   //set editable area's height
            codemirror: { // codemirror options
                theme: 'monokai'
            }
            //},
            //toolbar: [
            //  ['style', ['bold', 'italic', 'underline', 'clear']],
            //  ['misc', ['print']]
            //]
        });
    };
    $scope.insert_report = function () {
        var title = $("#titleInput").val();
        var description = $("#descriptionInput").val();
        var content = $('.summernote').summernote('code');
        var id = $("#handoverid").val();
        var data = $.param({
            content: content,
            title: title,
            description: description,
            id: id != '' ? id : 0,
            scienceId: scienceId,
            action: id != '' ? '1' : '2'
        });
        var config = {
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;'
            }
        }
        var link = '/report.schedule';
        $http.post(link, data, config).success(function () {
            $("#myModal3").modal('hide');
            $("#titleInput").val('');
            $("#descriptionInput").val('');
            $("#handoverid").val('');
            $(".summernote").summernote("code", '');
            main.getData();
        });
    };
    main.getData();
})