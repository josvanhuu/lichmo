<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="User_Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" type="text/css" href="<%=ResolveUrl("~/lib/boostrap/bootstrap.min.css") %>" />
	<script src="<%=ResolveUrl("~/lib/angular/angular.min.js") %>"></script>
	<script src="<%=ResolveUrl("~/lib/boostrap/bootstrap.min.js") %>"></script>

	<script src="<%=ResolveUrl("~/lib/angular/main.js") %>"></script>
	<link href="<%=ResolveUrl("~/lib/boostrap/lich-mo.css") %>" rel="Stylesheet" />
    <link rel="stylesheet" href="<%=ResolveUrl("~/lib/boostrap/bootstrap-datepicker3.css") %>"/>
    <link rel="stylesheet" type="text/css" media="print" href="<%=ResolveUrl("~/lib/print/print.css") %>">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container" ng-app="app" ng-controller="mainctrl as main">
	    <h2 class="sub-header" style="display:none;">Danh sách mổ</h2>
         <%--<form class="form-inline" role="form">--%>
        <div class="form-search hide-print">
            <div class="form-group pull-left">
                <label for="cboRooms">Chọn phòng</label>
                <select class="form-control" name="cboRooms" id="cboRooms" 
                    ng-options="room.Name for room in main.rooms track by room.ID"
                    ng-model="selectedroom"
                    >
                    <%--<option value="0" label="Tat car" selected="selected">Tat ca</option>--%>
                </select>
            </div>
            <div class="form-group pull-left">
                <label for="cboScience">Chọn Khoa</label>
                <select class="form-control" name="cboScience" id="cboScience"
                    ng-options="science.Name for science in main.sciences track by science.ID"
                    ng-model="selectedscience"
                    >
                    <%--<option value="0" label="Tat car" selected="selected">Tat ca</option>--%>
                </select>
            </div>            
            <div class="form-group pull-right">
                <label for="date">Ngày</label>
                <input class="form-control" id="date" name="date" placeholder="MM/DD/YYY" type="text"/>
                 <script type="text/javascript">
                    $(document).ready(function(){
                        var date_input=$('input[name="date"]'); //our date input has the name "date"
                        var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
                        var options={
                        format: 'mm/dd/yyyy',
                        container: container,
                        todayHighlight: true,
                        autoclose: true,
                        };
                        date_input.datepicker(options);
                    })
                </script>
            </div>
            
        <%--</form>--%>
        </div>
        
        <div class="table table-responsive">
            <div class="well well-sm button-action hide-print">
                <button class="btn btn-default pull-left" type="button" ng-click="print()">
                    <i class="glyphicon glyphicon-print"></i>
                    Print
                </button>
                <button class="btn btn-default pull-right" type="button" ng-click="search()">
                    <i class="glyphicon glyphicon-search"></i>
                    Tìm kiếm
                </button>
                <button class="btn btn-success pull-right" type="button" ng-click="changestatusRoles()">
                    <i class="glyphicon glyphicon-saved"></i>
                    Duyệt Mổ
                </button>
            </div>
            <table class="table table-fixed table-bordered"> <%--table table-bordered table-striped--%>
                <thead>
                    <tr class="bg-warning">
                        <th>Khoa</th>
                        <%--<th>Buồng</th>--%>
                        <th class="text-center">Ngày sinh</th>
                        <%--<th class="text-center">TT</th>
                        <th class="text-center">Bàn</th>--%>
                        <th>Bệnh Nhân</th>
                        <th>Phẫu thuật viên</th>
                        <%--<th>B/s phụ</th>--%>
                        <th>Triệu chứng</th>
                        <th class="text-center">Y/N</th>
						<th class="text-center hide-print"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="schedule in main.datas">
                        <td>{{schedule.ScienceName}}</td>
                        <%--<td>{{schedule.RoomName}}</td>--%>
                        <td class="text-center">{{schedule.Birthday}}</td>
                        <%--<td class="text-center">{{schedule.OrderNumber}}</td>
                        <td class="text-center">{{schedule.NumberOfTable}}</td>--%>
                        <td>{{schedule.Name}}</td>
                        <td>{{schedule.PTVName}}</td>
                        <%--<td>{{schedule.DDName}}</td>--%>
                        <td>{{schedule.Detail}}</td>
						<td class="text-center">
							<img src="../lib/boostrap/icon/{{schedule.ButtonStyle}}" />
						</td>
						<td class="text-center hide-print ">
							<input type="checkbox" ng-model="contact.IsChecked" ng-change="collectNumbers(contact,schedule.ID)" ng-checked="contact.IsChecked">
						</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>