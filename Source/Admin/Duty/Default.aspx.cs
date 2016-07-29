using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MHWeb.Services;
using MHWeb.Entities;
using System.Web.Security;
using System.Globalization;
public partial class Admin_Duty_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindForSearch();
            BindData();
        }
    }
    protected void BindData()
    {
        int total;
        gvDuty.DataSource = (new DutyService()).GetPaged("MONTH(FromDate)=" + ddlMonth.SelectedValue+" and TypeCode='"+Request["type"]+"'", "FromDate", 0, 0, out total);
        gvDuty.DataBind();
    }
    protected void BindForSearch()
    {
        for (int i = 1; i <= 12; i++)
        {
            ddlMonth.Items.Add(new ListItem("Tháng " + i, i.ToString()));
        }
        ddlMonth.SelectedValue = DateTime.Now.Month.ToString();
    }
    protected string GetScienceName(object id)
    {
        Science _Science = (new ScienceService()).GetById(Convert.ToInt32(id));
        if (_Science != null)
            return _Science.Name;
        else return string.Empty;
    }
    //protected string GetDayWeek(object dayweek)
    //{
    //    string[] list = dayweek.ToString().Split(',');
    //    string day = string.Empty;
    //    for (int i = 0; i < list.Length; i++)
    //    {
    //        if (day != string.Empty) day += ", ";
    //        switch (list[i])
    //        {                
    //            case "1":
    //                day+="Thứ 2";
    //                break;
    //            case "2":
    //                day += "Thứ 3";
    //                break;
    //            case "3":
    //                day += "Thứ 4";
    //                break;
    //            case "4":
    //                day += "Thứ 5";
    //                break;
    //            case "5":
    //                day += "Thứ 6";
    //                break;
    //            case "6":
    //                day += "Thứ 7";
    //                break;                
    //            case "0":
    //                day += "Chủ nhật";
    //                break;
    //        }
    //    }
    //    return day;
    //}
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
    protected void BindDDL()
    {
        //ddlScience.Items.Clear();
        //ddlScience.DataSource = (new ScienceService()).GetAll();
        //ddlScience.DataBind();
        //ddlScience.Items.Insert(0, new ListItem("-- Chọn khoa --", "0"));
        //ddlScience.SelectedValue = "9";

        //cbkDayWeek.Items.Clear();
        //for (int i = 0; i <= 6; i++)
        //{
        //    if (i == 0)
        //        cbkDayWeek.Items.Add(new ListItem("Chủ nhật", i.ToString()));
        //    else
        //        cbkDayWeek.Items.Add(new ListItem("Thứ " + i, i.ToString()));
        //}

        MembershipUserCollection muc = Membership.GetAllUsers();
        MembershipUserCollection mucBSGM,mucKTV;
        mucBSGM = new MembershipUserCollection();
        mucKTV = new MembershipUserCollection();
        ProfileCommon pc;
        foreach (MembershipUser mu in muc)
        {
            pc = Profile.GetProfile(mu.UserName);
            if (pc.Department == "Bác sỹ gây mê")
            {
                mucBSGM.Add(mu);
            }
            else if (pc.Department == "Kỹ thuật viên gây mê")
            {
                mucKTV.Add(mu);
            }
        }

        rblStaff.DataSource = mucBSGM;
        rblStaff.DataBind();

        ddlKTV.DataSource = mucKTV;
        ddlKTV.DataBind();
    }
    protected void BindForEdit()
    {
        DutyService _DutyService=new DutyService();
        Duty _Duty = _DutyService.GetById(Convert.ToInt32(hfID.Value));
        if (_Duty != null)
        {
            //string[] list = _Duty.DayWeek.ToString().Split(',');
            //ddlScience.SelectedValue = _Duty.ScienceId.Value.ToString();
            txtFromDate.Text = _Duty.FromDate.Value.ToString("dd/MM/yyyy");
            txtToDate.Text = _Duty.FromDate.Value.ToString("dd/MM/yyyy");
            liscript.Text = "getlistday();";
            foreach (string name in _Duty.BsName.Split(','))
            {
                liscript.Text += "$('select[name=\"ctl00$ContentPlaceHolder1$bsname0\"]').multiselect('select', '"+name+"');";                
            }
            foreach (string name in _Duty.KtvName.Split(','))
            {
                liscript.Text += "$('select[name=\"ctl00$ContentPlaceHolder1$ktvname0\"]').multiselect('select', '" + name + "');";
            }
            //rblStaff.SelectedValue = _Duty.Name;
            //for (int i = 0;i< rblStaff.Items.Count; i++)
            //{
            //    if (_Duty.Name == rblStaff.Items[i].Text)
            //    {
            //        rblStaff.Items[i].Selected = true;
            //        break;
            //    }
            //}
            //for (int i = 0; i < cbkDayWeek.Items.Count; i++)
            //{
            //    for (int j = 0; j < list.Length; j++)
            //    {
            //        if (cbkDayWeek.Items[i].Value.ToString() == list[j])
            //        {
            //            cbkDayWeek.Items[i].Selected = true;
            //            break;
            //        }
            //    }
            //}
        }
    }
    protected void ResetForm()
    {
        //ddlScience.SelectedIndex = 0;
        txtFromDate.Text = txtToDate.Text = string.Empty;
        for (int i = 0; i < rblStaff.Items.Count; i++)
        {
            if (rblStaff.Items[i].Selected)
            {
                rblStaff.Items[i].Selected = false;
                break;
            }
        }
        //for (int i = 0; i < cbkDayWeek.Items.Count; i++)
        //{
        //    cbkDayWeek.Items[i].Selected = false;
        //}
    }
    protected void btnSave_Click(object s, EventArgs e)
    {
        Duty _Duty;
        DutyService _DutyService = new DutyService();
        DateTime fromdate = DateTime.ParseExact(txtFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        DateTime todate = DateTime.ParseExact(txtToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        double totalday = (todate - fromdate).TotalDays+1;

        for (int i = 0; i < totalday; i++)
        {
            if (Request["hfdate" + i] != null && Request["ctl00$ContentPlaceHolder1$bsname" + i] != null && Request["ctl00$ContentPlaceHolder1$ktvname" + i] != null)
            {
                if (hfID.Value != string.Empty)
                    _Duty = _DutyService.GetById(Convert.ToInt32(hfID.Value));
                else
                    _Duty = new Duty();
                _Duty.BsName = Request["ctl00$ContentPlaceHolder1$bsname" + i].ToString();
                _Duty.KtvName = Request["ctl00$ContentPlaceHolder1$ktvname" + i].ToString();
                _Duty.ScienceId = 9;
                _Duty.FromDate = DateTime.ParseExact(Request["hfdate" + i].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
                _Duty.TypeCode = Request["type"].ToString();
                _DutyService.Save(_Duty);
            }
        }
        
        BindData();
        pnEdit.Visible = false;
        pnList.Visible = true;
    }
    protected void btnCancel_Click(object s, EventArgs e)
    {
        pnEdit.Visible = false;
        pnList.Visible = true;
    }
    protected void btnAddNew_Click(object s, EventArgs e)
    {
        BindDDL();
        ResetForm();
        pnEdit.Visible = true;
        pnList.Visible = false;
    }
    protected void btnDelete_Click(object s, EventArgs e)
    {
        CheckBox chkId;
        DutyService _DutyService = new DutyService();
        foreach (GridViewRow row in gvDuty.Rows)
        {
            chkId = (CheckBox)row.FindControl("chkId");
            if (chkId.Checked)
            {
                _DutyService.Delete(Convert.ToInt32(gvDuty.DataKeys[row.RowIndex].Value));
            }
        }
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
    protected void ddlMonth_Click(object s, EventArgs e)
    {
        BindData();
    }
}
