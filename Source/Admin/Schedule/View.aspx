<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="View.aspx.cs" Inherits="Admin_Schedule_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Xem Lịch Mổ</h1>
<div class="form">
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
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr>
        <th width="10%" colspan="2" style="background:#428BCA;color:#fff;">Buồng mổ</th>
        <th width="15%" align="left" style="background:#428BCA;color:#fff;">Thứ tự mổ</th>
        <th width="20%" align="left" style="background:#428BCA;color:#fff;">Chuẩn đoán phẫu thuật</th>
        <th width="10%" align="left" style="background:#428BCA;color:#fff;">Khoa</th>
        <th width="15%" align="left" style="background:#428BCA;color:#fff;">Phẫu thuật viên</th>
        <th width="15%" align="left" style="background:#428BCA;color:#fff;">Bác sỹ gây mê</th>
        <th width="15%" align="left" style="background:#428BCA;color:#fff;">Điều dưỡng viên</th>
    </tr> 
    <asp:Repeater ID="rpRoom" runat="server">
    <ItemTemplate>
        <tr style="<%#Container.ItemIndex==0?"":"border-top:solid 1px #e3e3e3;"%>">
            <td width="47" rowspan="<%#GetTotalByRoom(Eval("ID")) %>" class="<%#Container.ItemIndex%2==0?"chan":"le" %>" style="<%#GetTotalByRoom(Eval("ID"))==0?"display:none":"" %>"><%# Eval("Name") %></td>                    
            <asp:Repeater ID="rpTable" runat="server" DataSource='<%# GetTable(Container.DataItem) %>'>
                <ItemTemplate>                    
                        <td width="47" rowspan="<%#GetTotalByTable(Container.DataItem) %>" class="<%#Container.ItemIndex%2==0?"chan":"le" %>" style="<%#GetTotalByTable(Container.DataItem)==0?"display:none":"" %>"><%# "Bàn "+Eval("NumberOfTable") %></td>
                        <asp:Repeater ID="rpCalendar" runat="server" DataSource='<%# GetSchedule(Container.DataItem) %>'>
                            <ItemTemplate>
                                <%#Container.ItemIndex!=0?"<tr>":"" %>
                                    <td class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# Eval("OrderNumber")+". "+Eval("Name") %></td>
                                    <td class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# Eval("Detail") %></td>
                                    <td class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# GetScienceName(Eval("ScienceId"))%></td>
                                    <td class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# Eval("PTVName") %></td>
                                    <td class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# Eval("BSGMName") %></td>
                                    <td class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# Eval("DDName") %></td>
                                <%#Container.ItemIndex!=0?"</tr>":"" %>
                                <%#Container.ItemIndex==0?"</tr>":"" %>
                            </ItemTemplate>
                        </asp:Repeater>
                    
                </ItemTemplate>
            </asp:Repeater>
    </ItemTemplate>
</asp:Repeater>
</table>
<%--<div class="table-header">
<table width="100%" cellpadding="4" cellspacing="0" border="0">
    <tr>
        <th width="10%">Buồng mổ</th>
        <th width="10%" align="left">Thức tự mổ</th>
        <th width="25%" align="left">Chuẩn đoán phẫu thuật</th>
        <th width="10%" align="left">Khoa</th>
        <th width="15%" align="left">Phẫu thuật viên</th>
        <th width="15%" align="left">Bác sỹ gây mê</th>
        <th width="15%" align="left">Điều dưỡng viên</th>
    </tr>   
</table>
</div>
<div class="table-content">
<asp:Repeater ID="rpRoom" runat="server">
    <HeaderTemplate>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">    
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td width="5%" style="padding:8px; border-bottom:solid 1px #e3e3e3;" class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# Eval("Name") %></td>        
            <td style="border-bottom:solid 1px #e3e3e3;">
            <asp:Repeater ID="rpTable" runat="server" DataSource='<%# GetTable(Container.DataItem) %>'>
                <ItemTemplate>
                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td width="5%" style="padding:8px;" class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# "Bàn "+Eval("NumberOfTable") %></td>
                        <td>
                            <asp:Repeater ID="rpCalendar" runat="server" DataSource='<%# GetSchedule(Container.DataItem) %>'>
                                <ItemTemplate>
                                    <table width="100%" cellpadding="8" cellspacing="0" border="0">
                                    <tr>
                                        <td width="10%" class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# Eval("OrderNumber")+". "+Eval("Name") %></td>
                                        <td width="25%" class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# Eval("Detail") %></td>
                                        <td width="10%" class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# GetScienceName(Eval("ScienceId"))%></td>
                                        <td width="15%" class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# Eval("PTVName") %></td>
                                        <td width="15%" class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# Eval("BSGMName") %></td>
                                        <td width="15%" class="<%#Container.ItemIndex%2==0?"chan":"le" %>"><%# Eval("DDName") %></td>
                                    </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
            </td>
        
    </ItemTemplate>
    <FooterTemplate>
    </table>
    </FooterTemplate>
</asp:Repeater>
</div>--%>
<div class="nav">
    <input type="button" onclick="print();" class="button" style="width:100px;" value="Xem bản in" />
</div>
</div>
<script type="text/javascript">
<!--
    function popup(url) {
        params = 'width=' + screen.width;
        params += ', height=' + screen.height;
        params += ', top=0, left=0'
        params += ', fullscreen=yes';

        newwin = window.open(url, 'windowname4', params);
        if (window.focus) { newwin.focus() }
        return false;
    }
    function print() {
        popup('print.aspx?room=' + $("#room").val() + "&table=" + $("#table").val() + "&science=" + $("#<%=ddlScience2.ClientID %>").val() + "&date=" + $("#<%=txtDay2.ClientID %>").val());
    }
// -->
</script>



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
</asp:Content>

