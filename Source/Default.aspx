<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<center>
<table border="0" cellspacing="0" cellpadding="0" width="480">
    <tr>
        <td style="padding:20px">
            <button type="button" class="btn btn-primary btn-lg" style="width:200px; height:200px;" onclick="location.href='<%=ResolveUrl("~/admin/schedule/view.aspx") %>'">
              <span class="glyphicon glyphicon-calendar" style="font-size:40px;"></span><br /><br />
              Lịch Mổ
            </button>
        </td>
        <td style="padding:20px">
            <button type="button" class="btn btn-success btn-lg" style="width:200px; height:200px;" onclick="location.href='<%=ResolveUrl("~/admin/duty/view.aspx?type=ltm") %>'">
              <span class="glyphicon glyphicon-time" style="font-size:40px;"></span><br /><br />
              Lịch Trực
            </button>
        </td>
    </tr>
    <tr>
        <td style="padding:20px">
            <button type="button" class="btn btn-warning btn-lg" style="width:200px; height:200px;" onclick="location.href='<%=ResolveUrl("~/admin/duty/view.aspx?type=lcc") %>'">
              <span class="glyphicon glyphicon-flag" style="font-size:40px;"></span><br /><br />
              Lịch Cấp Cứu Tuyến
            </button>
        </td>
        <td style="padding:20px">
            <button type="button" class="btn btn-info btn-lg" style="width:200px; height:200px;" onclick="location.href='<%=ResolveUrl("~/admin/report/") %>'">
              <span class="glyphicon glyphicon-stats" style="font-size:40px;"></span><br /><br />
              Thống kê
            </button>
        </td>
        
        <%--<td style="padding:20px">
            <button type="button" class="btn btn-danger btn-lg" style="width:200px; height:200px;" onclick="location.href='<%=ResolveUrl("~/login.aspx") %>'">
              <span class="glyphicon glyphicon-log-out" style="font-size:40px;"></span><br /><br />
              Thoát
            </button>
        </td>--%>
    </tr>
</table>
</center>
</asp:Content>

