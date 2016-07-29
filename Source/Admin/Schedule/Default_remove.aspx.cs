﻿using System;
using System.Web.UI.WebControls;
using MHWeb.Services;
using MHWeb.Entities;

using System.Web.Security;
using System.Globalization;

public partial class Admin_Calendar_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        WorkContext context = null;
        if(Session["workcontext"]!=null)
        {
            context = (WorkContext)Session["workcontext"];
        }
        if (!IsPostBack)
        {
            BindDDLForSearch();
            BindData(false);
        }
        if (context != null)
        {
            if (context.CheckRole("OperatingRoom") &&
                Request.QueryString["type"] != null && Request.QueryString["type"] == "1")
                Addnew(1);
           else if (context.CheckRole("OperatingRoom") && Request.QueryString["type"] != null && Request.QueryString["type"] == "2")
                Addnew(2);
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
                sql += " and RoomId=" + Request["room"];
                liScript2.Text = "$('#room').val('" + Request["room"] + "');";
                liScript2.Text += "fillcategory2();";

            }
            if (Request["table"] != null && Request["table"].ToString() != "0")
            {
                sql += " and NumberOfTable=" + Request["table"];
                liScript2.Text += "$('#table').val('" + Request["table"] + "');";
            }
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
        }
        //Response.Write(sql);
        //Response.End();
        gvSchedule.DataSource = (new ScheduleService()).GetPaged(sql,"ScienceId,NumberOfTable,OrderNumber",0,0,out total);
        gvSchedule.DataBind();
    }
    //protected DataTable GetTable(object room)
    //{
    //    Room _Room = (Room)room; 
    //    DataTable dtb=MH.CommonFuntion.CreateTable("RoomId","RoomNumber");
    //    DataRow dtr;
    //    string[] listtabel = new string[_Room.TabelQuantity.Value];
    //    for (int i = 1; i <= _Room.TabelQuantity; i++)
    //    {
    //        dtr=dtb.NewRow();
    //        dtr["RoomId"]=_Room.Id.ToString();
    //        dtr["RoomNumber"]=i.ToString();
    //        dtb.Rows.Add(dtr);
    //    }
    //    return dtb;
    //}
    //protected TList<Schedule> GetSchedule(object row)
    //{
    //    DataRowView dtr = (DataRowView)row;
    //    ScheduleService _ScheduleService = new ScheduleService();
    //    int total;
    //    string sql="RoomId=" + dtr["RoomId"] + " and NumberOfTable=" + dtr["RoomNumber"];// + " and Day='" + DateTime.Now.ToString("yyyy-MM-dd") + "'";
        
    //    //Response.Write("RooId=" + dtr["RoomId"] + " and NumberOfTable=" + dtr["RoomNumber"] + " and Day='" + DateTime.Now.ToString("yyyy-MM-dd") + "'");
    //    //Response.End();
    //    return _ScheduleService.GetPaged(sql, "OrderNumber", 0, 0, out total);
    //}
    protected string GetScienceName(object id)
    {
        Science _Science = (new ScienceService()).GetById(Convert.ToInt32(id));
        if (_Science != null)
            return _Science.Name;
        else return string.Empty;
    }
