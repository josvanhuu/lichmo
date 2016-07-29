<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master"
    CodeFile="DetailsViewOneUser.aspx.cs" Inherits="x" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
<h1>Tài Khoản</h1>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br />
    &nbsp;&nbsp;<table>
        <tr>
            <td style="width: 100px">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="UserName"
                    DataSourceID="ObjectDataSource2" Height="50px" Width="125px" CellPadding="4"
                    ForeColor="#333333" GridLines="None">
                    <Fields>
                        <asp:BoundField DataField="ProviderName" HeaderText="ProviderName" ReadOnly="True"
                            SortExpression="ProviderName" />
                        <asp:CheckBoxField DataField="IsOnline" HeaderText="IsOnline" ReadOnly="True" SortExpression="IsOnline" />
                        <asp:BoundField DataField="LastPasswordChangedDate" HeaderText="LastPasswordChangedDate"
                            ReadOnly="True" SortExpression="LastPasswordChangedDate" />
                        <asp:BoundField DataField="PasswordQuestion" HeaderText="PasswordQuestion" ReadOnly="True"
                            SortExpression="PasswordQuestion" />
                        <asp:CheckBoxField DataField="IsLockedOut" HeaderText="IsLockedOut" ReadOnly="True"
                            SortExpression="IsLockedOut" />
                        <asp:BoundField DataField="Comment" HeaderText="Comment" SortExpression="Comment" />
                        <asp:BoundField DataField="UserName" HeaderText="UserName" ReadOnly="True" SortExpression="UserName" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="CreationDate" HeaderText="CreationDate" ReadOnly="True"
                            SortExpression="CreationDate" />
                        <asp:CheckBoxField DataField="IsApproved" HeaderText="IsApproved" SortExpression="IsApproved" />
                        <asp:BoundField DataField="LastLockoutDate" HeaderText="LastLockoutDate" ReadOnly="True"
                            SortExpression="LastLockoutDate" />
                        <asp:BoundField DataField="LastLoginDate" HeaderText="LastLoginDate" SortExpression="LastLoginDate" />
                        <asp:BoundField DataField="LastActivityDate" HeaderText="LastActivityDate" SortExpression="LastActivityDate" />
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    </Fields>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                    <EditRowStyle BackColor="#999999" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:DetailsView>
            </td>
            <td style="width: 100px">
            </td>
            <td>
                &nbsp;<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1"
                    AllowPaging="True" CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="15">
                    <Columns>
                        <asp:HyperLinkField DataNavigateUrlFields="UserName" DataNavigateUrlFormatString="DetailsViewOneUser.aspx?user={0}"
                            DataTextField="UserName" HeaderText="UserName" SortExpression="UserName" />
                    </Columns>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <EditRowStyle BackColor="#999999" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetMembers"
                    TypeName="MembershipUtilities.MembershipUserODS">
                    <SelectParameters>
                        <asp:Parameter Name="sortData" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                &nbsp;
            </td>
        </tr>
    </table>
    <br />
    <asp:HyperLink ID="Link1" runat="server" NavigateUrl="~/Admin/ManageUserRole/Membership.aspx">&lt;&lt;Back to list</asp:HyperLink>
    <br />
    <br />
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click2" Text="Find User by Username" CssClass="Button" />
    <asp:TextBox ID="TextBox1" runat="server">Enter User To Find Here</asp:TextBox>&nbsp;
    <br />
    <br />
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetMembers"
        TypeName="MembershipUtilities.MembershipUserODS" DeleteMethod="Delete" InsertMethod="Insert"
        UpdateMethod="Update">
        <SelectParameters>
            <asp:Parameter Name="returnAllApprovedUsers" Type="Boolean" DefaultValue="true" />
            <asp:Parameter Name="returnAllNotApprovedUsers" Type="Boolean" DefaultValue="true" />
            <asp:ControlParameter ControlID="TextBox1" DefaultValue="" Name="usernameToFind"
                PropertyName="Text" Type="String" />
            <asp:Parameter Name="sortData" Type="String" DefaultValue="" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="UserName" Type="Object" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="isApproved" Type="Boolean" />
            <asp:Parameter Name="comment" Type="String" />
            <asp:Parameter Name="lastActivityDate" Type="DateTime" />
            <asp:Parameter Name="lastLoginDate" Type="DateTime" />
        </UpdateParameters>
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
    &nbsp;<br />
    &nbsp;
</asp:Content>
