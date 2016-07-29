using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using MHWeb.Services;
public partial class Admin_ManageUserRole_UserUpdate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dtlRole.DataSource = Roles.GetAllRoles();
            dtlRole.DataBind();
            ddlScience.DataSource = (new ScienceService()).GetAll();
            ddlScience.DataBind();

            if (Request.QueryString["user"] != null)
            {
                BindForEdit(Request.QueryString["user"].ToString());
            }
        }
    }
    protected void btnSave_Click(object s, EventArgs e)
    {
        if (Request.QueryString["user"] != null)
        {
            Update();
        }
        else
        {
            if (IsValid)
            {
                Insert();
            }
        }
        Response.Redirect("Membership.aspx");        
    }
    protected void BindForEdit(string UserName)
    {
        List<MembershipUtilities.MembershipUserWrapper> listUser = MembershipUtilities.MembershipUserODS.GetMembers(true, true, UserName, string.Empty);
        if (listUser.Count > 0)
        {
            txtUserName.Text = listUser[0].UserName;
            txtUserName.ReadOnly = true;
            txtEmail.Text = listUser[0].Email;
            txtComment.Text = listUser[0].Comment;
            chkApprove.Checked = listUser[0].IsApproved;            
        }
        
        CheckBox chkId;
        HiddenField hfRole;
        foreach (DataListItem item in dtlRole.Items)
        {
            chkId = (CheckBox)item.FindControl("chkId");
            hfRole = (HiddenField)item.FindControl("hfRole");
            chkId.Checked = Roles.IsUserInRole(UserName, hfRole.Value);            
        }
        ProfileCommon _ProfileCommon = Profile.GetProfile(UserName);
        ddlDepartment.SelectedValue = _ProfileCommon.Department;
        ddlScience.SelectedValue = _ProfileCommon.Science;
    }
    protected void Update()
    {
        txtUserName.ReadOnly = false;
        ObjectDataSourceMembershipUser.UpdateParameters["UserName"].DefaultValue = txtUserName.Text.Trim();        
        ObjectDataSourceMembershipUser.UpdateParameters["comment"].DefaultValue = txtComment.Text;
        ObjectDataSourceMembershipUser.UpdateParameters["email"].DefaultValue = txtEmail.Text;
        ObjectDataSourceMembershipUser.UpdateParameters["isApproved"].DefaultValue = chkApprove.Checked == true ? "true" : "false";
        ObjectDataSourceMembershipUser.Update();
         
        if (txtPassword.Text.Trim() != string.Empty)
        {
            MembershipUser usr = Membership.GetUser(txtUserName.Text.Trim());
            usr.ChangePassword(usr.ResetPassword(), txtPassword.Text.Trim());
        }

        CheckBox chkId;
        HiddenField hfRole;
        foreach (DataListItem item in dtlRole.Items)
        {
            chkId = (CheckBox)item.FindControl("chkId");
            hfRole = (HiddenField)item.FindControl("hfRole");
            if (chkId.Checked && !Roles.IsUserInRole(txtUserName.Text.Trim(), hfRole.Value))
            {
                Roles.AddUserToRole(txtUserName.Text.Trim(), hfRole.Value);
            }
            else if (!chkId.Checked && Roles.IsUserInRole(txtUserName.Text.Trim(), hfRole.Value))
            {
                Roles.RemoveUserFromRole(txtUserName.Text.Trim(), hfRole.Value);
            }
        }
        ProfileCommon _ProfileCommon = Profile.GetProfile(txtUserName.Text);
        _ProfileCommon.Science = ddlScience.SelectedValue;
        _ProfileCommon.Department = ddlDepartment.SelectedItem.Text;
        _ProfileCommon.Save();
    }
    protected void Insert()
    {
        ObjectDataSourceMembershipUser.InsertParameters["UserName"].DefaultValue = txtUserName.Text.Trim();
        ObjectDataSourceMembershipUser.InsertParameters["password"].DefaultValue = txtPassword.Text.Trim();
        ObjectDataSourceMembershipUser.InsertParameters["comment"].DefaultValue = txtComment.Text;
        ObjectDataSourceMembershipUser.InsertParameters["email"].DefaultValue = txtUserName.Text.Trim().Replace(" ","");
        ObjectDataSourceMembershipUser.InsertParameters["isApproved"].DefaultValue = chkApprove.Checked == true ? "true" : "false";
        ObjectDataSourceMembershipUser.Insert();

        CheckBox chkId;
        HiddenField hfRole;
        foreach (DataListItem item in dtlRole.Items)
        {
            chkId = (CheckBox)item.FindControl("chkId");
            hfRole = (HiddenField)item.FindControl("hfRole");
            if (chkId.Checked)
            {
                Roles.AddUserToRole(txtUserName.Text.Trim(), hfRole.Value);
            }
        }
        ProfileCommon _ProfileCommon = Profile.GetProfile(txtUserName.Text);
        _ProfileCommon.Science = ddlScience.SelectedValue;
        _ProfileCommon.Department = ddlDepartment.SelectedItem.Text;
        _ProfileCommon.Save();
    }
    protected void CheckUsername(object source, ServerValidateEventArgs args)
    {
        MembershipUser mu = Membership.GetUser(txtUserName.Text);
        if (mu != null)
            args.IsValid = false;
        else
            args.IsValid = true;
    }
    protected void CheckEmail(object source, ServerValidateEventArgs args)
    {
        string mu = Membership.GetUserNameByEmail(txtEmail.Text);
        if (!string.IsNullOrEmpty(mu))
            args.IsValid = false;
        else
            args.IsValid = true;
    }
    protected void btnCancel_Click(object s, EventArgs e)
    {
        Response.Redirect("~/admin/ManageUserRole/Membership.aspx");
    }
}
