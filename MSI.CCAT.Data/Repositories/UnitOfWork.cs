using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Collections;
namespace MSI.CCAT.Data.Repositories
{
    public interface IUnitOfWork
    {
        void Dispose();
        void Save();
        void Dispose(bool disposing);
        IRepository<T> Repository<T>() where T : class;
    }

    public class UnitOfWork : IUnitOfWork
    {
        private readonly IDatabaseFactory dbFactory;

        private bool _disposed;
        private Hashtable _repositories;
        private AccountsRepository accountRepository;
        public UnitOfWork(IDatabaseFactory context)
        {
            dbFactory = context;
            accountRepository = new AccountsRepository(dbFactory);
        }

        //public UnitOfWork()
        //{
        //    dbFactory = new DBFactory();
        //}

        public UnitOfWork(string dbEntities)
        {
            dbFactory = new DBFactory(dbEntities);
            accountRepository = new AccountsRepository(dbFactory);
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public void Save()
        {
            dbFactory.SaveChanges();
        }

        public virtual void Dispose(bool disposing)
        {
            if (!_disposed)
                if (disposing)
                    dbFactory.Dispose();

            _disposed = true;
        }

        public IRepository<T> Repository<T>() where T : class
        {
            if (_repositories == null)
                _repositories = new Hashtable();

            var type = typeof(T).Name;

            if (!_repositories.ContainsKey(type))
            {
                var repositoryType = typeof(RepositoryBase<>);
                try
                {
                    var repositoryInstance =
                        Activator.CreateInstance(repositoryType
                                .MakeGenericType(typeof(T)), dbFactory);

                    _repositories.Add(type, repositoryInstance);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }

            return (IRepository<T>)_repositories[type];
        }

        public AccountsRepository AccountRepository
        {
            get
            {
                return accountRepository;
            }
        }
    }
}
