using Microsoft.EntityFrameworkCore;
using SeguridadAPI.Entities;

namespace SeguridadAPI.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options) { }

        // DbSets: cada entidad que mapea a una tabla
       public DbSet<Usuario> Usuarios { get; set; }   
        public DbSet<Roles> Roles { get; set; }
        public DbSet<UsuarioRol> UsuarioRoles { get; set; }
        public DbSet<Permisos> Permisos { get; set; }
        public DbSet<RolPermiso> RolPermisos { get; set; }
        public DbSet<Auditoria> Auditorias { get; set; }
        public DbSet<SesionUsuario> SesionUsuarios { get; set; }
        public DbSet<LogErrores> LogErrores { get; set; }
        public DbSet<ConfiguracionSeguridad> ConfiguracionSeguridad { get; set; }
        public DbSet<PoliticasContraseñas> PoliticasContraseñas { get; set; }
  protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // -------------------------------
            // CONFIGURACIÓN MANY-TO-MANY
            // -------------------------------

            // UsuarioRol → Tabla intermedia entre Usuario y Roles
            modelBuilder.Entity<UsuarioRol>()
                .HasKey(ur => new { ur.UsuarioID, ur.RolID });

            modelBuilder.Entity<UsuarioRol>()
                .HasOne(ur => ur.Usuario)
                .WithMany(u => u.UsuarioRoles)
                .HasForeignKey(ur => ur.UsuarioID);

            modelBuilder.Entity<UsuarioRol>()
                .HasOne(ur => ur.Rol)
                .WithMany(r => r.UsuarioRoles)
                .HasForeignKey(ur => ur.RolID);

            // RolPermiso → Tabla intermedia entre Roles y Permisos
            modelBuilder.Entity<RolPermiso>()
                .HasKey(rp => new { rp.RolID, rp.PermisoID });

            modelBuilder.Entity<RolPermiso>()
                .HasOne(rp => rp.Rol)
                .WithMany(r => r.RolPermisos)
                .HasForeignKey(rp => rp.RolID);

            modelBuilder.Entity<RolPermiso>()
                .HasOne(rp => rp.Permiso)
                .WithMany(p => p.RolPermisos)
                .HasForeignKey(rp => rp.PermisoID);

            // Nombre correcto de la tabla PoliticasContraseñas
            modelBuilder.Entity<PoliticasContraseñas>()
                .ToTable("PoliticasContrasenas");
        }
    }
}