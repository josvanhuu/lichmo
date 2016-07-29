<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Admin_Calendar_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Lịch mổ</h1>
<div class="form">
<asp:Panel ID="pnList" runat="server">
    <select id="room" name="room" onchange="fillcategory2();">
        <option value="0">-- Chọn buồng mổ --</option>
        <asp:Repeater ID="rpRoom3" runat="server">
            <ItemTemplate>
                <option value="<%# Eval("ID") %>"><%# Eval("Name") %></option>
            </ItemTemplate>
        </asp:Repeater>
    </select>
    <select id="table" name="table">
        <option value="0">-- Chọn bàn --</option>
    </select> 
    <asp:DropDownList ID="ddlScience2" runat="server" DataTextField="Name" DataValueField="ID" AppendDataBoundItems="true"></asp:DropDownList>
    <asp:TextBox ID="txtDay2" runat="server" Width="300px" placeholder="-- Chọn ngày --"></asp:TextBox>   
    <asp:Button ID="btnApply" runat="server" CssClass="button" Text="Tìm kiếm" OnClick="btnApply_Click" Width="100px" />
    <asp:Button ID="btnRemove" runat="server" CssClass="button" Text="Hủy bỏ" OnClick="btnRemove_Click" Width="100px" /><br /><br />
    <asp:GridView ID="gvSchedule" runat="server" CellPadding="4" CssClass="table table-bordered" ForeColor="#333333" GridLines="None" AutoGenerateColumns="false" Width="100%" 
    OnRowCommand="gvSchedule_RowCommand" DataKeyNames="ID" AllowPaging="true" PageSize="20" OnPageIndexChanging="gvSchedule_PageIndexChanging">
        <EmptyDataTemplate>Chưa có dữ liệu</EmptyDataTemplate>
        <Columns>
            <asp:TemplateField  ItemStyle-Width="30px">                            
                <HeaderTemplate>
                    <input type="checkbox" onchange="if(this.checked==true){CheckAll('chkId');}else{UnCheckAll('chkId');}" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkId" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText='Sửa'  ItemStyle-Width="30px">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="EditItem"><img src="<%=ResolveUrl("~/image/1400500374_document_edit.png") %>" width="24" /></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText='STT'  HeaderStyle-HorizontalAlign="center">
                <ItemTemplate>
                <asp:TextBox ID="txtOrderNumber" runat="server" Text='<%# Eval("OrderNumber") %>' Width="15px"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Name" HeaderText='Tên bệnh nhân' HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="Detail" HeaderText='Chuẩn đoán phẫu thuật' ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"/>
            <asp:TemplateField HeaderText='Phòng Mổ' ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                <%# GetRoomName(Eval("RoomId"))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText='Bàn' ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                <%# Eval("NumberOfTable")!=null && Eval("NumberOfTable").ToString() !="0" ? "Bàn số "+ Eval("NumberOfTable"):"------"%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText='Khoa' ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                <%# GetScienceName(Eval("ScienceId"))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="PTVName" HeaderText='Phẫu thuật viên' HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="BSGMName" HeaderText='Bác sỹ gây mê' HeaderStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="DDName" HeaderText='Điều dưỡng viên' HeaderStyle-HorizontalAlign="Left" />
            <asp:TemplateField HeaderText='Status' ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <img src="<%# GetStatus(Eval("Id"))%>" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <FooterStyle BackColor="#428BCA" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#428BCA" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#428BCA" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
<div class="nav">
    <%if (HttpContext.Current.User.IsInRole("Manager") || HttpContext.Current.User.IsInRole("Administrator"))
        { %>
    <asp:Button ID="btnAddNew" runat="server" CssClass="button" Text="Thêm mới" OnClick="btnAddNew_Click" Width="100px" />
    <% } %>
    <asp:Button ID="btnUpdate" runat="server" CssClass="button" Text="Cập nhật thứ tự" OnClick="btnUpdate_Click" Width="120px" />
    <asp:Button ID="btnDelete" runat="server" CssClass="button cancel" Text="Xóa" OnClick="btnDelete_Click" Width="100px" />
