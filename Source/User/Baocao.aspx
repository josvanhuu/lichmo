<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Baocao.aspx.cs" Inherits="User_Baocao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <asp:Literal ID="ltSience" runat="server"></asp:Literal>
    <link rel="stylesheet" type="text/css" href="<%=ResolveUrl("~/lib/boostrap/bootstrap.min.css") %>" />
	<script src="<%=ResolveUrl("~/lib/angular/angular.min.js") %>"></script>
	<script src="<%=ResolveUrl("~/lib/boostrap/bootstrap.min.js") %>"></script>

	<script src="<%=ResolveUrl("~/lib/angular/report.js") %>"></script>
	<link href="<%=ResolveUrl("~/lib/boostrap/lich-mo.css") %>" rel="Stylesheet" />
    <link rel="stylesheet" href="<%=ResolveUrl("~/lib/boostrap/bootstrap-datepicker3.css") %>"/>
    <link rel="stylesheet" type="text/css" media="print" href="<%=ResolveUrl("~/lib/print/print.css") %>">

    <!-- include codemirror (codemirror.css, codemirror.js, xml.js, formatting.js) -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet"/>
      <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js"></script> 
      <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
      <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.1/summernote.css" rel="stylesheet"/>
      <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.1/summernote.js"/>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container" ng-app="app" ng-controller="mainctrl as main">
	    <h2 class="sub-header" style="display:none;">Báo cáo</h2>
        <div class="table table-responsive">
            <div class="well well-sm button-action hide-print">
                <%--<button class="btn btn-default pull-left" type="button" ng-click="print()">
                    <i class="glyphicon glyphicon-print"></i>
                    Print
                </button>--%>
                <button class="btn btn-default pull-left" type="button" ng-click="addnew_report()">
                    <i class="glyphicon glyphicon-plus"></i>
                    Thêm báo cáo
                </button>
                <%--<button class="btn btn-default pull-right" type="button" ng-click="search()">
                    <i class="glyphicon glyphicon-search"></i>
                    Tìm kiếm
                </button>
                <button class="btn btn-success pull-right" type="button" ng-click="changestatusRoles()">
                    <i class="glyphicon glyphicon-saved"></i>
                    Chuyển trạng thái
                </button>--%>
            </div>
            <table class="table table-fixed table-bordered"> <%--table table-bordered table-striped--%>
                <thead>
                    <tr class="bg-warning">
                        <%--<th>STT</th>--%>
                        <th>Tiêu đề</th>
                        <th class="text-center">Trích lược</th>
                        <th class="text-center">Ngày tạo</th>
                        <th>Khoa</th>
                        <th class="text-center">Status</th>
						<th class="text-center">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="handoverreport in main.datas">
                        <%--<td>{{handoverreport.lenght}}</td>--%>
                        <td>{{handoverreport.Title}}</td>
                        <td>{{handoverreport.Description}}</td>
                        <td class="text-center">{{handoverreport.DateCreateString}}</td>
                        <td>{{handoverreport.ScienceName}}</td>
						<td class="text-center">
							<img src="../lib/boostrap/icon/{{handoverreport.StatusStyle}}" />
						</td>
						<td class="text-center">
                            <button class="btn btn-success btn-sm" type="button" ng-click="edit_report(handoverreport.ID)">
                                <i class="glyphicon glyphicon-pencil"></i>
                            </button>
                            <button class="btn btn-danger btn-sm" type="button" ng-click="delete_report(handoverreport.ID)">
                                <i class="glyphicon glyphicon-remove"></i>
                            </button>
						</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <!-- Modal -->
          <div class="modal fade" id="myModal3" role="dialog">
            <div class="modal-dialog">
    
              <!-- Modal content-->
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">×</button>
                  <h4 class="modal-title">Them moi Bao cao</h4>
                </div>
                <div class="modal-body">
                    <input type="text" class="hidden" id="handoverid" />
                    <div class="form-group">
                        <label for="titleInput">Tiêu đề</label>
                        <input type="text" class="form-control" id="titleInput" placeholder="Tiêu đề">
                    </div>
                    <div class="form-group">
                        <label for="titleInput">Trích lược</label>
                        <input type="text" class="form-control" id="descriptionInput" placeholder="Tiêu đề">
                    </div>
                    <div class="summernote"></div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-success" ng-click="insert_report()">Save</button>
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
              </div>
      
            </div>
          </div>
    </div>
</asp:Content>