<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Quản lý lịch mổ</title>
</head>
<body>
    <form id="form1" runat="server">
        <center>
            <div style="margin-top: 150px; width:380px; border:solid 1px #004A66; font-family:Arial;">
                <div style="background:#004A66; color:#fff; line-height:40px; font-weight:bold;">Quản lý lịch mổ</div>
                <table width="100%" cellpadding="5" cellspacing="0">
                    <tr>                                            
                        <td align="center">
                            <asp:Login ID="Login1" runat="server" BorderPadding="4" Font-Names="Arial" Font-Size="0.8em" ForeColor="#333333" RememberMeSet="true" DisplayRememberMe="true">
                                <TextBoxStyle Font-Size="0.8em" />
                                <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px"
                                    Font-Names="Arial" Font-Size="0.8em" ForeColor="#284775" />
                                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                                <TitleTextStyle Font-Bold="True" Font-Size="0.9em" ForeColor="#004A66" HorizontalAlign="Left" />
                                <LayoutTemplate>
                                    <table border="0" cellpadding="4" cellspacing="0" style="border-collapse: collapse">
                                        <tr>
                                            <td>
                                                <table border="0" cellpadding="0">
                                                    <%--<tr>
                                                        <td align="left" colspan="2" style="font-weight: bold; font-size: 0.9em; color: #004a66">
                                                            Đăng nhập</td>
                                                    </tr>--%>
                                                    <tr>
                                                        <td align="left">
                                                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Tài khoản:</asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="UserName" runat="server" Width="120px" style="border:solid 1px #bbb; height:20px;"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                                ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Mật khẩu:</asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="120px" style="border:solid 1px #bbb; height:20px;"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                                ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" align="left">
                                                            <asp:CheckBox ID="RememberMe" runat="server" Text="Ghi nhớ mật khẩu." />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" colspan="2" style="color: red">
                                                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" colspan="2" style="padding-right:10px; padding-top:5px">
                                                            <asp:Button ID="LoginButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC"
                                                                BorderStyle="Solid" BorderWidth="1px" CommandName="Login" Font-Names="Arial"
                                                                ForeColor="#284775" Text="Đăng nhập" ValidationGroup="Login1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                            </asp:Login>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right" style="font-size:10px;">Developed by <a href="mailto:hung.nguyen1610@gmail.com">Hung Nguyen</a></td>
                    </tr>
                </table>                
            </div>
        </center>
        <script type="text/javascript">
            <asp:Literal ID="liscript" runat="server"></asp:Literal>
        </script>
    </form>
    
    
</body>
</html>
                                                        