</div>
<script type="text/javascript">
    Room = new Object();
    Table = new Object();        
    <asp:Repeater ID="rpRoom4" runat="server">
        <ItemTemplate>
            Room["<%# Eval("ID") %>"]= new Array(
            <asp:Repeater ID="rpTabel3" runat="server" DataSource='<%# GetTableList(Eval("TabelQuantity")) %>'>
                <ItemTemplate>
                    "<%# "Bàn số "+Container.DataItem %>"
                </ItemTemplate>
                <SeparatorTemplate>,</SeparatorTemplate>
            </asp:Repeater>);
            Table["<%# Eval("ID") %>"]=new Array(
            <asp:Repeater ID="rpTabel4" runat="server" DataSource='<%# GetTableList(Eval("TabelQuantity")) %>'>
                <ItemTemplate>
                    "<%# Container.DataItem %>"
                </ItemTemplate>
                <SeparatorTemplate>,</SeparatorTemplate>
            </asp:Repeater>);
        </ItemTemplate>
    </asp:Repeater>
    
    function fillcategory2()
    {
        document.getElementById("table").length = 0;
        document.getElementById("table").options[0] = new Option("-- Chọn bàn --","0");
        reg = new String($("#room").val());
        if(reg!="")
        {
            for(count = 1; count <= Table[reg].length; count ++) {
                document.getElementById("table").options[count] = new Option(Room[reg][count-1],Table[reg][count-1]);
		    }
		}
    }
    $(document).ready(function(){
        $("#<%=txtDay2.ClientID %>").datepicker({ dateFormat: 'dd/mm/yy' });
    });
    <asp:Literal ID="liScript2" runat="server" />
