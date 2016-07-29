
/// Summary description for WorkContext
/// </summary>
public class WorkContext
{
    private int _scienceId;
    public int SienceId
    {
        get { return _scienceId; }
        set { _scienceId = value; }
    }
    private string _userName;
    public string UserName
    {
        get { return _userName; }
        set { _userName = value; }
    }

    private string[] _userRoles;
    public string[] UserRoles
    {
        get
        {
            return _userRoles;
        }
        set
        {
            _userRoles = value;
        }
    }

    public WorkContext()
    {
      
    }
    public WorkContext(string userName, int scienceId, string[] userRoles)
    {
        _scienceId = scienceId;
        _userName = userName;
        _userRoles = userRoles;
    }
    public bool CheckRole(string role)
    {
        bool isCheck = false;
        if (_userRoles.Length >0)
        {
            for(int i=0;i< _userRoles.Length;i++)
            {
                if (_userRoles[i] == role)
                {
                    isCheck = true;
                    break;
                }
            }
        }
        return isCheck;
    }
}