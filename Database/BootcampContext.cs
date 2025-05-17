using System;
using System.Collections.Generic;
using CyberClub.Models;
using Microsoft.EntityFrameworkCore;

namespace CyberClub.Database;

public partial class BootcampContext : DbContext
{
    public BootcampContext()
    {
    }

    public BootcampContext(DbContextOptions<BootcampContext> options)
        : base(options)
    {
    }

    public virtual DbSet<BalanceReplenishment> BalanceReplenishments { get; set; }

    public virtual DbSet<Client> Clients { get; set; }

    public virtual DbSet<ClientsMembership> ClientsMemberships { get; set; }

    public virtual DbSet<LoyalityLevel> LoyalityLevels { get; set; }

    public virtual DbSet<Membership> Memberships { get; set; }

    public virtual DbSet<MembershipBuy> MembershipBuys { get; set; }

    public virtual DbSet<PaymentType> PaymentTypes { get; set; }

    public virtual DbSet<ReplenishmentType> ReplenishmentTypes { get; set; }

    public virtual DbSet<Reservation> Reservations { get; set; }

    public virtual DbSet<ReservationStatus> ReservationStatuses { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Session> Sessions { get; set; }

    public virtual DbSet<SessionPayment> SessionPayments { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<WorkStation> WorkStations { get; set; }

    public virtual DbSet<WorkStationStatus> WorkStationStatuses { get; set; }

    public virtual DbSet<WorkStationType> WorkStationTypes { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=DESKTOP-6HJ8V04;Database=Bootcamp;Trusted_Connection=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<BalanceReplenishment>(entity =>
        {
            entity.ToTable("BalanceReplenishment");

            entity.Property(e => e.Amount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IdClient).HasColumnName("Id_Client");

            entity.HasOne(d => d.IdClientNavigation).WithMany(p => p.BalanceReplenishments)
                .HasForeignKey(d => d.IdClient)
                .HasConstraintName("FK_BalanceReplenishment_Client");

            entity.HasOne(d => d.ReplenishmentTypeNavigation).WithMany(p => p.BalanceReplenishments)
                .HasForeignKey(d => d.ReplenishmentType)
                .HasConstraintName("FK_BalanceReplenishment_ReplenishmentType");
        });

        modelBuilder.Entity<Client>(entity =>
        {
            entity.ToTable("Client");

            entity.Property(e => e.Balance).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.IdUser).HasColumnName("Id_User");

            entity.HasOne(d => d.IdUserNavigation).WithMany(p => p.Clients)
                .HasForeignKey(d => d.IdUser)
                .HasConstraintName("FK_Client_User");

            entity.HasOne(d => d.LoyalityLevelNavigation).WithMany(p => p.Clients)
                .HasForeignKey(d => d.LoyalityLevel)
                .HasConstraintName("FK_Client_LoyalityLevel");
        });

        modelBuilder.Entity<ClientsMembership>(entity =>
        {
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Expires).HasColumnType("datetime");
            entity.Property(e => e.IdMembershipBuy).HasColumnName("Id_MembershipBuy");

            entity.HasOne(d => d.IdMembershipBuyNavigation).WithMany(p => p.ClientsMemberships)
                .HasForeignKey(d => d.IdMembershipBuy)
                .HasConstraintName("FK_ClientsMemberships_MembershipBuy");
        });

        modelBuilder.Entity<LoyalityLevel>(entity =>
        {
            entity.ToTable("LoyalityLevel");

            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.RequiredSpend).HasColumnType("decimal(10, 2)");
        });

