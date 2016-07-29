using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MHWeb.Services;
using MHWeb.Entities;
using System.Globalization;

public partial class Admin_Duty_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) BindData();
    }
    protected void BindData()
    {
        int total;
        string sql = "FromDate<='" + DateTime.Now.ToString("yyyy-MM-dd") + "' and FromDate>='" + DateTime.Now.ToString("yyyy-MM-dd") + "'";
        if (txtFromdate.Text != string.Empty)
        {
            sql = "FromDate>='" + DateTime.ParseExact(txtFromdate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("yyyy-MM-dd") + "'";
        }
        if (txtTodate.Text != string.Empty)
        {
            if (txtFromdate.Text != string.Empty) sql += " and ";
            sql += "FromDate<='" + DateTime.ParseExact(txtTodate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("yyyy-MM-dd") + "'";
        }
        sql += " and TypeCode='" + Request["type"] + "'";
        //Response.Write(sql);
        gvDuty.DataSource = (new DutyService()).GetPaged(sql, "FromDate", 0, 0, out total);
        gvDuty.DataBind();
    }
    protected string GetScienceName(object id)
    {
        Science _Science = (new ScienceService()).GetById(Convert.ToInt32(id));
        if (_Science != null)
            return _Science.Name;
        else return string.Empty;
    }
    protected void btnApply_Click(object s, EventArgs e)
    {
        BindData();
    }
    protected void btnRemove_Click(object s, EventArgs e)
    {
        txtFromdate.Text =txtTodate.Text = string.Empty;
        BindData();
    }
    protected string GetDayWeek(object dayweek)
    {
        switch (dayweek.ToString())
        {
            default:
            case "1":
                return "Thứ 2";
            case "2":
                return "Thứ 3";
            case "3":
                return "Thứ 4";
            case "4":
                return "Thứ 5";
            case "5":
                return "Thứ 6";
            case "6":
                return "Thứ 7";
            case "0":
                return "Chủ nhật";
        }
    }
}
