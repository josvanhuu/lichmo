<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master"
    CodeFile="Membership.aspx.cs" Inherits="Admin_Membership" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
<h1>Nhân viên</h1>
<div class="form">
    <table border="0" width="100%">
        <tr>
            <td>
                <asp:TextBox ID="txtUsername" runat="server" Width="300px" placeholder="Tìm kiếm theo username hoặc tên"></asp:TextBox>   
                <asp:DropDownList ID="ddlScience" runat="server" DataTextField="Name" DataValueField="ID"></asp:DropDownList>
    <asp:Button ID="btnApply" runat="server" CssClass="button" Text="Tìm kiếm" OnClick="btnApply_Click" Width="100px" />
    <asp:Button ID="btnRemove" runat="server" CssClass="button" Text="Hủy bỏ" OnClick="btnRemove_Click" Width="100px" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridViewMemberUser" runat="server" OnSelectedIndexChanged="GridViewMembershipUser_SelectedIndexChanged"
                    OnRowDeleted="GridViewMembership_RowDeleted" AllowPaging="True" AutoGenerateColumns="False"
                    OnRowCommand="GridViewMembershipUser_RowCommand" DataKeyNames="UserName" DataSourceID="ObjectDataSourceMembershipUser"
                    AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:HyperLinkField DataNavigateUrlFields="UserName" DataNavigateUrlFormatString="UserUpdate.aspx?user={0}"
                            DataTextField="UserName" HeaderText='Tên truy cập' SortExpression="UserName" HeaderStyle-HorizontalAlign="Left" />
                        
                        <asp:BoundField DataField="PasswordQuestion" HeaderText="PasswordQuestion" ReadOnly="True"
                            SortExpression="PasswordQuestion" Visible="false" />
                        <asp:BoundField DataField="Comment" HeaderText='Họ Tên' SortExpression="Comment" HeaderStyle-HorizontalAlign="Left" />
                        <asp:TemplateField HeaderText="Khoa">
                            <ItemTemplate>
                                <%# GetKhoa(Eval("UserName")) %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CreationDate" HeaderText="CreationDate" ReadOnly="True"
                            SortExpression="CreationDate" Visible="false" />                        
                        <asp:BoundField DataField="LastLockoutDate" Visible="False" HeaderText="LastLockoutDate"
                            ReadOnly="True" SortExpression="LastLockoutDate" />
                        <asp:BoundField DataField="LastLoginDate" HeaderText='Ngày đăng nhập' SortExpression="LastLoginDate"  />
                        <asp:CheckBoxField DataField="IsOnline" HeaderText='Trực tuyến' ReadOnly="True" SortExpression="IsOnline"  />
                        <asp:TemplateField HeaderText='Khóa' >
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="IsLockedOut" Checked='<%# Eval("IsLockedOut") %>'
                                    Enabled="false" Visible='<%# !(bool)Eval("IsLockedOut") %>' />
                                <asp:Button runat="server" ID="btnUnlock" Visible='<%# Eval("IsLockedOut") %>' CommandName="Unlock"
                                    CommandArgument='<%# Eval("UserName") %>' Text="Unlock" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="LastActivityDate" HeaderText="LastActivityDate" SortExpression="LastActivityDate"
                            Visible="False" />
                        <asp:BoundField DataField="LastPasswordChangedDate" HeaderText="LastPasswordChangedDate"
                            Visible="False" ReadOnly="True" SortExpression="LastPasswordChangedDate" />
                        <asp:BoundField DataField="ProviderName" HeaderText="ProviderName" ReadOnly="True"
                            Visible="False" SortExpression="ProviderName" />
                    </Columns>
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <FooterStyle BackColor="#428BCA" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#428BCA" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#428BCA" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjectDataSourceMembershipUser" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" SelectMethod="GetMembers" TypeName="MembershipUtilities.MembershipUserODS"
                    UpdateMethod="Update" SortParameterName="SortData" >
                    <DeleteParameters>
                        <asp:Parameter Name="UserName" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="email" Type="String" />
                        <asp:Parameter Name="isApproved" Type="Boolean" />
                        <asp:Parameter Name="comment" Type="String" />
                        <asp:Parameter Name="lastActivityDate" Type="DateTime" />
                        <asp:Parameter Name="lastLoginDate" Type="DateTime" />
                    </UpdateParameters>
                    <SelectParameters>                       
                        <asp:Parameter Name="returnAllApprovedUsers" Type="Boolean" DefaultValue="true" />
                        <asp:Parameter Name="returnAllNotApprovedUsers" Type="Boolean" DefaultValue="true" />
                        <asp:Parameter Name="usernameToFind" Type="String" />
                        <asp:Parameter Name="sortData" Type="String" />
                        <asp:Parameter Name="science" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="userName" Type="String" />
                        <asp:Parameter Name="isApproved" Type="Boolean" />
                        <asp:Parameter Name="comment" Type="String" />
                        <asp:Parameter Name="lastLockoutDate" Type="DateTime" />
                        <asp:Parameter Name="creationDate" Type="DateTime" />
                        <asp:Parameter Name="email" Type="String" />
                        <asp:Parameter Name="lastActivityDate" Type="DateTime" />
                        <asp:Parameter Name="providerName" Type="String" />
                        <asp:Parameter Name="isLockedOut" Type="Boolean" />
                        <asp:Parameter Name="lastLoginDate" Type="DateTime" />
                        <asp:Parameter Name="isOnline" Type="Boolean" />
                        <asp:Parameter Name="passwordQuestion" Type="String" />
                        <asp:Parameter Name="lastPasswordChangedDate" Type="DateTime" />
                        <asp:Parameter Name="password" Type="String" />
                        <asp:Parameter Name="passwordAnswer" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <div class="nav">
                <asp:Button ID="btnAdd" runat="server" Text='Thêm mới' OnClientClick="javascript:location.href='UserUpdate.aspx';return false;" CssClass="button" Width="100px" />
                </div>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table>
        <tr>
            <td>
                <asp:GridView ID="GridViewRole" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSourceRoleObject"
                    DataKeyNames="RoleName" CellPadding="4" AllowPaging="True" ForeColor="#333333"
                    GridLines="None" Width="100%">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" DeleteText="Delete Role" />                        
                        <asp:TemplateField HeaderText='Quyền' SortExpression="RoleName">
                            <ItemTemplate>
                                <%# Eval("RoleName") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="NumberOfUsersInRole" HeaderText='Số người'
                            SortExpression="NumberOfUsersInRole"  />                        
                        <asp:CheckBoxField DataField="UserInRole" HeaderText="UserInRole" Visible="False"
                            SortExpression="UserInRole" />
                    </Columns>
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <FooterStyle BackColor="#428BCA" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#428BCA" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView>
            </td>
            </tr>
            <tr>
            <td>
                <asp:CheckBox ID="CheckBoxShowRolesAssigned" runat="server" AutoPostBack="True" Text='Hiện quyền có người' />
            </td>
        </tr>
        <tr>
            <td>
                <div class="nav">
                <asp:Button ID="ButtonCreateNewRole" CssClass="button" runat="server" OnClick="ButtonCreateNewRole_Click"
                    Text='Tạo quyền mới' />
                <asp:TextBox ID="TextBoxCreateNewRole" runat="server" Height="24px"></asp:TextBox>
                </div>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <asp:ObjectDataSource ID="ObjectDataSourceRoleObject" runat="server" SelectMethod="GetRoles"
        TypeName="MembershipUtilities.RoleDataObject" InsertMethod="Insert" DeleteMethod="Delete">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridViewMemberUser" Name="UserName" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="CheckBoxShowRolesAssigned" Name="ShowOnlyAssignedRolls"
                PropertyName="Checked" Type="Boolean" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="RoleName" Type="String" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="RoleName" Type="String" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    </div>
</asp:Content>
