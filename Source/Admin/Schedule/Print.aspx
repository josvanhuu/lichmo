<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Print.aspx.cs" Inherits="Admin_Schedule_Print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
    body{font-size:14px; }
    table th { font-size:14px; }
    .bottom { position:fixed; bottom:50px; left:50%; }
    @media print {
    .noprint {
        display: none;
    }
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width="1246" cellpadding="4" cellspacing="0" border="0">
        <tr>
            <td align="center">
                Bệnh viện Đa khoa tỉnh Hải Dương<br />
                Khoa Phẫu thuật gây mê - hồi sức
            </td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td align="center" style="font-size:30px; font-weight:bold;">
                LỊCH MỔ PHIÊN
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>            
            <td></td>
            <td align="center">
                Thứ ... ngày ... tháng ... năm ...
            </td>
        </tr>
    </table><br />
     <table width="1246" cellpadding="8" cellspacing="0" border="0" style="border:solid 1px #000;">
        <tr>
            <th width="125" style="height:50px;border-bottom:solid 1px #000;border-right:solid 1px #000;" colspan="2">Buồng mổ</th>
            <th width="170" align="left" style="border-bottom:solid 1px #000;border-right:solid 1px #000;">Thức tự mổ</th>
            <th width="267" align="left" style="border-bottom:solid 1px #000;border-right:solid 1px #000;">Chuẩn đoán phẫu thuật</th>
            <th width="126" align="left" style="border-bottom:solid 1px #000;border-right:solid 1px #000;">Khoa</th>
            <th width="188" align="left" style="border-bottom:solid 1px #000;border-right:solid 1px #000;">Phẫu thuật viên</th>
            <th width="188" align="left" style="border-bottom:solid 1px #000;border-right:solid 1px #000;">Bác sỹ gây mê</th>
            <th width="188" align="left" style="border-bottom:solid 1px #000;">Điều dưỡng viên</th>
        </tr>   
    
    <asp:Repeater ID="rpRoom" runat="server">
    <ItemTemplate>
        <tr>
            <td width="47" rowspan="<%#GetTotalByRoom(Eval("ID")) %>" style="padding:8px; border-top:solid 1px #000;border-right:solid 1px #000;<%#GetTotalByRoom(Eval("ID"))==0?"display:none":"" %>"><%# Eval("Name") %></td>                    
            <asp:Repeater ID="rpTable" runat="server" DataSource='<%# GetTable(Container.DataItem) %>'>
                <ItemTemplate>                    
                        <td width="47" rowspan="<%#GetTotalByTable(Container.DataItem) %>" style="padding:8px;border-top:solid 1px #000;border-right:solid 1px #000;<%#GetTotalByTable(Container.DataItem)==0?"display:none":"" %>"><%# "Bàn "+Eval("NumberOfTable") %></td>
                        <asp:Repeater ID="rpCalendar" runat="server" DataSource='<%# GetSchedule(Container.DataItem) %>'>
                            <ItemTemplate>
                                <%#Container.ItemIndex!=0?"<tr>":"" %>
                                    <td style="border-right:solid 1px #000;<%#Container.ItemIndex==0?"border-top:solid 1px #000;":"border-top:dotted 1px #000;"%>"><%# Eval("OrderNumber")+". "+Eval("Name") %></td>
                                    <td style="border-right:solid 1px #000;<%#Container.ItemIndex==0?"border-top:solid 1px #000;":"border-top:dotted 1px #000;"%>"><%# Eval("Detail") %></td>
                                    <td style="border-right:solid 1px #000;<%#Container.ItemIndex==0?"border-top:solid 1px #000;":"border-top:dotted 1px #000;"%>"><%# GetScienceName(Eval("ScienceId"))%></td>
                                    <td style="border-right:solid 1px #000;<%#Container.ItemIndex==0?"border-top:solid 1px #000;":"border-top:dotted 1px #000;"%>"><%# Eval("PTVName") %></td>
                                    <td style="border-right:solid 1px #000;<%#Container.ItemIndex==0?"border-top:solid 1px #000;":"border-top:dotted 1px #000;"%>"><%# Eval("BSGMName") %></td>
                                    <td style="<%#Container.ItemIndex==0?"border-top:solid 1px #000;":"border-top:dotted 1px #000;"%>"><%# Eval("DDName") %></td>
                                <%#Container.ItemIndex!=0?"</tr>":"" %>
                                <%#Container.ItemIndex==0?"</tr>":"" %>
                            </ItemTemplate>
                        </asp:Repeater>
                    
                </ItemTemplate>
            </asp:Repeater>
    </ItemTemplate>
</asp:Repeater>
    </table>
    </div>
    <p style="float:right; width:300px; text-align:center; margin-top:20px;">
        Người lập lịch<br /><br />
        ............................................
    </p>
    <div class="bottom noprint">
    <input type="button" value="In ra giấy" style="width:100px" onclick="window.print();" />
    </div>
    </form>    
</body>
</html>
