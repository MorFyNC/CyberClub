USE [master]
GO
/****** Object:  Database [Bootcamp]    Script Date: 19.05.2025 0:32:17 ******/
CREATE DATABASE [Bootcamp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bootcamp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Bootcamp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Bootcamp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Bootcamp_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Bootcamp] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bootcamp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bootcamp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bootcamp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bootcamp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bootcamp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bootcamp] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bootcamp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bootcamp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bootcamp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bootcamp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bootcamp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bootcamp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bootcamp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bootcamp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bootcamp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bootcamp] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bootcamp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bootcamp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bootcamp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bootcamp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bootcamp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bootcamp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bootcamp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bootcamp] SET RECOVERY FULL 
GO
ALTER DATABASE [Bootcamp] SET  MULTI_USER 
GO
ALTER DATABASE [Bootcamp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bootcamp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bootcamp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bootcamp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bootcamp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Bootcamp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Bootcamp', N'ON'
GO
ALTER DATABASE [Bootcamp] SET QUERY_STORE = ON
GO
ALTER DATABASE [Bootcamp] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Bootcamp]
GO
/****** Object:  Table [dbo].[BalanceReplenishment]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BalanceReplenishment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Client] [int] NULL,
	[Amount] [decimal](10, 2) NULL,
	[ReplenishmentType] [int] NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [PK_BalanceReplenishment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BonusMoves]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BonusMoves](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_BonusMoves] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_User] [int] NULL,
	[Balance] [decimal](10, 2) NULL,
	[Bonuses] [int] NULL,
	[LoyalityLevel] [int] NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientsMemberships]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientsMemberships](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_MembershipBuy] [int] NULL,
	[HoursLeft] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[Expires] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_ClientsMemberships] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoyalityLevel]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoyalityLevel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[BonusIncrease] [int] NULL,
	[RequiredSpend] [decimal](10, 2) NULL,
 CONSTRAINT [PK_LoyalityLevel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Membership]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Membership](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[HoursCount] [int] NULL,
	[Price] [decimal](10, 2) NULL,
 CONSTRAINT [PK_Membership] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MembershipBuy]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MembershipBuy](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_client] [int] NULL,
	[Id_Membership] [int] NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [PK_MembershipBuy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentType]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentType](
	[Id] [int] NULL,
	[Name] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReplenishmentType]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReplenishmentType](
	[Id] [int] NOT NULL,
	[TypeName] [nvarchar](50) NULL,
	[Comission] [int] NULL,
 CONSTRAINT [PK_ReplenishmentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservation]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Session] [int] NULL,
	[ReservationStatus] [int] NULL,
 CONSTRAINT [PK_Reservation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReservationStatus]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_ReservationStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Role] [nvarchar](5) NOT NULL,
	[Name] [nvarchar](30) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Session]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Session](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Client] [int] NULL,
	[Id_WorkStation] [int] NULL,
	[StartTime] [datetime] NULL,
	[HoursCount] [int] NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SessionPayment]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SessionPayment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BonusesSpent] [int] NULL,
	[TotalCost] [decimal](10, 2) NULL,
	[CreatedAt] [datetime] NULL,
	[Id_Session] [int] NULL,
	[HoursFromMembership] [int] NULL,
 CONSTRAINT [PK_SessionPayment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Phone] [nvarchar](12) NULL,
	[Password] [nvarchar](50) NULL,
	[Fullname] [nvarchar](50) NULL,
	[BirthDate] [date] NULL,
	[CreatedAt] [datetime] NULL,
	[Role] [nvarchar](5) NULL,
	[RequireData] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkStation]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkStation](
	[Id] [int] NOT NULL,
	[WorkStationType] [int] NULL,
	[Id_Status] [int] NULL,
	[IsBlocked] [bit] NULL,
	[Cost] [decimal](10, 2) NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_WorkStation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkStationStatus]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkStationStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CanReserve] [bit] NULL,
 CONSTRAINT [PK_WorkStationStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkStationType]    Script Date: 19.05.2025 0:32:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkStationType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_WorkStationType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BalanceReplenishment] ON 

INSERT [dbo].[BalanceReplenishment] ([Id], [Id_Client], [Amount], [ReplenishmentType], [CreatedAt]) VALUES (1, 12, CAST(1000.00 AS Decimal(10, 2)), 1, CAST(N'2025-05-18T05:58:36.670' AS DateTime))
INSERT [dbo].[BalanceReplenishment] ([Id], [Id_Client], [Amount], [ReplenishmentType], [CreatedAt]) VALUES (2, 14, CAST(1000.00 AS Decimal(10, 2)), 1, CAST(N'2025-05-18T19:19:40.340' AS DateTime))
INSERT [dbo].[BalanceReplenishment] ([Id], [Id_Client], [Amount], [ReplenishmentType], [CreatedAt]) VALUES (3, 12, CAST(500.00 AS Decimal(10, 2)), 1, CAST(N'2025-05-18T19:44:58.513' AS DateTime))
INSERT [dbo].[BalanceReplenishment] ([Id], [Id_Client], [Amount], [ReplenishmentType], [CreatedAt]) VALUES (4, 12, CAST(100.00 AS Decimal(10, 2)), 2, CAST(N'2025-05-18T21:32:46.453' AS DateTime))
INSERT [dbo].[BalanceReplenishment] ([Id], [Id_Client], [Amount], [ReplenishmentType], [CreatedAt]) VALUES (5, 12, CAST(1000.00 AS Decimal(10, 2)), 2, CAST(N'2025-05-18T22:58:28.373' AS DateTime))
INSERT [dbo].[BalanceReplenishment] ([Id], [Id_Client], [Amount], [ReplenishmentType], [CreatedAt]) VALUES (6, 12, CAST(10000.00 AS Decimal(10, 2)), 2, CAST(N'2025-05-19T00:27:17.200' AS DateTime))
SET IDENTITY_INSERT [dbo].[BalanceReplenishment] OFF
GO
SET IDENTITY_INSERT [dbo].[BonusMoves] ON 

INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (1, 12, 10, CAST(N'2025-05-18T21:46:06.830' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (2, 12, 10, CAST(N'2025-05-18T22:37:02.200' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (3, 12, 30, CAST(N'2025-05-18T22:38:09.377' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (4, 12, 30, CAST(N'2025-05-18T22:38:42.220' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (5, 12, 60, CAST(N'2025-05-18T22:39:44.960' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (6, 12, 30, CAST(N'2025-05-18T22:41:59.103' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (7, 12, 30, CAST(N'2025-05-18T22:44:11.703' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (8, 12, 30, CAST(N'2025-05-18T22:45:24.020' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (9, 12, 30, CAST(N'2025-05-18T22:46:02.010' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (10, 12, 30, CAST(N'2025-05-18T22:46:45.967' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (11, 12, 30, CAST(N'2025-05-18T22:49:42.723' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (12, 12, -30, CAST(N'2025-05-18T22:51:11.893' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (13, 12, 60, CAST(N'2025-05-18T22:59:02.807' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (14, 12, -60, CAST(N'2025-05-18T22:59:12.460' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (15, 12, 20, CAST(N'2025-05-18T23:16:21.290' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (16, 12, 20, CAST(N'2025-05-18T23:22:56.583' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (17, 12, -40, CAST(N'2025-05-18T23:23:45.610' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (18, 12, 20, CAST(N'2025-05-18T23:25:15.520' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (19, 12, -60, CAST(N'2025-05-18T23:32:42.693' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (20, 12, 20, CAST(N'2025-05-18T23:40:59.263' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (21, 12, 0, CAST(N'2025-05-19T00:06:22.337' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (22, 12, 0, CAST(N'2025-05-19T00:14:20.200' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (23, 12, 30, CAST(N'2025-05-19T00:17:09.963' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (24, 12, 300, CAST(N'2025-05-19T00:27:35.507' AS DateTime))
INSERT [dbo].[BonusMoves] ([Id], [ClientId], [Amount], [CreatedAt]) VALUES (25, 12, 0, CAST(N'2025-05-19T00:31:23.613' AS DateTime))
SET IDENTITY_INSERT [dbo].[BonusMoves] OFF
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([Id], [Id_User], [Balance], [Bonuses], [LoyalityLevel]) VALUES (11, 2, CAST(0.00 AS Decimal(10, 2)), 0, 1)
INSERT [dbo].[Client] ([Id], [Id_User], [Balance], [Bonuses], [LoyalityLevel]) VALUES (12, 9, CAST(8590.00 AS Decimal(10, 2)), 330, 3)
INSERT [dbo].[Client] ([Id], [Id_User], [Balance], [Bonuses], [LoyalityLevel]) VALUES (13, 9, CAST(0.00 AS Decimal(10, 2)), 0, 1)
INSERT [dbo].[Client] ([Id], [Id_User], [Balance], [Bonuses], [LoyalityLevel]) VALUES (14, 15, CAST(1000.00 AS Decimal(10, 2)), 0, 1)
INSERT [dbo].[Client] ([Id], [Id_User], [Balance], [Bonuses], [LoyalityLevel]) VALUES (15, 15, CAST(0.00 AS Decimal(10, 2)), 0, 1)
INSERT [dbo].[Client] ([Id], [Id_User], [Balance], [Bonuses], [LoyalityLevel]) VALUES (16, 16, CAST(0.00 AS Decimal(10, 2)), 0, 1)
INSERT [dbo].[Client] ([Id], [Id_User], [Balance], [Bonuses], [LoyalityLevel]) VALUES (17, 17, CAST(0.00 AS Decimal(10, 2)), 0, 1)
INSERT [dbo].[Client] ([Id], [Id_User], [Balance], [Bonuses], [LoyalityLevel]) VALUES (18, 17, CAST(0.00 AS Decimal(10, 2)), 0, 1)
SET IDENTITY_INSERT [dbo].[Client] OFF
GO
SET IDENTITY_INSERT [dbo].[ClientsMemberships] ON 

INSERT [dbo].[ClientsMemberships] ([Id], [Id_MembershipBuy], [HoursLeft], [CreatedAt], [Expires], [IsActive]) VALUES (1, 1, 48, CAST(N'2025-05-19T00:05:40.147' AS DateTime), NULL, 0)
INSERT [dbo].[ClientsMemberships] ([Id], [Id_MembershipBuy], [HoursLeft], [CreatedAt], [Expires], [IsActive]) VALUES (2, 2, 30, CAST(N'2025-05-19T00:10:40.793' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[ClientsMemberships] OFF
GO
SET IDENTITY_INSERT [dbo].[LoyalityLevel] ON 

INSERT [dbo].[LoyalityLevel] ([Id], [Name], [BonusIncrease], [RequiredSpend]) VALUES (1, N'Базовый', 0, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[LoyalityLevel] ([Id], [Name], [BonusIncrease], [RequiredSpend]) VALUES (2, N'Продвинутый', 10, CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[LoyalityLevel] ([Id], [Name], [BonusIncrease], [RequiredSpend]) VALUES (3, N'VIP', 20, CAST(10000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[LoyalityLevel] OFF
GO
SET IDENTITY_INSERT [dbo].[Membership] ON 

INSERT [dbo].[Membership] ([Id], [Name], [HoursCount], [Price]) VALUES (1, N'Базовый', 50, CAST(6000.00 AS Decimal(10, 2)))
INSERT [dbo].[Membership] ([Id], [Name], [HoursCount], [Price]) VALUES (2, N'Продвинутый', 100, CAST(10000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Membership] OFF
GO
SET IDENTITY_INSERT [dbo].[MembershipBuy] ON 

INSERT [dbo].[MembershipBuy] ([Id], [Id_client], [Id_Membership], [CreatedAt]) VALUES (1, 12, 1, CAST(N'2025-05-19T00:05:39.983' AS DateTime))
INSERT [dbo].[MembershipBuy] ([Id], [Id_client], [Id_Membership], [CreatedAt]) VALUES (2, 12, 1, CAST(N'2025-05-19T00:10:40.787' AS DateTime))
SET IDENTITY_INSERT [dbo].[MembershipBuy] OFF
GO
INSERT [dbo].[ReplenishmentType] ([Id], [TypeName], [Comission]) VALUES (1, N'Наличные', 0)
INSERT [dbo].[ReplenishmentType] ([Id], [TypeName], [Comission]) VALUES (2, N'Онлайн', 0)
GO
SET IDENTITY_INSERT [dbo].[Reservation] ON 

INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (15, 15, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (16, 16, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (17, 17, 3)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (18, 18, 3)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (19, 19, 4)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (20, 20, 3)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (21, 21, 3)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (22, 22, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (23, 23, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (24, 24, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (25, 25, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (26, 26, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (27, 27, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (28, 28, 4)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (29, 40, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (30, 41, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (31, 42, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (32, 43, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (33, 44, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (34, 45, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (35, 46, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (36, 47, 4)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (37, 48, 4)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (38, 49, 4)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (39, 50, 4)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (40, 51, 4)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (41, 52, 4)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (42, 53, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (43, 54, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (44, 55, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (45, 56, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (46, 57, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (47, 58, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (48, 59, 3)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (49, 60, 5)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (50, 61, 4)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (51, 62, 1)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (52, 63, 4)
INSERT [dbo].[Reservation] ([Id], [Id_Session], [ReservationStatus]) VALUES (53, 64, 4)
SET IDENTITY_INSERT [dbo].[Reservation] OFF
GO
SET IDENTITY_INSERT [dbo].[ReservationStatus] ON 

INSERT [dbo].[ReservationStatus] ([Id], [Name]) VALUES (1, N'Активная')
INSERT [dbo].[ReservationStatus] ([Id], [Name]) VALUES (2, N'Подтвержденная')
INSERT [dbo].[ReservationStatus] ([Id], [Name]) VALUES (3, N'Отменённая')
INSERT [dbo].[ReservationStatus] ([Id], [Name]) VALUES (4, N'Не подтвержденная')
INSERT [dbo].[ReservationStatus] ([Id], [Name]) VALUES (5, N'Завершенная')
SET IDENTITY_INSERT [dbo].[ReservationStatus] OFF
GO
INSERT [dbo].[Role] ([Role], [Name]) VALUES (N'Admin', N'Администратор')
INSERT [dbo].[Role] ([Role], [Name]) VALUES (N'User', N'Пользователь')
GO
SET IDENTITY_INSERT [dbo].[Session] ON 

INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (15, 12, 1, CAST(N'2025-05-18T04:36:08.980' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (16, 12, 2, CAST(N'2025-05-18T03:39:00.000' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (17, 12, 2, CAST(N'2025-05-18T04:41:30.923' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (18, 12, 1, CAST(N'2025-05-18T09:37:00.000' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (19, 12, 4, CAST(N'2025-05-19T05:48:27.000' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (20, 12, 1, CAST(N'2025-05-18T07:23:00.000' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (21, 12, 1, CAST(N'2025-05-18T08:29:00.000' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (22, 12, 6, CAST(N'2025-05-18T06:40:03.683' AS DateTime), 5)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (23, 12, 12, CAST(N'2025-05-18T06:41:47.413' AS DateTime), 10)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (24, 12, 5, CAST(N'2025-05-18T06:42:23.250' AS DateTime), 5)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (25, 14, 1, CAST(N'2025-05-18T19:20:07.573' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (26, 14, 2, CAST(N'2025-05-18T19:23:51.177' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (27, 14, 4, CAST(N'2025-05-18T19:42:25.113' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (28, 14, 1, CAST(N'2025-05-19T19:44:03.000' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (40, 12, 13, CAST(N'2025-05-18T21:46:05.860' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (41, 12, 6, CAST(N'2025-05-18T22:37:01.840' AS DateTime), 3)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (42, 12, 5, CAST(N'2025-05-18T22:38:09.023' AS DateTime), 3)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (43, 12, 4, CAST(N'2025-05-18T22:38:42.203' AS DateTime), 3)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (44, 12, 3, CAST(N'2025-05-18T22:39:38.380' AS DateTime), 3)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (45, 12, 1, CAST(N'2025-05-18T22:41:52.517' AS DateTime), 3)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (46, 12, 2, CAST(N'2025-05-18T22:44:03.200' AS DateTime), 3)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (47, 12, 1, CAST(N'2025-05-19T02:44:00.000' AS DateTime), 3)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (48, 12, 12, CAST(N'2025-05-20T22:45:49.000' AS DateTime), 3)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (49, 12, 6, CAST(N'2025-05-20T22:46:31.000' AS DateTime), 3)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (50, 12, 13, CAST(N'2025-05-22T22:49:32.000' AS DateTime), 3)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (51, 12, 1, CAST(N'2025-05-21T22:51:03.000' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (52, 12, 6, CAST(N'2025-05-23T22:58:36.000' AS DateTime), 3)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (53, 12, 12, CAST(N'2025-05-27T22:59:03.000' AS DateTime), 3)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (54, 12, 12, CAST(N'2025-05-18T23:16:21.197' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (55, 12, 1, CAST(N'2025-05-18T23:22:56.470' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (56, 12, 1, CAST(N'2025-05-18T23:23:45.597' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (57, 12, 2, CAST(N'2025-05-18T23:25:15.423' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (58, 12, 6, CAST(N'2025-05-18T23:50:00.000' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (59, 12, 5, CAST(N'2025-05-18T23:44:00.000' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (60, 12, 13, CAST(N'2025-05-19T00:06:22.257' AS DateTime), 2)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (61, 12, 12, CAST(N'2025-05-28T00:14:00.000' AS DateTime), 10)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (62, 12, 2, CAST(N'2025-05-19T00:20:00.000' AS DateTime), 1)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (63, 12, 6, CAST(N'2025-05-19T05:06:00.000' AS DateTime), 10)
INSERT [dbo].[Session] ([Id], [Id_Client], [Id_WorkStation], [StartTime], [HoursCount]) VALUES (64, 12, 6, CAST(N'2025-05-28T00:30:55.000' AS DateTime), 10)
SET IDENTITY_INSERT [dbo].[Session] OFF
GO
SET IDENTITY_INSERT [dbo].[SessionPayment] ON 

INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (15, NULL, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T04:37:09.150' AS DateTime), 15, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (16, NULL, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T05:37:43.923' AS DateTime), 18, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (17, NULL, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T05:50:10.303' AS DateTime), 19, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (18, NULL, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T06:24:16.437' AS DateTime), 20, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (19, NULL, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T06:24:42.800' AS DateTime), 21, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (20, NULL, CAST(750.00 AS Decimal(10, 2)), CAST(N'2025-05-18T06:40:03.753' AS DateTime), 22, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (21, NULL, CAST(1500.00 AS Decimal(10, 2)), CAST(N'2025-05-18T06:41:47.583' AS DateTime), 23, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (22, NULL, CAST(750.00 AS Decimal(10, 2)), CAST(N'2025-05-18T06:42:23.420' AS DateTime), 24, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (23, NULL, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T19:20:07.623' AS DateTime), 25, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (24, NULL, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T19:23:51.350' AS DateTime), 26, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (25, NULL, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T19:42:25.290' AS DateTime), 27, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (26, NULL, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T19:44:27.873' AS DateTime), 28, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (32, NULL, CAST(150.00 AS Decimal(10, 2)), CAST(N'2025-05-18T21:46:06.037' AS DateTime), 40, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (33, NULL, CAST(450.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:37:02.013' AS DateTime), 41, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (34, NULL, CAST(600.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:38:09.197' AS DateTime), 42, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (35, NULL, CAST(300.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:38:42.210' AS DateTime), 43, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (36, NULL, CAST(300.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:39:38.383' AS DateTime), 44, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (37, NULL, CAST(300.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:41:52.703' AS DateTime), 45, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (38, NULL, CAST(300.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:44:03.377' AS DateTime), 46, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (39, NULL, CAST(300.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:45:21.010' AS DateTime), 47, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (40, NULL, CAST(450.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:46:02.003' AS DateTime), 48, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (41, NULL, CAST(450.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:46:45.957' AS DateTime), 49, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (42, NULL, CAST(450.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:49:42.537' AS DateTime), 50, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (43, NULL, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:51:11.707' AS DateTime), 51, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (44, 13, CAST(450.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:59:02.777' AS DateTime), 52, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (45, 14, CAST(450.00 AS Decimal(10, 2)), CAST(N'2025-05-18T22:59:12.457' AS DateTime), 53, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (46, 15, CAST(150.00 AS Decimal(10, 2)), CAST(N'2025-05-18T23:16:21.260' AS DateTime), 54, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (47, 16, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T23:22:56.550' AS DateTime), 55, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (48, 17, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T23:23:45.600' AS DateTime), 56, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (49, 18, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-18T23:25:15.490' AS DateTime), 57, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (50, 19, CAST(150.00 AS Decimal(10, 2)), CAST(N'2025-05-18T23:32:42.653' AS DateTime), 58, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (51, 20, CAST(200.00 AS Decimal(10, 2)), CAST(N'2025-05-18T23:40:59.243' AS DateTime), 59, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (52, 21, CAST(300.00 AS Decimal(10, 2)), CAST(N'2025-05-19T00:06:22.293' AS DateTime), 60, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (53, 22, CAST(0.00 AS Decimal(10, 2)), CAST(N'2025-05-19T00:14:20.163' AS DateTime), 61, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (54, 23, CAST(100.00 AS Decimal(10, 2)), CAST(N'2025-05-19T00:17:09.933' AS DateTime), 62, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (55, 24, CAST(1500.00 AS Decimal(10, 2)), CAST(N'2025-05-19T00:27:35.477' AS DateTime), 63, 0)
INSERT [dbo].[SessionPayment] ([Id], [BonusesSpent], [TotalCost], [CreatedAt], [Id_Session], [HoursFromMembership]) VALUES (56, 25, CAST(0.00 AS Decimal(10, 2)), CAST(N'2025-05-19T00:31:23.577' AS DateTime), 64, 0)
SET IDENTITY_INSERT [dbo].[SessionPayment] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Phone], [Password], [Fullname], [BirthDate], [CreatedAt], [Role], [RequireData]) VALUES (2, N'79274077901', N'123123', N'Хисамбиев Булат Айдарович', CAST(N'2006-06-26' AS Date), CAST(N'2025-05-15T04:49:00.247' AS DateTime), N'Admin', 0)
INSERT [dbo].[User] ([Id], [Phone], [Password], [Fullname], [BirthDate], [CreatedAt], [Role], [RequireData]) VALUES (9, N'71111111111', N'123123', N'asd asd asd', CAST(N'2006-06-26' AS Date), CAST(N'2025-05-15T07:10:30.803' AS DateTime), N'User', 0)
INSERT [dbo].[User] ([Id], [Phone], [Password], [Fullname], [BirthDate], [CreatedAt], [Role], [RequireData]) VALUES (10, N'72222222222', NULL, NULL, NULL, CAST(N'2025-05-18T08:37:37.107' AS DateTime), NULL, 1)
INSERT [dbo].[User] ([Id], [Phone], [Password], [Fullname], [BirthDate], [CreatedAt], [Role], [RequireData]) VALUES (11, N'71222222222', NULL, NULL, NULL, CAST(N'2025-05-18T08:53:37.570' AS DateTime), NULL, 1)
INSERT [dbo].[User] ([Id], [Phone], [Password], [Fullname], [BirthDate], [CreatedAt], [Role], [RequireData]) VALUES (12, N'72121212312', NULL, NULL, NULL, CAST(N'2025-05-18T08:55:26.107' AS DateTime), NULL, 1)
INSERT [dbo].[User] ([Id], [Phone], [Password], [Fullname], [BirthDate], [CreatedAt], [Role], [RequireData]) VALUES (13, N'71321312222', NULL, NULL, NULL, CAST(N'2025-05-18T08:57:30.993' AS DateTime), NULL, 1)
INSERT [dbo].[User] ([Id], [Phone], [Password], [Fullname], [BirthDate], [CreatedAt], [Role], [RequireData]) VALUES (14, N'72312313211', NULL, NULL, NULL, CAST(N'2025-05-18T08:57:55.633' AS DateTime), NULL, 1)
INSERT [dbo].[User] ([Id], [Phone], [Password], [Fullname], [BirthDate], [CreatedAt], [Role], [RequireData]) VALUES (15, N'73333333333', N'123123', N'dsad asd asd', CAST(N'2003-02-25' AS Date), CAST(N'2025-05-18T19:18:46.080' AS DateTime), N'User', 0)
INSERT [dbo].[User] ([Id], [Phone], [Password], [Fullname], [BirthDate], [CreatedAt], [Role], [RequireData]) VALUES (16, N'74444444444', N'123123', N'фыв asdd asd', CAST(N'2003-05-25' AS Date), CAST(N'2025-05-18T19:43:16.483' AS DateTime), N'User', 0)
INSERT [dbo].[User] ([Id], [Phone], [Password], [Fullname], [BirthDate], [CreatedAt], [Role], [RequireData]) VALUES (17, N'75555555555', N'123123', N'afa asdf asdf', CAST(N'2003-05-25' AS Date), CAST(N'2025-05-18T19:43:37.267' AS DateTime), N'User', 0)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
INSERT [dbo].[WorkStation] ([Id], [WorkStationType], [Id_Status], [IsBlocked], [Cost], [Description]) VALUES (1, 1, 1, 0, CAST(100.00 AS Decimal(10, 2)), NULL)
INSERT [dbo].[WorkStation] ([Id], [WorkStationType], [Id_Status], [IsBlocked], [Cost], [Description]) VALUES (2, 1, 1, 0, CAST(100.00 AS Decimal(10, 2)), NULL)
INSERT [dbo].[WorkStation] ([Id], [WorkStationType], [Id_Status], [IsBlocked], [Cost], [Description]) VALUES (3, 1, 1, 0, CAST(100.00 AS Decimal(10, 2)), NULL)
INSERT [dbo].[WorkStation] ([Id], [WorkStationType], [Id_Status], [IsBlocked], [Cost], [Description]) VALUES (4, 1, 1, 0, CAST(100.00 AS Decimal(10, 2)), NULL)
INSERT [dbo].[WorkStation] ([Id], [WorkStationType], [Id_Status], [IsBlocked], [Cost], [Description]) VALUES (5, 1, 1, 0, CAST(200.00 AS Decimal(10, 2)), N'dawdasda')
INSERT [dbo].[WorkStation] ([Id], [WorkStationType], [Id_Status], [IsBlocked], [Cost], [Description]) VALUES (6, 1, 1, 0, CAST(150.00 AS Decimal(10, 2)), NULL)
INSERT [dbo].[WorkStation] ([Id], [WorkStationType], [Id_Status], [IsBlocked], [Cost], [Description]) VALUES (12, 1, 2, 0, CAST(150.00 AS Decimal(10, 2)), NULL)
INSERT [dbo].[WorkStation] ([Id], [WorkStationType], [Id_Status], [IsBlocked], [Cost], [Description]) VALUES (13, 1, 1, 0, CAST(150.00 AS Decimal(10, 2)), NULL)
GO
SET IDENTITY_INSERT [dbo].[WorkStationStatus] ON 

INSERT [dbo].[WorkStationStatus] ([Id], [Name], [CanReserve]) VALUES (1, N'Занята', 0)
INSERT [dbo].[WorkStationStatus] ([Id], [Name], [CanReserve]) VALUES (2, N'Свободна', 1)
INSERT [dbo].[WorkStationStatus] ([Id], [Name], [CanReserve]) VALUES (3, N'Неисправна', 0)
SET IDENTITY_INSERT [dbo].[WorkStationStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[WorkStationType] ON 

INSERT [dbo].[WorkStationType] ([Id], [Name]) VALUES (1, N'PC')
INSERT [dbo].[WorkStationType] ([Id], [Name]) VALUES (2, N'PS5')
SET IDENTITY_INSERT [dbo].[WorkStationType] OFF
GO
ALTER TABLE [dbo].[BalanceReplenishment] ADD  CONSTRAINT [DF_BalanceReplenishment_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[BonusMoves] ADD  CONSTRAINT [DF_BonusMoves_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ClientsMemberships] ADD  CONSTRAINT [DF_ClientsMemberships_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[MembershipBuy] ADD  CONSTRAINT [DF_MembershipBuy_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Session] ADD  CONSTRAINT [DF_Session_StartTime]  DEFAULT (getdate()) FOR [StartTime]
GO
ALTER TABLE [dbo].[SessionPayment] ADD  CONSTRAINT [DF_SessionPayment_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[BalanceReplenishment]  WITH CHECK ADD  CONSTRAINT [FK_BalanceReplenishment_Client] FOREIGN KEY([Id_Client])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[BalanceReplenishment] CHECK CONSTRAINT [FK_BalanceReplenishment_Client]
GO
ALTER TABLE [dbo].[BalanceReplenishment]  WITH CHECK ADD  CONSTRAINT [FK_BalanceReplenishment_ReplenishmentType] FOREIGN KEY([ReplenishmentType])
REFERENCES [dbo].[ReplenishmentType] ([Id])
GO
ALTER TABLE [dbo].[BalanceReplenishment] CHECK CONSTRAINT [FK_BalanceReplenishment_ReplenishmentType]
GO
ALTER TABLE [dbo].[BonusMoves]  WITH CHECK ADD  CONSTRAINT [FK_BonusMoves_Client] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[BonusMoves] CHECK CONSTRAINT [FK_BonusMoves_Client]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_Client_LoyalityLevel] FOREIGN KEY([LoyalityLevel])
REFERENCES [dbo].[LoyalityLevel] ([Id])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_Client_LoyalityLevel]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_Client_User] FOREIGN KEY([Id_User])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_Client_User]
GO
ALTER TABLE [dbo].[ClientsMemberships]  WITH CHECK ADD  CONSTRAINT [FK_ClientsMemberships_MembershipBuy] FOREIGN KEY([Id_MembershipBuy])
REFERENCES [dbo].[MembershipBuy] ([Id])
GO
ALTER TABLE [dbo].[ClientsMemberships] CHECK CONSTRAINT [FK_ClientsMemberships_MembershipBuy]
GO
ALTER TABLE [dbo].[MembershipBuy]  WITH CHECK ADD  CONSTRAINT [FK_MembershipBuy_Client] FOREIGN KEY([Id_client])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[MembershipBuy] CHECK CONSTRAINT [FK_MembershipBuy_Client]
GO
ALTER TABLE [dbo].[MembershipBuy]  WITH CHECK ADD  CONSTRAINT [FK_MembershipBuy_Membership] FOREIGN KEY([Id_Membership])
REFERENCES [dbo].[Membership] ([Id])
GO
ALTER TABLE [dbo].[MembershipBuy] CHECK CONSTRAINT [FK_MembershipBuy_Membership]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_ReservationStatus] FOREIGN KEY([ReservationStatus])
REFERENCES [dbo].[ReservationStatus] ([Id])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_ReservationStatus]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Session] FOREIGN KEY([Id_Session])
REFERENCES [dbo].[Session] ([Id])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_Session]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_Client] FOREIGN KEY([Id_Client])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_Client]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_WorkStation] FOREIGN KEY([Id_WorkStation])
REFERENCES [dbo].[WorkStation] ([Id])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_WorkStation]
GO
ALTER TABLE [dbo].[SessionPayment]  WITH CHECK ADD  CONSTRAINT [FK_SessionPayment_BonusMoves] FOREIGN KEY([BonusesSpent])
REFERENCES [dbo].[BonusMoves] ([Id])
GO
ALTER TABLE [dbo].[SessionPayment] CHECK CONSTRAINT [FK_SessionPayment_BonusMoves]
GO
ALTER TABLE [dbo].[SessionPayment]  WITH CHECK ADD  CONSTRAINT [FK_SessionPayment_Session] FOREIGN KEY([Id_Session])
REFERENCES [dbo].[Session] ([Id])
GO
ALTER TABLE [dbo].[SessionPayment] CHECK CONSTRAINT [FK_SessionPayment_Session]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([Role])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
ALTER TABLE [dbo].[WorkStation]  WITH CHECK ADD  CONSTRAINT [FK_WorkStation_WorkStationStatus] FOREIGN KEY([Id_Status])
REFERENCES [dbo].[WorkStationStatus] ([Id])
GO
ALTER TABLE [dbo].[WorkStation] CHECK CONSTRAINT [FK_WorkStation_WorkStationStatus]
GO
ALTER TABLE [dbo].[WorkStation]  WITH CHECK ADD  CONSTRAINT [FK_WorkStation_WorkStationType] FOREIGN KEY([WorkStationType])
REFERENCES [dbo].[WorkStationType] ([Id])
GO
ALTER TABLE [dbo].[WorkStation] CHECK CONSTRAINT [FK_WorkStation_WorkStationType]
GO
USE [master]
GO
ALTER DATABASE [Bootcamp] SET  READ_WRITE 
GO