</script>
</asp:Panel>
<asp:Panel ID="pnEdit" runat="server" Visible="false">
    
    <%if (HttpContext.Current.User.IsInRole("Manager") || HttpContext.Current.User.IsInRole("Administrator"))
        { %>
    <asp:Panel ID="pnKhoa" runat="server" Width="100%" CssClass="khoa-form">
        <h3><span class="label label-primary">Thông tin Ca Mổ</span></h3>
        <table class="table table-hover">
            <tr class="form-group">
                <td class="col-sm-2"><label>Khoa</label></td>
                <td class="col-sm-4">
                    <asp:DropDownList ID="ddlScience" CssClass="form-control" runat="server" DataTextField="Name" DataValueField="ID" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlScience_Selected">
                    </asp:DropDownList>
                </td>
                <td class="col-sm-2"><label>Tên bệnh nhân:</label></td>
                <td class="col-sm-4"><asp:TextBox ID="txtName" CssClass="form-control" runat="server" Width="100%"></asp:TextBox></td>
                
            </tr>
            <tr>
                <td class="col-sm-2"><label>Ngày sinh:</label></td>
                <td class="col-sm-4"><asp:TextBox ID="txtDay" CssClass="form-control" runat="server" Width="100%"></asp:TextBox></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td class="col-sm-2">Phẫu thuật viên:</td>
                <td class="col-sm-4">
                    <div style="height:150px; overflow:auto; width:100%" class="listbox">
                    <asp:CheckBoxList ID="cblPTV" runat="server" DataTextField="Comment" DataValueField="Comment" RepeatColumns="5"></asp:CheckBoxList>
                    </div>
                </td>
                <td class="col-sm-2">Chuẩn đoán phẫu thuật:</td>
                <td class="col-sm-4">
                    <asp:TextBox ID="txtDetail" CssClass="form-control" runat="server" Width="100%" TextMode="MultiLine" Height="150px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="col-sm-2">Phương pháp phẫu thuật:</td>
                <td class="col-sm-4">
                    <select id="cboPPPT" class="form-control" name="pppt" <%--onchange="fillcategory();"--%>>
                        <option value="0">-- Chọn phương pháp phẫu thuật --</option>
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <option value="1">PPPT 1</option>
                                <option value="2">PPPT 2</option>
                                <option value="3">PPPT 3</option>
                                <option value="4">PPPT 4</option>
                               <%-- <option value="<%# Eval("ID") %>"><%# Eval("Name") %></option>--%>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>                    
                </td>
                <td class="col-sm-2">Phương pháp vô cảm:</td>
                <td class="col-sm-4">
                    <select id="cboPPVC" class="form-control" name="ppvc" <%--onchange="fillcategory();"--%>>
                        <option value="0">-- Chọn phương pháp vô cảm --</option>
                        <asp:Repeater ID="Repeater2" runat="server">
                            <ItemTemplate>
                                <option value="1">PPVC 1</option>
                                <option value="2">PPVC 2</option>
                                <option value="3">PPVC 3</option>
                                <option value="4">PPVC 4</option>
                               <%-- <option value="<%# Eval("ID") %>"><%# Eval("Name") %></option>--%>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <% } %>
    <%if (HttpContext.Current.User.IsInRole("OperatingRoom") || HttpContext.Current.User.IsInRole("Administrator"))
        { %>
    <asp:Panel ID="pnPhongMo" runat="server" Width="100%" CssClass="phongmo-form">
        <h3><span class="label label-primary">Sắp xếp Phòng Mổ</span></h3>
        <table class="table table-hover">
            <tr>
                <td class="col-sm-2"><label>Thứ tự:</label></td>
                <td class="col-sm-4"><asp:TextBox ID="txtOrderNumber" CssClass="form-control" runat="server" Text="1"></asp:TextBox></td>
                <td class="col-sm-2"><label>Ngày mổ:</label></td>
                <td class="col-sm-4"><asp:TextBox ID="txtNgaymo" CssClass="form-control" runat="server" Width="100%"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="col-sm-2">Buồng mổ:</td>
                <td class="col-sm-4">
                    <select id="type" class="form-control" name="type" onchange="fillcategory();">
                        <option value="0">-- Chọn buồng mổ --</option>
                        <asp:Repeater ID="rpRoom1" runat="server">
                            <ItemTemplate>
                                <option value="<%# Eval("ID") %>"><%# Eval("Name") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                </td>
                <td class="col-sm-2">Số bàn</td>
                <td class="col-sm-4">
                    <select id="category" class="form-control" name="category">
                        <option value="0">-- Chọn bàn --</option>
                    </select>  
                </td>
            </tr>
            <tr>
                <td class="col-sm-2">Bác sỹ gây mê:</td>
                <td class="col-sm-4">
                    <div style="height:auto; overflow:auto; width:100%" class="listbox">
                    <asp:CheckBoxList ID="cblBSGM" runat="server" DataTextField="Comment" DataValueField="Comment" RepeatColumns="2"></asp:CheckBoxList>
                    </div>
                </td>
                <td class="col-sm-2">Kỹ thuật viên:</td>
                <td class="col-sm-4">
                    <div style="height:150px; overflow:auto; width:100%" class="listbox">
                    <asp:CheckBoxList ID="cblDD" runat="server" DataTextField="Comment" DataValueField="Comment" RepeatColumns="5"></asp:CheckBoxList>
                    </div>
                </td>
                <td></td>
            </tr>
        </table>
    </asp:Panel>
    <% } %>

    <div class="nav button-form">
        <asp:HiddenField ID="hfID" runat="server" />
        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-info" Text="Lưu" OnClick="btnSave_Click"/>
        <asp:Button ID="btnSave2" runat="server" CssClass="btn btn-info" Text="Lưu & Thêm nữa" OnClick="btnSave2_Click"/>
        <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-danger" Text="Hủy bỏ" OnClick="btnCancel_Click"/>
    </div>
    
    <script type="text/javascript">
        Types = new Object();
        Links = new Object();        
        <asp:Repeater ID="rpRoom2" runat="server">
            <ItemTemplate>
                Types["<%# Eval("ID") %>"]= new Array(
                <asp:Repeater ID="rpTabel" runat="server" DataSource='<%# GetTableList(Eval("TabelQuantity")) %>'>
                    <ItemTemplate>
                        "<%# "Bàn số "+Container.DataItem %>"
                    </ItemTemplate>
                    <SeparatorTemplate>,</SeparatorTemplate>
                </asp:Repeater>);
                Links["<%# Eval("ID") %>"]=new Array(
                <asp:Repeater ID="rpTabel2" runat="server" DataSource='<%# GetTableList(Eval("TabelQuantity")) %>'>
                    <ItemTemplate>
                        "<%# Container.DataItem %>"
                    </ItemTemplate>
                    <SeparatorTemplate>,</SeparatorTemplate>
                </asp:Repeater>);
            </ItemTemplate>
        </asp:Repeater>
        
            function fillcategory()
            {
                document.getElementById("category").length = 0;
                document.getElementById("category").options[0] = new Option("-- Chọn bàn --","0");
                reg = new String($("#type").val());
                if(reg!="")
                {
                    for(count = 1; count <= Links[reg].length; count ++) {
                        document.getElementById("category").options[count] = new Option(Types[reg][count-1],Links[reg][count-1]);
				    }
				}
            }
            
        
            $(document).ready(function(){
                $("#<%=txtDay.ClientID %>").datepicker({ dateFormat: 'dd/mm/yy' });
                $("#<%=txtNgaymo.ClientID %>").datepicker({ dateFormat: 'dd/mm/yy' });
            });
            <asp:Literal ID="liScript" runat="server" />
        </script>
</asp:Panel>
</div>
</asp:Content>