protected string GetRoomName(object id)
    {
        Room _Room = (new RoomService()).GetById(Convert.ToInt32(id));
        if (_Room != null)
            return _Room.Name;
        else return string.Empty;
    }
    private void Addnew(int type)
    {
     switch(type)
        {
            case 0:
                pnEdit.Visible = true;
                pnList.Visible = false;
                BindDDL();
                RestForm();
                break;
            case 1:
             //   pnEdit.Visible = true;
                break;
            case 2:
                break;
        }

    }
    protected void btnAddNew_Click(object s, EventArgs e)
    {
        Addnew(0);
    }
    protected void btnSave_Click(object s, EventArgs e)
    {
        Save();
        pnEdit.Visible = false;
        pnList.Visible = true;
        BindData(false);
    }
    protected void btnSave2_Click(object s, EventArgs e)
    {
        Save();
        RestForm();
    }
    protected void Save()
    {
        Schedule _Schedule;
        ScheduleService _ScheduleService = new ScheduleService();
        if (hfID.Value != string.Empty)
        {
            _Schedule = _ScheduleService.GetById(Convert.ToInt32(hfID.Value));
        }
        else
        {
            _Schedule = new Schedule();
        }
        _Schedule.Name = txtName.Text;
        _Schedule.Detail = txtDetail.Text;
        _Schedule.OrderNumber = Convert.ToInt32(txtOrderNumber.Text);
        _Schedule.ScienceId = Convert.ToInt32(ddlScience.SelectedValue);
        _Schedule.PtvName = string.Empty;
        for (int i = 0; i < cblPTV.Items.Count; i++)
        {
            if (cblPTV.Items[i].Selected)
            {
                if (!string.IsNullOrEmpty(_Schedule.PtvName)) _Schedule.PtvName += ",";
                _Schedule.PtvName += cblPTV.Items[i].Text;
            }
        }
        _Schedule.BsgmName = string.Empty;
        for (int i = 0; i < cblBSGM.Items.Count; i++)
        {
            if (cblBSGM.Items[i].Selected)
            {
                if (!string.IsNullOrEmpty(_Schedule.BsgmName)) _Schedule.BsgmName += ",";
                _Schedule.BsgmName += cblBSGM.Items[i].Text;
            }
        }
        _Schedule.DdName = string.Empty;
        for (int i = 0; i < cblDD.Items.Count; i++)
        {
            if (cblDD.Items[i].Selected)
            {
                if (!string.IsNullOrEmpty(_Schedule.DdName)) _Schedule.DdName += ",";
                _Schedule.DdName += cblDD.Items[i].Text;
            }
        }
        _Schedule.NumberOfTable = Convert.ToInt32(Request["category"]);
        _Schedule.RoomId = Convert.ToInt32(Request["type"]);
        _Schedule.Day = DateTime.ParseExact(txtDay.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        _ScheduleService.Save(_Schedule);
        
    }
    protected void btnCancel_Click(object s, EventArgs e)
    {
        RestForm();
        pnEdit.Visible = false;
        pnList.Visible = true;
    }
    protected void btnApply_Click(object s, EventArgs e)
    {
        BindData(false);
    }
    protected void btnUpdate_Click(object s, EventArgs e)
    {
        Schedule _Schedule;
        ScheduleService _ScheduleService = new ScheduleService();
        TextBox txtOrderNumber;
        foreach (GridViewRow row in gvSchedule.Rows)
        {
            txtOrderNumber=(TextBox)row.FindControl("txtOrderNumber");
            _Schedule = _ScheduleService.GetById(Convert.ToInt32(gvSchedule.DataKeys[row.RowIndex].Value));
            _Schedule.OrderNumber = Convert.ToInt32(txtOrderNumber.Text);
            _ScheduleService.Save(_Schedule);
        }
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
    protected void BindDDL()
    {
        ddlScience.Items.Clear();
        ddlScience.DataSource = (new ScienceService()).GetAll();
        ddlScience.DataBind();
        ddlScience.Items.Insert(0, new ListItem("-- Chọn khoa --", "0"));

        rpRoom1.DataSource = rpRoom2.DataSource = (new RoomService()).GetAll();
        rpRoom1.DataBind();
        rpRoom2.DataBind();

        MembershipUserCollection muc = Membership.GetAllUsers();
        MembershipUserCollection mucBSGM, mucPTV, mucDD;
        mucBSGM = new MembershipUserCollection();
        mucPTV = new MembershipUserCollection();
        mucDD = new MembershipUserCollection();
        ProfileCommon pc;
        foreach(MembershipUser mu in muc)
        {
            pc = Profile.GetProfile(mu.UserName);
            if (pc.Department == "Bác sỹ phẫu thuật")
            {
                mucPTV.Add(mu);
            }
            else if (pc.Department == "Bác sỹ gây mê")
            {
                mucBSGM.Add(mu);
            }
            else
            {
                mucDD.Add(mu);
            }
        }
        
        cblBSGM.DataSource = mucBSGM;
        cblBSGM.DataBind();

        cblPTV.DataSource = mucPTV;
        cblPTV.DataBind();

        cblDD.DataSource = mucDD;
        cblDD.DataBind();
    }
    protected void ddlScience_Selected(object s, EventArgs e)
    {
        cblPTV.Items.Clear();
        MembershipUserCollection muc = Membership.GetAllUsers();
        MembershipUserCollection mucPTV;
        mucPTV = new MembershipUserCollection();
        ProfileCommon pc;
        foreach (MembershipUser mu in muc)
        {
            pc = Profile.GetProfile(mu.UserName);
            if (pc.Department == "Bác sỹ phẫu thuật")
            {
                if (ddlScience.SelectedValue != "0" && pc.Science == ddlScience.SelectedValue)
                {
                    mucPTV.Add(mu);
                }
                else if (ddlScience.SelectedValue == "0")
                {
                    mucPTV.Add(mu);
                }
            }            
        }

        cblPTV.DataSource = mucPTV;
        cblPTV.DataBind();
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
    protected string[] GetTableList(object number)
    {
        string[] list = new string[Convert.ToInt32(number)];
        for (int i = 0; i < Convert.ToInt32(number); i++)
        {
            list[i] = (i + 1).ToString();
        }
        return list;
    }
    protected void RestForm()
    {
        txtDay.Text = DateTime.Now.ToString("dd/MM/yyyy");
        txtName.Text = txtDetail.Text = string.Empty;
        for (int i = 0; i < cblDD.Items.Count; i++)
        {
            cblDD.Items[i].Selected = false;
        }
        for (int i = 0; i < cblBSGM.Items.Count; i++)
        {
            cblBSGM.Items[i].Selected = false;
        }
        for (int i = 0; i < cblPTV.Items.Count; i++)
        {
            cblPTV.Items[i].Selected = false;
        }
        ddlScience.SelectedIndex = 0;
    }
    protected void gvSchedule_RowCommand(object s, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditItem")
        {
            hfID.Value = e.CommandArgument.ToString();
            BindDDL();
            BindForEdit();
            pnEdit.Visible = true;
            pnList.Visible = false;
        }
    }
    protected void BindForEdit()
    {        
        ScheduleService _ScheduleService = new ScheduleService();
        Schedule _Schedule=_ScheduleService.GetById(Convert.ToInt32(hfID.Value));
        if (_Schedule != null)
        {
            txtDay.Text = _Schedule.Day.Value.ToString("dd/MM/yyyy");
            txtDetail.Text = _Schedule.Detail;
            txtName.Text = _Schedule.Name;
            txtOrderNumber.Text = _Schedule.OrderNumber.ToString();
            ddlScience.SelectedValue = _Schedule.ScienceId.Value.ToString();
            liScript.Text = "$('#type').val('" + _Schedule.RoomId + "');";
            liScript.Text += "fillcategory();";
            liScript.Text += "$('#category').val('" + _Schedule.NumberOfTable + "');";
            string[] list = _Schedule.PtvName.Split(',');
            for (int i = 0; i < cblPTV.Items.Count; i++)
            {
                for (int j = 0; j < list.Length; j++)
                {
                    if (cblPTV.Items[i].Text == list[j])
                    {
                        cblPTV.Items[i].Selected = true;
                        break;
                    }
                }
            }
            list = _Schedule.BsgmName.Split(',');
            for (int i = 0; i < cblBSGM.Items.Count; i++)
            {
                for (int j = 0; j < list.Length; j++)
                {
                    if (cblBSGM.Items[i].Text == list[j])
                    {
                        cblBSGM.Items[i].Selected = true;
                        break;
                    }
                }
            }
            list = _Schedule.DdName.Split(',');
            for (int i = 0; i < cblDD.Items.Count; i++)
            {
                for (int j = 0; j < list.Length; j++)
                {
                    if (cblDD.Items[i].Text == list[j])
                    {
                        cblDD.Items[i].Selected = true;
                        break;
                    }
                }
            }
        }
    }
    protected void btnDelete_Click(object s, EventArgs e)
    {
        CheckBox chkId;
        ScheduleService _ScheduleService = new ScheduleService();
        foreach (GridViewRow row in gvSchedule.Rows)
        {
            chkId = (CheckBox)row.FindControl("chkId");
            if (chkId.Checked)
            {
                _ScheduleService.Delete(Convert.ToInt32(gvSchedule.DataKeys[row.RowIndex].Value));
            }
        }
        BindData(false);
    }
    protected void gvSchedule_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSchedule.PageIndex = e.NewPageIndex;
        BindData(false);
    }
}