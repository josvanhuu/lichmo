<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default_remove.aspx.cs" Inherits="Admin_Calendar_Default" %>

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
    <asp:GridView ID="gvSchedule" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="false" Width="100%" 
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
                <%# "Bàn số "+ Eval("NumberOfTable")%>
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
    <asp:Button ID="btnAddNew" runat="server" CssClass="button" Text="Thêm mới" OnClick="btnAddNew_Click" Width="100px" />
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
    <table width="100%" cellpadding="5" cellspacing="0" border="0">
        <tr>
            <td>Ngày:</td>
            <td><asp:TextBox ID="txtDay" runat="server" Width="300px"></asp:TextBox></td>
            <td>Khoa:</td>
            <td><asp:DropDownList ID="ddlScience" runat="server" DataTextField="Name" DataValueField="ID" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlScience_Selected">
                
            </asp:DropDownList></td>
            
            
        </tr>
        <tr>
            <td>Tên bệnh nhân:</td>
            <td><asp:TextBox ID="txtName" runat="server" Width="300px"></asp:TextBox></td>
            <td>Buồng mổ:</td>
            <td>
                <select id="type" name="type" onchange="fillcategory();">
                    <option value="0">-- Chọn buồng mổ --</option>
                    <asp:Repeater ID="rpRoom1" runat="server">
                        <ItemTemplate>
                            <option value="<%# Eval("ID") %>"><%# Eval("Name") %></option>
                        </ItemTemplate>
                    </asp:Repeater>
                </select>
            </td>
        </tr>
     
            <%if (HttpContext.Current.User.IsInRole("OperatingRoom") || HttpContext.Current.User.IsInRole("Administrator"))
                { %>
           <tr>
              <td>Số bàn</td>
            <td>
                <select id="category" name="category">
                    <option value="0">-- Chọn bàn --</option>
                </select>  
            </td>
            
            <td>Thứ tự:</td>
            <td><asp:TextBox ID="txtOrderNumber" runat="server" Width="300px" Text="1"></asp:TextBox></td>
                 </tr>
            <%}
            else if (HttpContext.Current.User.IsInRole("Manager") ||  HttpContext.Current.User.IsInRole("Administrator"))
            {%>
        <tr>
            <td>Phẫu thuật viên:</td>
            <td>
                <div style="height:150px; overflow:auto; width:300px" class="listbox">
                <asp:CheckBoxList ID="cblPTV" runat="server" DataTextField="Comment" DataValueField="Comment" RepeatColumns="2"></asp:CheckBoxList>
                </div>
            </td>
            <td>Bác sỹ gây mê:</td>
            <td>
                <div style="height:150px; overflow:auto; width:300px" class="listbox">
                <asp:CheckBoxList ID="cblBSGM" runat="server" DataTextField="Comment" DataValueField="Comment" RepeatColumns="2"></asp:CheckBoxList>
                </div>
            </td>
        </tr>
        <tr>
            <td>Kỹ thuật viên:</td>
            <td>
                <div style="height:150px; overflow:auto; width:300px" class="listbox">
                <asp:CheckBoxList ID="cblDD" runat="server" DataTextField="Comment" DataValueField="Comment" RepeatColumns="2"></asp:CheckBoxList>
                </div>
            </td>
            <td>Chuẩn đoán phẫu thuật:</td>
            <td>
                <asp:TextBox ID="txtDetail" runat="server" Width="300px" TextMode="MultiLine" Height="150px"></asp:TextBox>
            </td>
        </tr>
        <%} %>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
    </table>
    <div class="nav">
        <asp:HiddenField ID="hfID" runat="server" />
        <asp:Button ID="btnSave" runat="server" CssClass="button" Text="Lưu" OnClick="btnSave_Click" Width="100px" />
        <asp:Button ID="btnSave2" runat="server" CssClass="button" Text="Lưu & Thêm nữa" OnClick="btnSave2_Click" Width="120px" />
        <asp:Button ID="btnCancel" runat="server" CssClass="button cancel" Text="Hủy bỏ" OnClick="btnCancel_Click" Width="100px" />
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
            });
            <asp:Literal ID="liScript" runat="server" />
        </script>
</asp:Panel>
</div>
</asp:Content>

