using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using System.Data.SqlClient;
using System.Data;

using MSI.CCAT.Data.Models;
using MSI.CCAT.WEB.ViewModels;
using MSI.CCAT.Data.Repositories;


namespace MSI.CCAT.WEB.Controllers
{
    public class moduleController : Controller
    {

        public static IEnumerable<pageMenuGroupId_and_pageMenuId> get_myPageMenuGroupIds_and_pageMenuIds(int _appId)
        {
            DBFactory db;
            SqlDataReader rdr;
            List<pageMenuGroupId_and_pageMenuId> data = null;
            try
            {
                db = new DBFactory("CCATDBEntities");
                rdr = db.ExecuteReader("MSI_GetMenuDetails", new SqlParameter("@appId", _appId));
                data = new List<pageMenuGroupId_and_pageMenuId>();
                pageMenuGroupId_and_pageMenuId record;
                while (rdr.Read())
                {
                    record = new pageMenuGroupId_and_pageMenuId();
                    record.listOrder = Convert.ToInt32(rdr["listOrder"].ToString());
                    record.pageMenuGroupId = Convert.ToInt32(rdr["pageMenuGroupId"].ToString());
                    record.pageMenuId = Convert.ToInt32(rdr["pageMenuId"].ToString());
                    data.Add(record);
                }
                //Close the datareader
                rdr.Close();
            }
            catch (Exception ex)
            {
                throw new Exception("Exception in DataQueries.get_myPageMenuGroupIds_and_pageMenuIds:" + ex.Message);
            }
            return data.AsEnumerable<pageMenuGroupId_and_pageMenuId>();
        }

        public static List<module_and_PageMenuGroup> myModulePageMenuGroups
        {
            get
            {
                List<pageMenuGroupId_and_pageMenuId> myPageMenuGroupId_and_pageMenuId;
                                
                List<pageMenuGroupId_and_pageMenuId> _myPageMenuGroupId_and_pageMenuId = get_myPageMenuGroupIds_and_pageMenuIds(1).ToList();
                myPageMenuGroupId_and_pageMenuId = _myPageMenuGroupId_and_pageMenuId;
                
                List<module_and_PageMenuGroup> _module_and_PageMenuGroups = new List<module_and_PageMenuGroup>();

                //Get Modules
                ModuleRepository moduleRepository = new ModuleRepository();
                IQueryable<module> myModules = null;
                myModules = moduleRepository.GetAll().AsQueryable<module>();

                //Get PageMenuGroups
                PageMenuGroupRepository pageMenuGroupRepository = new PageMenuGroupRepository();
                IQueryable<pageMenuGroup> active_pageMenuGroups = null;
                active_pageMenuGroups = pageMenuGroupRepository.GetAll().AsQueryable<pageMenuGroup>();

                //Get PageMenu
                PageMenuRepository pageMenuRepository = new PageMenuRepository();
                IQueryable<pageMenu> active_pageMenus = null;
                active_pageMenus = pageMenuRepository.GetAll().AsQueryable<pageMenu>();

                
                foreach (module _module in myModules)
                {
                    if (_module.pageMenuGroups_ != null)
                    {
                        foreach (int _pageMenuGroupId in _module.pageMenuGroups_)
                        {
                            pageMenuGroup _pageMenuGroup = active_pageMenuGroups.Where(a => a.pageMenuGroupId == _pageMenuGroupId).FirstOrDefault();

                            if (_pageMenuGroup != null)
                            {
                                var q = from a in active_pageMenus
                                        join b in myPageMenuGroupId_and_pageMenuId on a.pageMenuId equals b.pageMenuId
                                        where b.pageMenuGroupId == _pageMenuGroupId
                                        orderby b.listOrder
                                        select a;

                                module_and_PageMenuGroup _module_and_PageMenuGroup = new module_and_PageMenuGroup()
                                {
                                    moduleId = _module.moduleId,
                                    pageMenuGroup = _pageMenuGroup,
                                    pageMenus = q.ToList()
                                };

                                _module_and_PageMenuGroups.Add(_module_and_PageMenuGroup);
                            }
                        }
                    }
                }
                
                return _module_and_PageMenuGroups;
                
            }
        }
        
        
        [HttpGet]
        public JsonResult menu()
        {
            genericResponse _response = new genericResponse();

            try
            {
                // All "Page Menu Groups" and their "Page Menus" 
                List<module_and_PageMenuGroup> _module_and_PageMenuGroup = myModulePageMenuGroups;

                #region [ if there are "Page Menu Groups" -> Return a set for a specific Module ]
                if (_module_and_PageMenuGroup != null)
                {
                    var q = from a in _module_and_PageMenuGroup
                            select a;

                    IEnumerable<iItemType> _myModulePageMenuGroups = q.Select(a => new rPageMenuGroup()
                    {
                        pageMenuGroupId = a.pageMenuGroup.pageMenuGroupId,
                        caption = a.pageMenuGroup.caption,
                        description = a.pageMenuGroup.description,
                        iconClass = a.pageMenuGroup.iconClass,
                        pageMenus = a.pageMenus

                    }).ToList();
                    _response = new genericResponse() { success = true, results = _myModulePageMenuGroups.ToList() };
                }
                #endregion

                #region [ Otherwise, return an empty set ]
                else
                    _response = new genericResponse() { success = true };
                #endregion

                JsonResult _result = Json(_response, JsonRequestBehavior.AllowGet);
                return Json(_response, JsonRequestBehavior.AllowGet);
            }
            catch(Exception ex)
            {
                HttpContext.Response.StatusCode = 500;
                _response = new genericResponse { success = false };
                return Json(_response, JsonRequestBehavior.AllowGet);
            }
        }
        

    }
}
