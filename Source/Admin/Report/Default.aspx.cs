using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MHWeb.Entities;
using MHWeb.Services;

public partial class Admin_Report_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) BindDDL();
    }
    protected void btnApply1_Click(object s, EventArgs e)
    {
        Apply();
    }    
    protected void BindDDL()
    {
        ddlScience.Items.Clear();
        ddlScience.DataSource = (new ScienceService()).GetAll();
        ddlScience.DataBind();
        ddlScience.Items.Insert(0, new ListItem("-- Chọn khoa --", "0"));

        ddlRoom.Items.Clear();
        ddlRoom.DataSource = (new RoomService()).GetAll();
        ddlRoom.DataBind();
        ddlRoom.Items.Insert(0, new ListItem("-- Chọn phòng --", "0"));
    }
    protected void Apply()
    {
        string sql = "1=1";
        if (chkDate.Checked)
        {
            if (txtFromDate.Text != string.Empty)
                sql += " and Day>='" + DateTime.ParseExact(txtFromDate.Text,"dd/MM/yyyy",CultureInfo.InvariantCulture).ToString("yyyy-MM-dd") + "'";
            if (txtToDate.Text != string.Empty)
                sql += " and Day<='" + DateTime.ParseExact(txtToDate.Text,"dd/MM/yyyy",CultureInfo.InvariantCulture).ToString("yyyy-MM-dd") + "'";
        }
        if (chkRoom.Checked)
        {
            sql += " and RoomId=" + ddlRoom.SelectedValue;
        }
        if (chkScience.Checked)
        {
            sql += " and ScienceId=" + ddlScience.SelectedValue;
        }
        //Response.Write(sql);
        int total;
        ScheduleService _ScheduleService = new ScheduleService();
        _ScheduleService.GetTotalItems(sql, out total);
        liTotal.Text = total.ToString();
    }
}
