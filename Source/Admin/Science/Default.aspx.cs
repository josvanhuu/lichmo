using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MHWeb.Services;
using MHWeb.Entities;
public partial class Admin_Science_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            BindData();
    }
    protected void BindData()
    {
        gvScience.DataSource = (new ScienceService()).GetAll();
        gvScience.DataBind();
    }
    protected void btnAddNew_Click(object s, EventArgs e)
    {
        pnEdit.Visible = true;
        pnList.Visible = false;
    }
    protected void btnSave_Click(object s, EventArgs e)
    {
        Science _Science;
        ScienceService _ScienceService = new ScienceService();
        if (hfID.Value != string.Empty)
        {
            _Science = _ScienceService.GetById(Convert.ToInt32(hfID.Value));
        }
        else
        {
            _Science = new Science();
        }
        _Science.Name = txtName.Text;
        _Science.Detail = txtDetail.Text;
        _ScienceService.Save(_Science);
        RestForm();
        pnEdit.Visible = false;
        pnList.Visible = true;
        BindData();
        Response.Write(txtDetail.Text);
    }
    protected void RestForm()
    {
        txtName.Text = txtDetail.Text = string.Empty;
    }
    protected void btnCancel_Click(object s, EventArgs e)
    {
        RestForm();
        pnEdit.Visible = false;
        pnList.Visible = true;
    }
    protected void gvScience_RowCommand(object s, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditItem")
        {
            hfID.Value = e.CommandArgument.ToString();
            BindForEdit();
        }        
    }
    protected void BindForEdit()
    {
        ScienceService _ScienceService = new ScienceService();
        Science _Science = _ScienceService.GetById(Convert.ToInt32(hfID.Value));
        txtName.Text = _Science.Name;
        txtDetail.Text = _Science.Detail;
        pnEdit.Visible = true;
        pnList.Visible = false;
    }
    protected void btnDelete_Click(object s, EventArgs e)
    {
        CheckBox chkId;
        ScienceService _ScienceService = new ScienceService();
        foreach (GridViewRow row in gvScience.Rows)
        {
            chkId = (CheckBox)row.FindControl("chkId");
            if (chkId.Checked)
            {
                _ScienceService.Delete(Convert.ToInt32(gvScience.DataKeys[row.RowIndex].Value));
            }
        }
        BindData();
    }
}
