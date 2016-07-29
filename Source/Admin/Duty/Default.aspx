<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Duty_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1><%=Request["type"].ToString()=="ltm"?"Lịch Trực":"Lịch Cấp Cứu Tuyến" %></h1>
<div class="form">
<asp:Panel ID="pnList" runat="server">
    Chọn tháng:
    <asp:DropDownList ID="ddlMonth" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMonth_Click">
        
    </asp:DropDownList><br /><br />
    <asp:GridView ID="gvDuty" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="false" Width="100%" OnRowCommand="gvSchedule_RowCommand" DataKeyNames="ID">
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
            </asp:TemplateField>            --%>
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
        <div class="bsname hide">
            <asp:DropDownList ID="rblStaff" runat="server" DataTextField="Comment" DataValueField="Comment" CssClass="classname" multiple="multiple"></asp:DropDownList>            
        </div>
    <div class="ktvname hide">
            <asp:DropDownList ID="ddlKTV" runat="server" DataTextField="Comment" DataValueField="Comment" CssClass="classname" multiple="multiple"></asp:DropDownList>            
        </div>
        <table width="100%" cellpadding="5" cellspacing="0" border="0">        
        <tr>
            <td>Từ Ngày:  </td>
            <td><asp:TextBox ID="txtFromDate" runat="server" Width="300px" onchange="getlistday();"></asp:TextBox></td>
            <td>Đến Ngày:  </td>
            <td><asp:TextBox ID="txtToDate" runat="server" Width="300px" onchange="getlistday();"></asp:TextBox></td>
        </tr>
        <tr>
            <td colspan="4">
                <table width="100%" cellpadding="5" cellspacing="0" border="0" class="listday">
                    
                </table>
            </td>
        </tr>
        </table>
        <div class="nav">
            <asp:HiddenField ID="hfID" runat="server" />
            <asp:Button ID="btnSave" runat="server" CssClass="button" Text="Lưu" OnClick="btnSave_Click" Width="100px" />
            <asp:Button ID="btnCancel" runat="server" CssClass="button cancel" Text="Hủy bỏ" OnClick="btnCancel_Click" Width="100px" />
        </div> 
        <script type="text/javascript">
            $(document).ready(function() {
                $("#<%=txtToDate.ClientID %>").datepicker({ dateFormat: 'dd/mm/yy' });
                $("#<%=txtFromDate.ClientID %>").datepicker({ dateFormat: 'dd/mm/yy' });                
                <asp:Literal ID="liscript" runat="server"></asp:Literal>
            });
            Date.prototype.addDays = function (days) {
                var dat = new Date(this.valueOf())
                dat.setDate(dat.getDate() + days);
                return dat;
            }

            function getDates(startDate, stopDate) {
                var dateArray = new Array();
                var currentDate = startDate;
                while (currentDate <= stopDate) {
                    dateArray.push(currentDate)
                    currentDate = currentDate.addDays(1);
                }
                return dateArray;
            }
            function getlistday() {                
                if ($("#<%=txtFromDate.ClientID %>").val() != "" && $("#<%=txtToDate.ClientID %>").val() != "") {
                    var fromdate = $("#<%=txtFromDate.ClientID %>").datepicker('getDate');
                    var todate = $("#<%=txtToDate.ClientID %>").datepicker('getDate');;
                    if (fromdate.getTime() <= todate.getTime()) {
                        var dateArray = getDates(fromdate, todate);
                        var listday = '<tr><th width="10%">Thứ</th><th width="10%">Ngày</th><th width="40%">Bác sĩ trực</th><th width="40%">Kỹ thuật viên trực</th></tr>';
                        var cd;
                        for (i = 0; i < dateArray.length; i++) {
                            cd = new Date(dateArray[i]);
                            listday += "<tr><td>" + getdayweek(cd.getDay()) + "</td><td>" + convertDate(cd)
                                +"<input type='hidden' name='hfdate"+i+"' id='hfdate"+i+"' value='" + convertDate(cd) + "'/></td>"
                                + "<td>" + $(".bsname").html().replace("classname","ddcheck").replace("rblStaff","bsname"+i) + "</td>"
                                + "<td>" + $(".ktvname").html().replace("classname","ddcheck").replace("ddlKTV", "ktvname" + i) + "</td></tr>";
                        }
                        $(".listday").html(listday);
                        $(".ddcheck").multiselect({
                            maxHeight:300,
                            onChange: function (element, checked) {
                                var selected=[];
                                $(element).parent().find("option:selected").each(function(){
                                    selected.push([$(this).val()]);
                                });
                                $(element).parent().next().val(selected);
                            }
                        });
                    }
                }
            }
            function getdayweek(day) {
                switch (day) {
                    case 0:
                        return "Chủ nhật";
                    case 1:
                        return "Thứ 2";
                    case 2:
                        return "Thứ 3";
                    case 3:
                        return "Thứ 4";
                    case 4:
                        return "Thứ 5";
                    case 5:
                        return "Thứ 6";
                    case 6:
                        return "Thứ 7";
                }
            }
            function convertDate(d) {
                function pad(s) { return (s < 10) ? '0' + s : s; }
                //var d = new Date(inputFormat);
                return [pad(d.getDate()), pad(d.getMonth()+1), d.getFullYear()].join('/');
            }
        </script> 
    
    </asp:Panel>
</div>
</asp:Content>

