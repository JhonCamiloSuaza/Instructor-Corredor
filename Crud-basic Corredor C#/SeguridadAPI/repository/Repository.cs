using Microsoft.EntityFrameworkCore;
using SeguridadAPI.Entities;

namespace SeguridadAPI.Data.Repositories
{
    public class Repository<T> where T : class
    {
        protected readonly ApplicationDbContext _context;
        protected readonly DbSet<T> _dbSet;

        public Repository(ApplicationDbContext context)
        {
            _context = context;
            _dbSet = context.Set<T>();
        }

        public IEnumerable<T> GetAll() => _dbSet.ToList();

        public T? GetById(int id) => _dbSet.Find(id);

        public void Add(T entity) 
        { 
            _dbSet.Add(entity); 
            _context.SaveChanges(); 
        }

        public void Update(T entity) 
        { 
            _dbSet.Update(entity); 
            _context.SaveChanges(); 
        }

        public void Delete(T entity) 
        { 
            _dbSet.Remove(entity); 
            _context.SaveChanges(); 
        }

        public IEnumerable<T> Find(Func<T, bool> predicate) => _dbSet.Where(predicate).ToList();
    }
}