        modelBuilder.Entity<Membership>(entity =>
        {
            entity.ToTable("Membership");

            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.Price).HasColumnType("decimal(10, 2)");
        });

        modelBuilder.Entity<MembershipBuy>(entity =>
        {
            entity.ToTable("MembershipBuy");

            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IdClient).HasColumnName("Id_client");
            entity.Property(e => e.IdMembership).HasColumnName("Id_Membership");

            entity.HasOne(d => d.IdClientNavigation).WithMany(p => p.MembershipBuys)
                .HasForeignKey(d => d.IdClient)
                .HasConstraintName("FK_MembershipBuy_Client");

            entity.HasOne(d => d.IdMembershipNavigation).WithMany(p => p.MembershipBuys)
                .HasForeignKey(d => d.IdMembership)
                .HasConstraintName("FK_MembershipBuy_Membership");
        });

        modelBuilder.Entity<PaymentType>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("PaymentType");

            entity.Property(e => e.Name)
                .HasMaxLength(10)
                .IsFixedLength();
        });

        modelBuilder.Entity<ReplenishmentType>(entity =>
        {
            entity.ToTable("ReplenishmentType");

            entity.Property(e => e.Id).ValueGeneratedNever();
            entity.Property(e => e.TypeName).HasMaxLength(50);
        });

        modelBuilder.Entity<Reservation>(entity =>
        {
            entity.ToTable("Reservation");

            entity.Property(e => e.IdSession).HasColumnName("Id_Session");

            entity.HasOne(d => d.IdSessionNavigation).WithMany(p => p.Reservations)
                .HasForeignKey(d => d.IdSession)
                .HasConstraintName("FK_Reservation_Session");

            entity.HasOne(d => d.ReservationStatusNavigation).WithMany(p => p.Reservations)
                .HasForeignKey(d => d.ReservationStatus)
                .HasConstraintName("FK_Reservation_ReservationStatus");
        });

        modelBuilder.Entity<ReservationStatus>(entity =>
        {
            entity.ToTable("ReservationStatus");

            entity.Property(e => e.Name).HasMaxLength(50);
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Role1);

            entity.ToTable("Role");

            entity.Property(e => e.Role1)
                .HasMaxLength(5)
                .HasColumnName("Role");
            entity.Property(e => e.Name).HasMaxLength(30);
        });

        modelBuilder.Entity<Session>(entity =>
        {
            entity.ToTable("Session");

            entity.Property(e => e.IdClient).HasColumnName("Id_Client");
            entity.Property(e => e.IdWorkStation).HasColumnName("Id_WorkStation");
            entity.Property(e => e.StartTime)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.IdClientNavigation).WithMany(p => p.Sessions)
                .HasForeignKey(d => d.IdClient)
                .HasConstraintName("FK_Session_Client");

            entity.HasOne(d => d.IdWorkStationNavigation).WithMany(p => p.Sessions)
                .HasForeignKey(d => d.IdWorkStation)
                .HasConstraintName("FK_Session_WorkStation");
        });

        modelBuilder.Entity<SessionPayment>(entity =>
        {
            entity.ToTable("SessionPayment");

            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IdSession).HasColumnName("Id_Session");
            entity.Property(e => e.TotalCost).HasColumnType("decimal(10, 2)");

            entity.HasOne(d => d.IdSessionNavigation).WithMany(p => p.SessionPayments)
                .HasForeignKey(d => d.IdSession)
                .HasConstraintName("FK_SessionPayment_Session");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.ToTable("User");

            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Fullname).HasMaxLength(50);
            entity.Property(e => e.Password).HasMaxLength(50);
            entity.Property(e => e.Phone).HasMaxLength(12);
            entity.Property(e => e.Role).HasMaxLength(5);

            entity.HasOne(d => d.RoleNavigation).WithMany(p => p.Users)
                .HasForeignKey(d => d.Role)
                .HasConstraintName("FK_User_Role");
        });

        modelBuilder.Entity<WorkStation>(entity =>
        {
            entity.ToTable("WorkStation");

            entity.Property(e => e.Id).ValueGeneratedNever();
            entity.Property(e => e.Cost).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.IdStatus).HasColumnName("Id_Status");

            entity.HasOne(d => d.IdStatusNavigation).WithMany(p => p.WorkStations)
                .HasForeignKey(d => d.IdStatus)
                .HasConstraintName("FK_WorkStation_WorkStationStatus");

            entity.HasOne(d => d.WorkStationTypeNavigation).WithMany(p => p.WorkStations)
                .HasForeignKey(d => d.WorkStationType)
                .HasConstraintName("FK_WorkStation_WorkStationType");
        });

        modelBuilder.Entity<WorkStationStatus>(entity =>
        {
            entity.ToTable("WorkStationStatus");

            entity.Property(e => e.Name).HasMaxLength(50);
        });

        modelBuilder.Entity<WorkStationType>(entity =>
        {
            entity.ToTable("WorkStationType");

            entity.Property(e => e.Name).HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
