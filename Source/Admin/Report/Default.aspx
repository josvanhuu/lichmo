<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Report_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Thống kê</h1>
<div class="form">
<div class="row">
  <div class="col-md-4">
    <fieldset>
    <legend>Theo ngày</legend>
    <asp:CheckBox ID="chkDate" runat="server" Text="Thêm ngày vào thống kế" />
    <table border="0">
        <tr>
            <td>
                Từ ngày:<br />
                <asp:TextBox ID="txtFromDate" runat="server"></asp:TextBox>
            </td>
            <td>
                Đến ngày:<br />
                <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>
            </td>
        </tr>
        
    </table>
</fieldset>
  </div>
  <div class="col-md-4">
  <fieldset>
    <legend>Theo phòng</legend>
    <asp:CheckBox ID="chkRoom" runat="server" Text="Thêm phòng vào thống kế"/>
    <table border="0">
        <tr>
            <td>
                Tên phòng:<br />
                <asp:DropDownList ID="ddlRoom" runat="server" DataValueField="ID" DataTextField="Name"></asp:DropDownList>
            </td>  
        </tr>
        
    </table>
</fieldset>
  </div>
  <div class="col-md-4">
    <fieldset>
    <legend>Theo khoa</legend>
    <asp:CheckBox ID="chkScience" runat="server" Text="Thêm khoa vào thống kế"/>
    <table border="0">
        <tr>
            <td>
                Tên khoa:<br />
                <asp:DropDownList ID="ddlScience" runat="server" DataValueField="ID" DataTextField="Name"></asp:DropDownList>
            </td>  
        </tr>        
    </table>
</fieldset>
  </div>
</div>
<div class="nav"><asp:Button ID="btnApply3" runat="server" CssClass="button" OnClick="btnApply1_Click" Text="Xem kết quả" Width="100px" /></div>


<fieldset>
    <legend>Kết quả</legend>
    Tổng số ca mổ là:
    <asp:Label ID="liTotal" runat="server" ForeColor="Red" Font-Size="14px" Font-Bold="true"></asp:Label>
</fieldset>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $("#<%=txtToDate.ClientID %>").datepicker({ dateFormat: 'dd/mm/yy' });
        $("#<%=txtFromDate.ClientID %>").datepicker({ dateFormat: 'dd/mm/yy' });
    });
</script>
</asp:Content>

