<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UserUpdate.aspx.cs" Inherits="Admin_ManageUserRole_UserUpdate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Nhân viên</h1>
<div class="form">
    <%--<asp:Button ID="Button1" runat="server" Text='<%$ Resources:AdminRes,Save %>' OnClick="btnSave_Click" CssClass="Button" ValidationGroup="member" CausesValidation="true"/>
    <input type="reset" value="<%=GetGlobalResourceObject("AdminRes", "Reset")%>" class="Button" />    --%>
    
        <table width="100%" cellpadding="5" cellspacing="0" border="0">
             <tr>
                <td >Tên truy cập:</td>
                <td>
                    <asp:TextBox ID="txtUserName" runat="server" Width="300px"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Hãy nhập tên truy cập." ControlToValidate="txtUserName" SetFocusOnError="true" ValidationGroup="member" Display="dynamic"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage='Tên truy cập đã có.' Display="dynamic" OnServerValidate="CheckUsername" ControlToValidate="txtUserName" SetFocusOnError="true" ValidationGroup="member"></asp:CustomValidator>
                </td>        
                 <td >Họ tên:</td>
                <td><asp:TextBox ID="txtComment" runat="server" Width="300px"></asp:TextBox></td>                 
                            
            </tr>
            <tr>
                <td >Mật khẩu:</td>
                <td><asp:TextBox ID="txtPassword" runat="server" Width="300px" TextMode="password"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Hãy mật khẩu." ControlToValidate="txtPassword" SetFocusOnError="true" ValidationGroup="member" Display="dynamic"></asp:RequiredFieldValidator>
                </td>
                <td >Chức vụ:</td>
                <td><asp:DropDownList ID="ddlDepartment" runat="server">
                    <asp:ListItem>Bác sỹ phẫu thuật</asp:ListItem>
                    <asp:ListItem>Bác sỹ gây mê</asp:ListItem>
                    <asp:ListItem>Kỹ thuật viên gây mê</asp:ListItem>
                </asp:DropDownList></td> 
                       
            </tr>
            <tr>
                <td >Khoa:</td>
                <td><asp:DropDownList ID="ddlScience" runat="server" DataTextField="Name" DataValueField="ID"></asp:DropDownList></td>                        
                    <td class="hide">Email:</td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server" Width="300px" Visible="false"></asp:TextBox><br />
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage='Email đã có' Display="dynamic" OnServerValidate="CheckEmail" ControlToValidate="txtEmail" SetFocusOnError="true" ValidationGroup="member"></asp:CustomValidator>
                </td>       
            </tr>
            <tr>
                <td >Đồng ý truy cập:</td>
                <td><asp:CheckBox ID="chkApprove" runat="server" /></td>            
                <td></td>
                <td></td>
            </tr>    
            <tr>
                <td >Quyền:</td>
                <td bgcolor="#F7F6F3" colspan="3">
                    <asp:DataList ID="dtlRole" runat="server" RepeatColumns="2" RepeatDirection="vertical" Width="300px">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkId" runat="server"/><%# Container.DataItem.ToString()%>
                            <asp:HiddenField ID="hfRole" runat="server" Value='<%# Container.DataItem %>' />
                        </ItemTemplate>
                    </asp:DataList>
                </td>            
            </tr>            
        </table>
        <div class="nav">
    <asp:Button ID="Button2" runat="server" Text='Lưu' OnClick="btnSave_Click" CssClass="button" ValidationGroup="member" CausesValidation="true" Width="100px"/>
    <asp:Button ID="btnCancel" runat="server" CssClass="button cancel" Text="Hủy bỏ" OnClick="btnCancel_Click" Width="100px" />
    </div>
    <asp:ObjectDataSource ID="ObjectDataSourceMembershipUser" runat="server" 
        InsertMethod="Insert" SelectMethod="GetMembers" TypeName="MembershipUtilities.MembershipUserODS"
        UpdateMethod="Update">        
        <UpdateParameters>
            <asp:Parameter Name="userName" Type="String" />
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
    </div>
</asp:Content>

