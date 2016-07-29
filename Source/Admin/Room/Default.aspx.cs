using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MHWeb.Services;
using MHWeb.Entities;

public partial class Admin_Room_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        BindData();
    }
    protected void BindData()
    {
        gvRoom.DataSource = (new RoomService()).GetAll();
        gvRoom.DataBind();
    }
    protected void btnAddNew_Click(object s, EventArgs e)
    {
        pnEdit.Visible = true;
        pnList.Visible = false;
    }
    protected void btnSave_Click(object s, EventArgs e)
    {
        Room _Room;
        RoomService _RoomService = new RoomService();
        if (hfID.Value != string.Empty)
        {
            _Room = _RoomService.GetById(Convert.ToInt32(hfID.Value));
        }
        else
        {
            _Room = new Room();
        }
        _Room.Name = txtName.Text;
        //_Room.Floor = txtFloor.Text;
        _Room.TabelQuantity = Convert.ToInt32(txtTable.Text);
        _Room.Detail = txtDetail.Text;
        _RoomService.Save(_Room);
        RestForm();
        pnEdit.Visible = false;
        pnList.Visible = true;
        BindData();
    }
    protected void RestForm()
    {
        txtName.Text = txtDetail.Text = string.Empty;
        txtTable.Text = "0";
    }
    protected void btnCancel_Click(object s, EventArgs e)
    {
        RestForm();
        pnEdit.Visible = false;
        pnList.Visible = true;
    }
    protected void gvRoom_RowCommand(object s, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditItem")
        {
            hfID.Value = e.CommandArgument.ToString();
            BindForEdit();
        }
    }
    protected void BindForEdit()
    {
        RoomService _RoomService = new RoomService();
        Room _Room = _RoomService.GetById(Convert.ToInt32(hfID.Value));
        txtName.Text = _Room.Name;
        txtDetail.Text = _Room.Detail;
        //txtFloor.Text = _Room.Floor;
        txtTable.Text = _Room.TabelQuantity.Value.ToString();
        pnEdit.Visible = true;
        pnList.Visible = false;
    }
    protected void btnDelete_Click(object s, EventArgs e)
    {
        CheckBox chkId;
        RoomService _RoomService = new RoomService();
        foreach (GridViewRow row in gvRoom.Rows)
        {
            chkId = (CheckBox)row.FindControl("chkId");
            if (chkId.Checked)
            {
                _RoomService.Delete(Convert.ToInt32(gvRoom.DataKeys[row.RowIndex].Value));
            }
        }
        BindData();
    }
}
