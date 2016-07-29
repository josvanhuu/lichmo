<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Science_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Khoa</h1>
    <div class="form">
    <asp:Panel ID="pnList" runat="server">
    <asp:GridView ID="gvScience" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="false" Width="100%" OnRowCommand="gvScience_RowCommand" DataKeyNames="ID">
        <EmptyDataTemplate>Chưa có dữ liệu</EmptyDataTemplate>
        <Columns>
            <asp:TemplateField  ItemStyle-Width="100px">                            
                <HeaderTemplate>
                    <input type="checkbox" onchange="if(this.checked==true){CheckAll('chkId');}else{UnCheckAll('chkId');}" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkId" runat="server" Visible='<%# Eval("ID").ToString()!="9" %>'/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText='Sửa'  ItemStyle-Width="100px">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="EditItem"><img src="<%=ResolveUrl("~/image/1400500374_document_edit.png") %>" width="24" /></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Name" HeaderText='Tên khoa' HeaderStyle-HorizontalAlign="Left" />            
        </Columns>
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <FooterStyle BackColor="#428BCA" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#428BCA" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    <div class="nav">
        <asp:Button ID="btnAddNew" runat="server" CssClass="button" Text="Thêm mới" OnClick="btnAddNew_Click" Width="100px" />
        <asp:Button ID="btnDelete" runat="server" CssClass="button cancel" Text="Xóa" OnClick="btnDelete_Click" Width="100px" />
    </div>
    </asp:Panel>
    <asp:Panel ID="pnEdit" runat="server" Visible="false">
        <table width="100%" cellpadding="5" cellspacing="0" border="0">
        <tr>
            <td>Tên khoa:  </td>
            <td><asp:TextBox ID="txtName" runat="server" Width="300px"></asp:TextBox></td>            
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td colspan="4">
                Thông tin chi tiết:<br /><br />
                <asp:TextBox ID="txtDetail" runat="server" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        </table>
        <div class="nav">
            <asp:HiddenField ID="hfID" runat="server" />
            <asp:Button ID="btnSave" runat="server" CssClass="button" Text="Lưu" OnClick="btnSave_Click" Width="100px" />
            <asp:Button ID="btnCancel" runat="server" CssClass="button cancel" Text="Hủy bỏ" OnClick="btnCancel_Click" Width="100px" />
        </div>
        <script type="text/javascript">
            CKEDITOR.replace('<%=txtDetail.ClientID %>');
        </script>
    </asp:Panel>
        
    </div>
</asp:Content>

