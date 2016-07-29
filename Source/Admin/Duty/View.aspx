<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="View.aspx.cs" Inherits="Admin_Duty_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Xem <%=Request["type"].ToString()=="ltm"?"Lịch Trực":"Lịch Cấp Cứu Tuyến" %></h1>
<div class="form">
<asp:TextBox ID="txtFromdate" runat="server" Width="300px" placeholder="-- Từ ngày --"></asp:TextBox>   
    <asp:TextBox ID="txtTodate" runat="server" Width="300px" placeholder="-- Đến ngày --"></asp:TextBox>   
    <asp:Button ID="btnApply" runat="server" CssClass="button" Text="Tìm kiếm" OnClick="btnApply_Click" Width="100px" />
    <asp:Button ID="btnRemove" runat="server" CssClass="button" Text="Hủy bỏ" OnClick="btnRemove_Click" Width="100px" /><br /><br />
<asp:GridView ID="gvDuty" runat="server" CellPadding="8" ForeColor="#333333" GridLines="None" AutoGenerateColumns="false" Width="100%">
    <EmptyDataTemplate>Chưa có dữ liệu</EmptyDataTemplate>
    <Columns>        
        <asp:TemplateField HeaderText='Thứ' ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
            <ItemTemplate>
            <%# GetDayWeek((int)Convert.ToDateTime(Eval("FromDate")).DayOfWeek)%>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="FromDate" HeaderText='Ngày' DataFormatString="{0:dd/MM/yyyy}" HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="BSName" HeaderText='Bác sĩ' HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="KTVName" HeaderText='Kỹ thuật viên' HeaderStyle-HorizontalAlign="Left" />            
            <%--<asp:TemplateField HeaderText='Khoa' ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
            <ItemTemplate>
            <%# GetScienceName(Eval("ScienceId"))%>
            </ItemTemplate>
        </asp:TemplateField>  --%>          
    </Columns>
    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    <FooterStyle BackColor="#428BCA" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#428BCA" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#999999" />
    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
</asp:GridView>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $("#<%=txtFromdate.ClientID %>").datepicker({ dateFormat: 'dd/mm/yy' });
        $("#<%=txtTodate.ClientID %>").datepicker({ dateFormat: 'dd/mm/yy' });
    });
</script>
</asp:Content>

