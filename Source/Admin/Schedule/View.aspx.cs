using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MHWeb.Services;
using MHWeb.Entities;
using System.Data;
using System.Web.Security;
using System.Globalization;

public partial class Admin_Schedule_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDDLForSearch();
            BindData(false);
        }
    }
    protected void BindData(bool remove)
    {
        int total;
        string sql = "1=1";
        if (!remove)
        {
            if (Request["room"] != null && Request["room"].ToString() != "0")
            {
                sql += " and Id=" + Request["room"];
                liScript2.Text = "$('#room').val('" + Request["room"] + "');";
                liScript2.Text += "fillcategory2();";

            }
        }
        rpRoom.DataSource = (new RoomService()).GetPaged(sql,"",0,0,out total);
        rpRoom.DataBind();
    }
    protected DataTable GetTable(object room)
    {
        Room _Room = (Room)room;
        DataTable dtb = MH.CommonFuntion.CreateTable("RoomId", "NumberOfTable");
        DataRow dtr;
        string[] listtabel = new string[_Room.TabelQuantity.Value];
        for (int i = 1; i <= _Room.TabelQuantity; i++)
        {
            if (Request["table"] != null && i.ToString() == Request["table"].ToString())
            {
                dtr = dtb.NewRow();
                dtr["RoomId"] = _Room.Id.ToString();
                dtr["NumberOfTable"] = i.ToString();
                dtb.Rows.Add(dtr);
                liScript2.Text += "$('#table').val('" + Request["table"] + "');";
                break;
            }
            dtr = dtb.NewRow();
            dtr["RoomId"] = _Room.Id.ToString();
            dtr["NumberOfTable"] = i.ToString();
            dtb.Rows.Add(dtr);
        }
        return dtb;
    }
    protected TList<Schedule> GetSchedule(object row)
    {
        DataRowView dtr = (DataRowView)row;
        ScheduleService _ScheduleService = new ScheduleService();
        int total;
        string sql = "RoomId=" + dtr["RoomId"] + " and NumberOfTable=" + dtr["NumberOfTable"];// + " and Day='" + DateTime.Now.ToString("yyyy-MM-dd") + "'";
        if (ddlScience2.SelectedValue != "0")
        {
            sql += " and ScienceId=" + ddlScience2.SelectedValue;
        }
        if (txtDay2.Text != string.Empty)
        {
            sql += " and Day='" + DateTime.ParseExact(txtDay2.Text,"dd/MM/yyyy",CultureInfo.InvariantCulture).ToString("yyyy-MM-dd") + "'";
        }
        else
        {
            sql += " and Day='" + DateTime.Now.ToString("yyyy-MM-dd") + "'";
        }
        ProfileCommon pc = Profile.GetProfile(User.Identity.Name);

        if (!User.IsInRole("Administrator") && pc.Science!="9")
        {
            //pc = Profile.GetProfile(User.Identity.Name);
            sql += " and ScienceId=" + pc.Science;
        }
        //Response.Write(sql);
        //Response.End();
        return _ScheduleService.GetPaged(sql, "OrderNumber", 0, 0, out total);
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
        BindData(false);
    }
    protected void btnRemove_Click(object s, EventArgs e)
    {
        liScript2.Text = "$('#room').val('0');";
        liScript2.Text += "fillcategory2();";
        txtDay2.Text = string.Empty;
        ddlScience2.SelectedIndex = 0;
        BindData(true);
    }
    protected string[] GetTableList(object number)
    {
        string[] list = new string[Convert.ToInt32(number)];
        for (int i = 0; i < Convert.ToInt32(number); i++)
        {
            list[i] = (i + 1).ToString();
        }
        return list;
    }
    protected void BindDDLForSearch()
    {
        rpRoom3.DataSource = rpRoom4.DataSource = (new RoomService()).GetAll();
        rpRoom3.DataBind();
        rpRoom4.DataBind();

        ddlScience2.Items.Clear();
        ddlScience2.DataSource = (new ScienceService()).GetAll();
        ddlScience2.DataBind();
        ddlScience2.Items.Insert(0, new ListItem("-- Chọn khoa --", "0"));
    }
    protected int GetTotalByRoom(object id)
    {
        int total;
        string sql = "RoomId=" + id;// +" and NumberOfTable=" + dtr["NumberOfTable"];
        if (ddlScience2.SelectedValue != "0")
        {
            sql += " and ScienceId=" + ddlScience2.SelectedValue;
        }
        if (txtDay2.Text != string.Empty)
        {
            sql += " and Day='" + DateTime.ParseExact(txtDay2.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("yyyy-MM-dd") + "'";
        }
        else
        {
            sql += " and Day='" + DateTime.Now.ToString("yyyy-MM-dd") + "'";
        }
        ProfileCommon pc = Profile.GetProfile(User.Identity.Name);

        if (!User.IsInRole("Administrator") && pc.Science != "9")
        {
            //pc = Profile.GetProfile(User.Identity.Name);
            sql += " and ScienceId=" + pc.Science;
        }
        ScheduleService _ScheduleService = new ScheduleService();
        _ScheduleService.GetTotalItems(sql, out total);
        return total;
    }
    protected int GetTotalByTable(object row)
    {
        int total;
        DataRowView dtr = (DataRowView)row;
        ScheduleService _ScheduleService = new ScheduleService();
        string sql = "RoomId=" + dtr["RoomId"] + " and NumberOfTable=" + dtr["NumberOfTable"];
        if (ddlScience2.SelectedValue != "0")
        {
            sql += " and ScienceId=" + ddlScience2.SelectedValue;
        }
        if (txtDay2.Text != string.Empty)
        {
            sql += " and Day='" + DateTime.ParseExact(txtDay2.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("yyyy-MM-dd") + "'";
        }
        else
        {
            sql += " and Day='" + DateTime.Now.ToString("yyyy-MM-dd") + "'";
        }
        ProfileCommon pc = Profile.GetProfile(User.Identity.Name);

        if (!User.IsInRole("Administrator") && pc.Science != "9")
        {
            //pc = Profile.GetProfile(User.Identity.Name);
            sql += " and ScienceId=" + pc.Science;
        }
        _ScheduleService.GetTotalItems(sql, out total);
        return total;
    }
}
