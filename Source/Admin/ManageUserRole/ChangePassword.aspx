<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" MasterPageFile="~/MasterPage.master" Inherits="Admin_ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" ID="Content2" runat="server">
    <h1>Thay Mật Khẩu</h1>
    <div class="form">
    <asp:ChangePassword ID="ChangePassword1" runat="server" OnContinueButtonClick="ChangePassword1_ContinueButtonClick" ChangePasswordButtonStyle-CssClass="button" CancelButtonStyle-CssClass="button cancel" ContinueButtonStyle-CssClass="button" OnCancelButtonClick="ChangePassword1_CancelButtonClick"
     ChangePasswordTitleText="" PasswordLabelText="Mật khẩu cũ:" NewPasswordLabelText="Mật khẩu mới:" ConfirmNewPasswordLabelText="Nhập lại mật khẩu mới:" ChangePasswordButtonText="Lưu" ChangePasswordButtonStyle-Width="100px" CancelButtonText="Hủy bỏ" CancelButtonStyle-Width="100px">
    </asp:ChangePassword>
    </div>
</asp:Content>