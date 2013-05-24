using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Data.Entity;
using System.Linq.Expressions;
using MSI.CCAT.Data.Models;
namespace MSI.CCAT.Data.Repositories
{
    public abstract class RepositoryBase<T> where T : class
    {
        private DbContext dataContext;
        private readonly IDbSet<T> dbset;
        protected RepositoryBase(IDatabaseFactory databaseFactory)
        {
            DatabaseFactory = databaseFactory;
            dbset = DataContext.Set<T>();
        }

        protected IDatabaseFactory DatabaseFactory
        {
            get;
            private set;
        }

        protected DbContext DataContext
        {
            get { return dataContext ?? (dataContext = DatabaseFactory.Get()); }
        }
        public void Add(T entity)
        {
            dbset.Add(entity);
            dataContext.SaveChanges();
        }
        public void Update(T entity)
        {
            dbset.Attach(entity);
            dataContext.Entry(entity).State = EntityState.Modified;
            dataContext.SaveChanges();
        }
        public void Delete(T entity)
        {
            dbset.Remove(entity);
            dataContext.SaveChanges();
        }
        public void Delete(Expression<Func<T, bool>> where)
        {
            IEnumerable<T> objects = dbset.Where<T>(where).AsEnumerable();
            foreach (T obj in objects)
                dbset.Remove(obj);
        }
        public T GetById(long id)
        {
            return dbset.Find(id);
        }
        public T GetById(string id)
        {
            return dbset.Find(id);
        }
        public T GetById(int id)
        {
            return dbset.Find(id);
        }
        public IEnumerable<T> GetAll()
        {
            return dbset.ToList();
        }
        public IEnumerable<T> GetMany(Expression<Func<T, bool>> where)
        {
            return dbset.Where(where).ToList();
        }
        public T Get(Expression<Func<T, bool>> where)
        {
            return dbset.Where(where).FirstOrDefault<T>();
        }
    }
}
