USE [master]
GO
/****** Object:  Database [Zipline]    Script Date: 2020-11-30 11:46:22 AM ******/
CREATE DATABASE [Zipline]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Zipline', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Zipline.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Zipline_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Zipline_log.ldf' , SIZE = 20416KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Zipline] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Zipline].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Zipline] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Zipline] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Zipline] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Zipline] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Zipline] SET ARITHABORT OFF 
GO
ALTER DATABASE [Zipline] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Zipline] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Zipline] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Zipline] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Zipline] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Zipline] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Zipline] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Zipline] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Zipline] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Zipline] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Zipline] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Zipline] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Zipline] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Zipline] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Zipline] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Zipline] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Zipline] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Zipline] SET RECOVERY FULL 
GO
ALTER DATABASE [Zipline] SET  MULTI_USER 
GO
ALTER DATABASE [Zipline] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Zipline] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Zipline] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Zipline] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Zipline] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Zipline', N'ON'
GO
USE [Zipline]
GO
/****** Object:  UserDefinedFunction [dbo].[GET_TABLE_SEQUENCE]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GET_TABLE_SEQUENCE] (@SEQ_TYPE varchar(max), @pad TINYINT)
RETURNS VARCHAR(250)
AS BEGIN
    DECLARE @NumStr VARCHAR(250)
    DECLARE @BILL_NO BIGINT
    
    SET @BILL_NO =
    ( SELECT 
		[Sequence].SequenceNo 
	 FROM [Sequence] 
		WHERE 
		[Sequence].Type = @SEQ_TYPE
		AND [Sequence].ModuleId = 1
    )

	SET @BILL_NO = @BILL_NO + 1
	
	
    SET @NumStr = LTRIM(@BILL_NO)
    IF(@pad > LEN(@NumStr))
        SET @NumStr = REPLICATE('0', @Pad - LEN(@NumStr)) + @NumStr;

    RETURN @NumStr;
END

GO
/****** Object:  Table [dbo].[Agents]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agents](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[Address] [nvarchar](30) NULL,
	[ContactPerson] [nvarchar](30) NOT NULL,
	[Telephone] [varchar](20) NOT NULL,
	[CommissionPercentage] [decimal](18, 2) NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](128) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[vat_no] [varchar](250) NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Agent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApplicationLog]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationLog](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ErrorPage] [varchar](max) NULL,
	[ErrorMsg] [varchar](max) NULL,
	[ErrorDetails] [varchar](max) NULL,
	[IpAddress] [varchar](20) NULL,
	[Referer] [varchar](max) NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [pk_idx_ApplicationLog_id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
	[CreatedBy] [nvarchar](128) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRolesHistory]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRolesHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
	[CreatedBy] [nvarchar](128) NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRolesHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[PasswordDesk] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[IsActive] [bit] NULL,
	[SessionTimeOut] [varchar](3) NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NOT NULL,
	[Unit] [varchar](250) NOT NULL,
	[ShotName] [varchar](250) NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](128) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyInfo]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](50) NULL,
	[ContactNo] [int] NULL,
	[VatNo] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_CompanyInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Deductions]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Deductions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Deductions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Denomination]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Denomination](
	[Id] [int] IDENTITY(7,1) NOT NULL,
	[Rs1000] [decimal](18, 2) NOT NULL,
	[Rs500] [decimal](18, 2) NOT NULL,
	[Rs100] [decimal](18, 2) NOT NULL,
	[Rs50] [decimal](18, 2) NOT NULL,
	[Rs20] [decimal](18, 2) NOT NULL,
	[Rs10] [decimal](18, 2) NOT NULL,
	[Rs5] [decimal](18, 2) NOT NULL,
	[Coins] [decimal](18, 2) NOT NULL,
	[IC] [decimal](18, 2) NOT NULL,
	[FyId] [int] NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[SettlementRequest] [nvarchar](max) NOT NULL,
	[Impression] [nvarchar](max) NOT NULL,
	[SettledBy] [nvarchar](128) NULL,
	[Remarks] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_denomination_id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](5) NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](128) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [Department_PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Designation]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Designation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Designation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[District]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[District](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[NameEn] [varchar](25) NOT NULL,
	[NameNp] [nvarchar](50) NULL,
	[ProvinceId] [tinyint] NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Earnings]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Earnings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Earnings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeDetails]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[MiddleName] [varchar](30) NULL,
	[LastName] [varchar](30) NOT NULL,
	[Gender] [varchar](20) NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[Nationality] [varchar](20) NOT NULL,
	[DOB] [date] NULL,
	[MaritalStatus] [varchar](20) NULL,
	[Ethnicity] [varchar](30) NULL,
	[StateId] [int] NOT NULL,
	[DistrictId] [int] NOT NULL,
	[Address] [varchar](50) NOT NULL,
	[Email] [varchar](60) NULL,
	[BasicSalary] [varchar](20) NULL,
	[DepartmentId] [int] NULL,
	[Designation] [int] NULL,
	[StartDate] [date] NULL,
	[ProfilePath] [varchar](100) NULL,
	[ContractFile] [varchar](50) NULL,
	[BankName] [varchar](50) NULL,
	[BankBranch] [varchar](50) NULL,
	[AccountNo] [varchar](50) NULL,
	[AccountName] [varchar](50) NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](128) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
	[IsSuspended] [bit] NULL,
	[IsFired] [bit] NULL,
 CONSTRAINT [PK_EmployeeDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmploymentTypes]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmploymentTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_EmploymentTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FiscalYear]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FiscalYear](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShortName] [nvarchar](20) NOT NULL,
	[YearCode] [nvarchar](20) NOT NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](128) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_FiscalYear] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlyerInformation]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlyerInformation](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[ticket_no] [varchar](250) NULL,
	[has_video] [int] NULL,
	[zipline_package] [varchar](250) NULL,
	[ticket_id] [bigint] NULL,
	[full_name] [varchar](max) NULL,
	[mobile] [varchar](max) NULL,
	[social] [varchar](max) NULL,
	[dob] [date] NULL,
	[nationality] [varchar](max) NULL,
	[gender] [varchar](max) NULL,
	[address] [varchar](max) NULL,
	[emergency_contact] [varchar](max) NULL,
	[relationship] [varchar](max) NULL,
	[created_at] [datetime] NULL,
	[email] [varchar](max) NULL,
 CONSTRAINT [PK_FlyerInformation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobsHistory]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobsHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmpId] [int] NOT NULL,
	[DesignationId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[ShiftId] [int] NOT NULL,
	[EmploymentTypeId] [int] NOT NULL,
	[Salary] [varchar](20) NOT NULL,
	[OTRate] [varchar](20) NULL,
	[WorkingHR] [decimal](18, 2) NULL,
	[ContractExpiry] [date] NULL,
	[PaySchedule] [varchar](20) NULL,
	[IsCurrent] [bit] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[ModifyBy] [varchar](128) NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_JobsHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeaveApplications]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeaveApplications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Reason] [varchar](50) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[FromDate] [date] NOT NULL,
	[ToDate] [date] NOT NULL,
	[Remarks] [varchar](300) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_LeaveApplications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[online_booking]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[online_booking](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[booking_id] [bigint] NULL,
	[fullname] [varchar](max) NULL,
	[mobile_no] [varchar](50) NULL,
	[email] [varchar](max) NULL,
	[dob] [date] NULL,
	[address] [text] NULL,
	[zipline_type] [varchar](max) NULL,
	[emergency_contact] [varchar](max) NULL,
	[zipline_date] [date] NULL,
	[social_media_contact] [varchar](max) NULL,
	[nationality] [varchar](max) NULL,
	[gender] [varchar](50) NULL,
	[payment_method] [varchar](50) NULL,
	[relationship] [varchar](max) NULL,
	[know_about_us] [text] NULL,
	[note] [text] NULL,
	[created_at] [datetime] NULL,
 CONSTRAINT [PK_online_booking] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Package]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Package](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](250) NULL,
	[code] [varchar](50) NULL,
 CONSTRAINT [PK_Package] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Province]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Province](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[NameEn] [varchar](25) NOT NULL,
	[NameNp] [nvarchar](50) NULL,
	[ProvinceNo] [tinyint] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Province] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[CreatedBy] [nvarchar](30) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](30) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sequence]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sequence](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[ModuleId] [int] NULL,
	[SequenceNo] [int] NULL,
	[CreatedBy] [nvarchar](30) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](30) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Sequence] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaxType] [nvarchar](30) NOT NULL,
	[TaxPercentage] [decimal](18, 2) NULL,
	[Date] [datetime] NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shift]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shift](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Shift] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Station]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Station](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](128) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Station] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TicketDetail]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TicketId] [bigint] NOT NULL,
	[TicketNo] [varchar](max) NOT NULL,
	[TicketRateID] [bigint] NULL,
	[LocalTaxAmount] [money] NOT NULL,
	[VatAmount] [money] NOT NULL,
	[DiscountAmount] [money] NULL,
	[BaseRate] [money] NOT NULL,
	[TotalAfterTax] [money] NOT NULL,
	[Currency] [nvarchar](20) NOT NULL,
	[TicketValidity] [datetime] NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[BarCode] [nvarchar](50) NOT NULL,
	[TotalPrice] [money] NOT NULL,
	[BranchName] [nvarchar](30) NULL,
	[OneWay] [bit] NOT NULL,
	[TwoWay] [bit] NOT NULL,
	[CreatedBy] [nvarchar](30) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](30) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[has_video] [int] NULL,
	[exchnage_rate] [decimal](18, 2) NULL,
 CONSTRAINT [PK_TicketDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TicketRate]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketRate](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [bigint] NULL,
	[category_id] [bigint] NOT NULL,
	[name] [varchar](250) NOT NULL,
	[type_id] [bigint] NOT NULL,
	[package_id] [bigint] NULL,
	[Currency] [varchar](50) NOT NULL,
	[base_rate] [money] NOT NULL,
	[local_tax] [money] NOT NULL,
	[vat] [money] NOT NULL,
	[total] [money] NOT NULL,
	[round_of] [money] NOT NULL,
	[grand_total] [money] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](128) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TicketRate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[BillNo] [varchar](max) NULL,
	[BranchId] [int] NULL,
	[FY_ID] [bigint] NOT NULL,
	[PrintedDate] [datetime] NOT NULL,
	[LocalTaxPercentage] [decimal](18, 2) NULL,
	[VatPercentage] [decimal](18, 2) NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[PaymentMode] [varchar](50) NOT NULL,
	[AgentId] [bigint] NULL,
	[Description] [varchar](max) NULL,
	[RePrint] [int] NULL,
	[DiscountAmount] [money] NULL,
	[TaxableAmount] [money] NULL,
	[TotalLocalTax] [money] NULL,
	[TotalVatAmount] [money] NULL,
	[GrandTotal] [money] NULL,
	[OneWay] [bit] NULL,
	[TwoWay] [bit] NULL,
	[CustomerVatNo] [int] NULL,
	[CustomerName] [varchar](max) NULL,
	[Currency] [varchar](max) NULL,
	[TicketFrom] [bigint] NULL,
	[CreatedBy] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](max) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[exchange_rate] [decimal](18, 2) NULL,
	[round_off] [decimal](18, 2) NULL,
	[pay_via] [varchar](250) NULL,
	[pay_code] [varchar](250) NULL,
	[credit_customer] [varchar](250) NULL,
	[credit_phone] [varchar](250) NULL,
	[Status] [smallint] NOT NULL,
 CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Type]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](250) NOT NULL,
	[ShortName] [varchar](250) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](30) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TicketType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[EmployeeId] [int] NULL,
	[PhoneNumber] [varchar](15) NULL,
	[Mobile] [varchar](15) NULL,
	[FirstName] [nvarchar](15) NOT NULL,
	[MiddleName] [nvarchar](15) NULL,
	[LastName] [nvarchar](15) NOT NULL,
	[Gender] [nvarchar](8) NULL,
	[DOB] [date] NULL,
	[State] [tinyint] NULL,
	[VDCMunc] [smallint] NULL,
	[District] [tinyint] NULL,
	[City] [nvarchar](50) NULL,
	[Address] [nvarchar](200) NULL,
	[WardNo] [tinyint] NULL,
 CONSTRAINT [PK_dbo.UserProfile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](250) NOT NULL,
	[Password] [varchar](250) NULL,
	[Role] [int] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [bigint] NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[IsBlocked] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkingPoints]    Script Date: 2020-11-30 11:46:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkingPoints](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](20) NULL,
	[Name] [varchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_WorkingPoints] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Agents] ON 

INSERT [dbo].[Agents] ([Id], [Name], [Address], [ContactPerson], [Telephone], [CommissionPercentage], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [vat_no], [IsDeleted]) VALUES (7, N'Anapurna Incounter', N'Thamel', N'm', N'989', CAST(20.00 AS Decimal(18, 2)), N'1', CAST(N'2019-11-28T00:00:00.000' AS DateTime), N'1', CAST(N'2019-11-28T00:00:00.000' AS DateTime), 1, N'6068444', NULL)
INSERT [dbo].[Agents] ([Id], [Name], [Address], [ContactPerson], [Telephone], [CommissionPercentage], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [vat_no], [IsDeleted]) VALUES (9, N'Sasto Ticket', N'Hattisar', N'm', N'989', CAST(15.00 AS Decimal(18, 2)), N'1', CAST(N'2019-12-08T00:00:00.000' AS DateTime), N'1', CAST(N'2019-12-08T00:00:00.000' AS DateTime), 1, N'6068444', NULL)
INSERT [dbo].[Agents] ([Id], [Name], [Address], [ContactPerson], [Telephone], [CommissionPercentage], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [vat_no], [IsDeleted]) VALUES (13, N'Sajilo Trips', N'Kathamndu', N'm1', N'989', CAST(15.00 AS Decimal(18, 2)), N'1', CAST(N'2019-12-08T00:00:00.000' AS DateTime), N'Admin', CAST(N'2020-01-18T11:33:44.240' AS DateTime), 1, N'6068444', NULL)
INSERT [dbo].[Agents] ([Id], [Name], [Address], [ContactPerson], [Telephone], [CommissionPercentage], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [vat_no], [IsDeleted]) VALUES (15, N'Sunrise1', N'bnp1', N'NA', N'121211', CAST(1.20 AS Decimal(18, 2)), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-09-21T11:52:22.320' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-09-21T12:10:39.193' AS DateTime), 0, N'121', NULL)
SET IDENTITY_INSERT [dbo].[Agents] OFF
SET IDENTITY_INSERT [dbo].[ApplicationLog] ON 

INSERT [dbo].[ApplicationLog] ([Id], [ErrorPage], [ErrorMsg], [ErrorDetails], [IpAddress], [Referer], [CreatedBy], [CreatedDate]) VALUES (20197, N'''http://localhost:1251/HRManagement/PaySlip/Create''', N'''D:\Projects\Sofwena\Sofwena-ERP\ERP1\ERP.Web\Areas\HRManagement\Views\PaySlip\Create.cshtml(17): error CS1061: PaySlip does not contain a definition for Name and no extension method Name accepting a first argument of type PaySlip could be found (are you missing a using directive or an assembly reference?)''', N'http://localhost:1251/Account/Login?ReturnUrl=%2fHRManagement%2fPaySlip%2fCreate', N'::1', N'', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-27T13:10:03.430' AS DateTime))
INSERT [dbo].[ApplicationLog] ([Id], [ErrorPage], [ErrorMsg], [ErrorDetails], [IpAddress], [Referer], [CreatedBy], [CreatedDate]) VALUES (20198, N'''http://localhost:1251/HRManagement/PaySlip/Create''', N'''D:\Projects\Sofwena\Sofwena-ERP\ERP1\ERP.Web\Areas\HRManagement\Views\PaySlip\Create.cshtml(17): error CS1061: PaySlip does not contain a definition for Name and no extension method Name accepting a first argument of type PaySlip could be found (are you missing a using directive or an assembly reference?)''', N'http://localhost:1251/HRManagement/PaySlip', N'::1', N'', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-27T13:10:36.150' AS DateTime))
INSERT [dbo].[ApplicationLog] ([Id], [ErrorPage], [ErrorMsg], [ErrorDetails], [IpAddress], [Referer], [CreatedBy], [CreatedDate]) VALUES (20199, N'''http://localhost:1251/HRManagement/PaySlip/Create''', N'''D:\Projects\Sofwena\Sofwena-ERP\ERP1\ERP.Web\Areas\HRManagement\Views\PaySlip\Create.cshtml(17): error CS1061: PaySlip does not contain a definition for Name and no extension method Name accepting a first argument of type PaySlip could be found (are you missing a using directive or an assembly reference?)''', N'http://localhost:1251/HRManagement/PaySlip', N'::1', N'', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-27T13:10:36.393' AS DateTime))
INSERT [dbo].[ApplicationLog] ([Id], [ErrorPage], [ErrorMsg], [ErrorDetails], [IpAddress], [Referer], [CreatedBy], [CreatedDate]) VALUES (20200, N'''http://localhost:1251/HRManagement/PaySlip/Create''', N'''D:\Projects\Sofwena\Sofwena-ERP\ERP1\ERP.Web\Areas\HRManagement\Views\PaySlip\Create.cshtml(30): error CS1061: PaySlip does not contain a definition for BMonth and no extension method BMonth accepting a first argument of type PaySlip could be found (are you missing a using directive or an assembly reference?)''', N'http://localhost:1251/HRManagement/PaySlip', N'::1', N'', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-27T13:38:29.123' AS DateTime))
INSERT [dbo].[ApplicationLog] ([Id], [ErrorPage], [ErrorMsg], [ErrorDetails], [IpAddress], [Referer], [CreatedBy], [CreatedDate]) VALUES (20201, N'''http://localhost:1251/HRManagement/PaySlip/Create''', N'''D:\Projects\Sofwena\Sofwena-ERP\ERP1\ERP.Web\Areas\HRManagement\Views\PaySlip\Create.cshtml(30): error CS1061: PaySlip does not contain a definition for BMonth and no extension method BMonth accepting a first argument of type PaySlip could be found (are you missing a using directive or an assembly reference?)''', N'http://localhost:1251/HRManagement/PaySlip', N'::1', N'', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-27T13:38:30.273' AS DateTime))
INSERT [dbo].[ApplicationLog] ([Id], [ErrorPage], [ErrorMsg], [ErrorDetails], [IpAddress], [Referer], [CreatedBy], [CreatedDate]) VALUES (20202, N'''http://localhost:1251/HRManagement/''', N'''The controller for path /HRManagement/ was not found or does not implement IController.''', NULL, N'::1', N'', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-27T14:13:16.417' AS DateTime))
INSERT [dbo].[ApplicationLog] ([Id], [ErrorPage], [ErrorMsg], [ErrorDetails], [IpAddress], [Referer], [CreatedBy], [CreatedDate]) VALUES (20203, N'''http://localhost:1251/HRManagement/Payslips''', N'''The controller for path /HRManagement/Payslips was not found or does not implement IController.''', N'', N'::1', N'', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-28T11:20:01.547' AS DateTime))
INSERT [dbo].[ApplicationLog] ([Id], [ErrorPage], [ErrorMsg], [ErrorDetails], [IpAddress], [Referer], [CreatedBy], [CreatedDate]) VALUES (20204, N'''http://localhost:1251/HRManagement/PaySlip/slipDetails''', N'''There is no ViewData item of type IEnumerable<SelectListItem> that has the key Earnings.''', N'http://localhost:1251/HRManagement/PaySlip', N'::1', N'', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-28T19:28:31.947' AS DateTime))
INSERT [dbo].[ApplicationLog] ([Id], [ErrorPage], [ErrorMsg], [ErrorDetails], [IpAddress], [Referer], [CreatedBy], [CreatedDate]) VALUES (20205, N'''http://localhost:1251/HRManagement/PaySlip/slipDetails''', N'''There is no ViewData item of type IEnumerable<SelectListItem> that has the key Earnings.''', N'http://localhost:1251/HRManagement/PaySlip', N'::1', N'', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-28T19:28:33.800' AS DateTime))
INSERT [dbo].[ApplicationLog] ([Id], [ErrorPage], [ErrorMsg], [ErrorDetails], [IpAddress], [Referer], [CreatedBy], [CreatedDate]) VALUES (20206, N'''http://localhost:1251/Account/LogOff''', N'''The view LogOff or its master was not found or no view engine supports the searched locations. The following locations were searched:
~/Views/Account/LogOff.cshtml
~/Views/Shared/LogOff.cshtml''', N'http://localhost:1251/TicketingManagement/Package', N'::1', N'', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-11-04T15:40:00.073' AS DateTime))
SET IDENTITY_INSERT [dbo].[ApplicationLog] OFF
INSERT [dbo].[AspNetRoles] ([Id], [Name], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (N'0ec2c77376864901a0edcb28f3227d02', N'Super Admin', N'admin', CAST(N'2018-04-03T12:08:56.150' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (N'6e228195135c48629991b4bd5a2dd87b', N'HR', N'admin', CAST(N'2020-09-01T00:00:00.000' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (N'6e228195135c48629991b4bd5a2dd88a', N'Admin', N'admin', CAST(N'2018-04-03T12:08:56.150' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (N'6e228195135c48629991b4bd5a2dd88b', N'Ticketing', N'admin', CAST(N'2020-04-12T00:00:00.000' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId], [CreatedBy], [CreatedDate]) VALUES (N'4e20c47b-795f-4fc9-9d09-b1365e544b75', N'6e228195135c48629991b4bd5a2dd88b', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-07T17:35:19.967' AS DateTime))
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId], [CreatedBy], [CreatedDate]) VALUES (N'fff867aa-491a-4124-bb05-4c03394e7a4f', N'0ec2c77376864901a0edcb28f3227d02', NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [PasswordDesk], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted], [IsActive], [SessionTimeOut]) VALUES (N'4e20c47b-795f-4fc9-9d09-b1365e544b75', N'jarusdeuja@gmail.com', 0, N'AKFSIW1lM3QPPzTyOY44N5zgXQLgJxZxTNE7GKc/jYjgAsVbmMONUFY5vQ1wWOHNTg==', N'0ABD0DF55EB02D47BF2D3E301D3310C4D084E10B', N'7d43d404-9c89-4847-b8f6-780687a5ccd7', N'9845578643', 0, 0, NULL, 1, 0, N'Suraj', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-06T17:00:53.153' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-07T17:35:19.963' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [PasswordDesk], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted], [IsActive], [SessionTimeOut]) VALUES (N'fff867aa-491a-4124-bb05-4c03394e7a4f', N'admin@admin.com', 0, N'AIk7LuuGsMzXsxl3g8TK2z1YAFj0mffpH9AG5+4JYPFqaMwrs1b+0qMdTQCt3Eyh2w==', N'0ABD0DF55EB02D47BF2D3E301D3310C4D084E10B', N'5edc8c48-8085-4cd6-9d54-5a0245691506', NULL, 0, 0, NULL, 1, 0, N'admin@admin.com', NULL, NULL, N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2018-04-24T16:26:44.740' AS DateTime), NULL, NULL, N'400')
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name], [Unit], [ShotName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (1015, N'BRIDGE CROSS', N'PAX', N'B', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T10:53:16.237' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:14:21.650' AS DateTime), 1, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Unit], [ShotName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (1016, N'INDIVIDUAL', N'PAX', N'IND', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T10:53:44.393' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:14:46.583' AS DateTime), 1, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Unit], [ShotName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (1017, N'DUO', N'PAX', N'D', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T10:53:55.823' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:14:57.223' AS DateTime), 1, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Unit], [ShotName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (1018, N'ACTIVITY ONLY', N'PAX', N'AO', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T10:54:10.453' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:15:16.917' AS DateTime), 1, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Unit], [ShotName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (1019, N'GIANT PING', N'PAX', N'GP', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:15:31.853' AS DateTime), NULL, NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[CompanyInfo] ON 

INSERT [dbo].[CompanyInfo] ([Id], [Name], [Address], [ContactNo], [VatNo], [IsActive]) VALUES (1, N'The Cliff Pvt. Ltd.', N'Kusma, Parbat', 123456, N'601649400', 1)
SET IDENTITY_INSERT [dbo].[CompanyInfo] OFF
SET IDENTITY_INSERT [dbo].[Deductions] ON 

INSERT [dbo].[Deductions] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (1, N'TAX', 1, 0)
INSERT [dbo].[Deductions] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (2, N'SSF1', 0, 1)
INSERT [dbo].[Deductions] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (4, N'SSF', 1, 0)
INSERT [dbo].[Deductions] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (5, N'test', 1, 1)
INSERT [dbo].[Deductions] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (6, N'del', 1, 1)
INSERT [dbo].[Deductions] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (7, N'asa', 1, 1)
INSERT [dbo].[Deductions] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (8, N'fgh', 1, 0)
SET IDENTITY_INSERT [dbo].[Deductions] OFF
SET IDENTITY_INSERT [dbo].[Denomination] ON 

INSERT [dbo].[Denomination] ([Id], [Rs1000], [Rs500], [Rs100], [Rs50], [Rs20], [Rs10], [Rs5], [Coins], [IC], [FyId], [UserId], [SettlementRequest], [Impression], [SettledBy], [Remarks], [Status], [CreatedDate]) VALUES (9, CAST(1.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'test', N'test', N'fff867aa-491a-4124-bb05-4c03394e7a4f', N'asasa', 1, CAST(N'2020-09-24T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Denomination] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([Id], [Code], [Name], [Description], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1, N'001', N'Management', NULL, N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-09-21T10:29:16.130' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Department] ([Id], [Code], [Name], [Description], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1002, N'002', N'Ticketing', NULL, N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-04T17:53:00.423' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Department] ([Id], [Code], [Name], [Description], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1005, N'003', N'Restaurant', NULL, N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-08T16:50:51.737' AS DateTime), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[Designation] ON 

INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (3, N'IT Operator', 1, 0)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (5, N'Cashier', 1, 0)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (9, N'Ch', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (10, N'asa', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (11, N'asda', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (12, N'dsds', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (13, N'fgfgf', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (14, N'gh', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (15, N'ty', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (16, N'dsfdsf', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (17, N'sdsds', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (18, N'sdsdq', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (19, N'dfd', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (20, N'fd` ', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (21, N'xczc', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (22, N'hjk', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (23, N'fghjkl', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (24, N'uj', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (25, N'sdsdas ', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (26, N'iii', 0, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (27, N'olo', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (28, N'okk', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (29, N'fdo', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (30, N'dfdfd', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (31, N'cxc', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (32, N'ij', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (33, N'jk', 0, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (34, N'sds', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (35, N'fdf', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (36, N'fdfs', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (37, N'fdfsd', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (38, N'jh', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (39, N'jhsd', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (40, N'jhsddfd', 0, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (41, N'sssd', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (42, N'ddfdf', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (43, N'ddfdfsdsd', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (44, N'yt', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (45, N'yt2', 0, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (46, N'yt26', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (47, N'asaa', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (48, N'asaasasa', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (49, N'kk', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (50, N'bn', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (51, N'fgfgfg', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (52, N'fgffghe', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (53, N'fgfgfgfgfgf', 0, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (54, N'asas', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (55, N'asasas', 1, 1)
INSERT [dbo].[Designation] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (56, N'ddd', 1, 1)
SET IDENTITY_INSERT [dbo].[Designation] OFF
SET IDENTITY_INSERT [dbo].[District] ON 

INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (1, N'TAPLEJUNG', N'ताप्लेजुङ', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, N'admin', CAST(N'2018-03-16T14:45:22.743' AS DateTime))
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (2, N'PANCHTHAR', N'पाँचथर', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, N'Admin', CAST(N'2018-03-13T16:40:55.793' AS DateTime))
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (3, N'ILAM', N'इलाम', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (4, N'SANKHUWASABHA', N'संखुवासभा', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (5, N'TERHATHUM', N'तेह्रथुम', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (6, N'DHANKUTA', N'धनकुटा', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (7, N'BHOJPUR', N'भोजपुर', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (8, N'KHOTANG', N'खोटाङ', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (9, N'SOLUKHUMBU', N'सोलुखुम्बु', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (10, N'OKHALDHUNGA', N'ओखलढुङ्गा', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (11, N'UDAYAPUR', N'उदयपुर', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (12, N'JHAPA', N'झापा', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, N'admin', CAST(N'2018-03-16T16:20:49.340' AS DateTime))
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (13, N'MORANG', N'मोरङ', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (14, N'SUNSARI', N'सुनसरी', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (15, N'SAPTARI', N'सप्तरी', 2, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (16, N'SIRAHA', N'सिरहा', 2, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (17, N'DHANUSA', N'धनुषा', 2, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (18, N'MAHOTTARI', N'महोत्तरी', 2, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (19, N'SARLAHI', N'सर्लाही', 2, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (20, N'RAUTAHAT ', N'रौतहट', 2, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (21, N'BARA', N'बारा', 2, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (22, N'PARSA', N'पर्सा', 2, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (23, N'DOLAKHA', N'दोलखा', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (24, N'RAMECHHAP', N'रामेछाप', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (25, N'SINDHULI', N'सिन्धुली', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (26, N'KAVREPALANCHOK', N'काभ्रेपलाञ्चोक', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (27, N'SINDHUPALCHOK', N'सिन्धुपाल्चोक', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (28, N'RASUWA', N'रसुवा', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (29, N'NUWAKOT', N'नुवाकोट', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (30, N'DHADING', N'धादिङ', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (31, N'CHITAWAN', N'चितवन', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (32, N'MAKWANPUR', N'मकवानपुर', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (33, N'BHAKTAPUR', N'भक्तपुर', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (34, N'LALITPUR', N'ललितपुर', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (35, N'KATHMANDU', N'काठमाडौँ', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (36, N'GORKHA', N'गोरखा', 4, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (37, N'LAMJUNG', N'लमजुङ', 4, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (38, N'TANAHU', N'तनहुँ', 4, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (39, N'KASKI', N'कास्की', 4, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (40, N'MANANG', N'मनाङ', 4, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (41, N'MUSTANG', N'मुस्ताङ', 4, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (42, N'PARBAT', N'पर्वत', 4, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (43, N'SYANGJA', N'स्याङजा', 4, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (44, N'MYAGDI', N'म्याग्दी', 4, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (45, N'BAGLUNG', N'बागलुङ', 4, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (46, N'NAWALPARASI EAST', N'नवलपरासी (बर्दघाट सुस्ता पूर्व)', 4, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, N'Admin', CAST(N'2018-03-13T16:44:24.487' AS DateTime))
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (47, N'NAWALPARASI WEST', N'नवलपरासी (बर्दघाट सुस्ता पश्चिम)', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (48, N'RUPANDEHI', N'रुपन्देही', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (49, N'KAPILBASTU', N'कपिलवस्तु', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (50, N'PALPA', N'पाल्पा', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (51, N'ARGHAKHANCHI', N'अर्घाखाँची', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (52, N'GULMI', N'गुल्मी', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (53, N'RUKUM EAST', N'रुकुम (पूर्वी भाग)', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (54, N'ROLPA', N'रोल्पा', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (55, N'PYUTHAN', N'प्यूठान', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (56, N'DANG', N'दाङ', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (57, N'BANKE', N'बाँके', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (58, N'BARDIYA', N'बर्दिया', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (59, N'RUKUM WEST', N'रुकुम (पश्चिम भाग)', 6, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (60, N'SALYAN', N'सल्यान', 6, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (61, N'DOLPA', N'डोल्पा', 6, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (62, N'JUMLA', N'जुम्ला', 6, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (63, N'MUGU', N'मुगु', 6, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (64, N'HUMLA', N'हुम्ला', 6, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (65, N'KALIKOT', N'कालिकोट', 6, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (66, N'JAJARKOT', N'जाजरकोट', 6, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (67, N'DAILEKH', N'दैलेख', 6, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (68, N'SURKHET', N'सुर्खेत', 6, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (69, N'BAJURA', N'बाजुरा', 7, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (70, N'BAJHANG', N'बझाङ', 7, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (71, N'DOTI', N'डोटी', 7, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (72, N'ACHHAM', N'अछाम', 7, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (73, N'DARCHULA', N'दार्चुला', 7, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (74, N'BAITADI', N'बैतडी', 7, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (75, N'DADELDHURA', N'डँडेलधुरा', 7, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (76, N'KANCHANPUR', N'कञ्चनपुर', 7, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[District] ([Id], [NameEn], [NameNp], [ProvinceId], [CreatedBy], [CreatedDate], [IsActive], [IsDeleted], [ModifiedBy], [ModifiedDate]) VALUES (77, N'KAILALI', N'कैलाली', 7, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), 1, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[District] OFF
SET IDENTITY_INSERT [dbo].[Earnings] ON 

INSERT [dbo].[Earnings] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (1, N'Incentive 1', 1, 1)
INSERT [dbo].[Earnings] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (2, N'Dashain Bonus', 1, 0)
INSERT [dbo].[Earnings] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (3, N'test', 1, 0)
INSERT [dbo].[Earnings] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (4, N'de', 1, 1)
SET IDENTITY_INSERT [dbo].[Earnings] OFF
SET IDENTITY_INSERT [dbo].[EmployeeDetails] ON 

INSERT [dbo].[EmployeeDetails] ([Id], [FirstName], [MiddleName], [LastName], [Gender], [Phone], [Nationality], [DOB], [MaritalStatus], [Ethnicity], [StateId], [DistrictId], [Address], [Email], [BasicSalary], [DepartmentId], [Designation], [StartDate], [ProfilePath], [ContractFile], [BankName], [BankBranch], [AccountNo], [AccountName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsSuspended], [IsFired]) VALUES (16, N'Suraj', NULL, N'Deuja', N'Male', N'9845578643', N'Nepali', CAST(N'2016-10-30' AS Date), N'Single', N'Hindu', 3, 26, N'Banepa', NULL, N'12000', 1002, 3, CAST(N'2020-10-31' AS Date), N'p_06152020_16Capture.jpg', N'_06072020_16p2.pdf', NULL, NULL, NULL, NULL, N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-06T13:31:07.863' AS DateTime), NULL, NULL, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[EmployeeDetails] OFF
SET IDENTITY_INSERT [dbo].[EmploymentTypes] ON 

INSERT [dbo].[EmploymentTypes] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (1, N'Full Time ', 1, 0)
INSERT [dbo].[EmploymentTypes] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (2, N'Part Time', 1, 0)
INSERT [dbo].[EmploymentTypes] ([Id], [Name], [IsActive], [IsDeleted]) VALUES (3, N'Internship', 1, 0)
SET IDENTITY_INSERT [dbo].[EmploymentTypes] OFF
SET IDENTITY_INSERT [dbo].[FiscalYear] ON 

INSERT [dbo].[FiscalYear] ([Id], [ShortName], [YearCode], [StartDate], [EndDate], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (7, N'7778', N'77-78', CAST(N'2020-09-20T00:00:00.000' AS DateTime), CAST(N'2020-09-20T00:00:00.000' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-09-20T13:23:55.940' AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[FiscalYear] OFF
SET IDENTITY_INSERT [dbo].[FlyerInformation] ON 

INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (55, N'ZT1767725', 1, N'Normal Superman', 64, N'aa', N'2', N'22', CAST(N'1900-01-01' AS Date), N'Nepali', N'Female', N'2', N'2', N'', CAST(N'2020-01-08T11:39:07.243' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (56, N'ZT1767727', 1, N'Normal Classic', 66, N'gg', N'456', N'76', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'nm', N'676', N'', CAST(N'2020-01-10T15:55:23.817' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (57, N'ZT1767728', 1, N'Normal Classic', 68, N'tf', N'66', N'3', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'fghj', N'43', N'', CAST(N'2020-01-10T15:59:16.780' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (58, N'ZT1767731', 1, N'Normal Classic', 70, N'gg', N'66', N'4', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'v', N'5', N'', CAST(N'2020-01-10T16:02:57.273' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (59, N'ZT1767732', 1, N'Normal Classic', 71, N'fghj', N'5667', N'5678', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'fghj', N'4567', N'', CAST(N'2020-01-11T14:11:59.150' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (60, N'ZT1767734', 1, N'Normal Superman', 73, N'tgb', N'1234', N'123', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'123', N'123', N'', CAST(N'2020-01-11T14:21:05.827' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (61, N'ZT1767736', 1, N'Normal Tendam', 75, N'qwerty', N'123', N'123', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'', N'123', N'', CAST(N'2020-01-11T14:24:52.367' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (62, N'ZT1767738', 1, N'Normal Superman', 77, N'asdf', N'12345', N'123', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'34', N'123', N'', CAST(N'2020-01-11T14:42:52.470' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (63, N'ZT1767739', 1, N'Normal Tendam', 78, N'ff', N'456', N'456', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'3', N'34', N'', CAST(N'2020-01-11T14:51:19.970' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (64, N'ZT1767740', 1, N'Normal Tendam', 79, N'tf', N'tf', N'345', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'345', N'345', N'', CAST(N'2020-01-11T14:52:58.640' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (65, N'ZT1767742', 1, N'Normal Superman', 81, N'fghj', N'3456', N'567', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'5678', N'456', N'', CAST(N'2020-01-11T14:59:02.697' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (66, N'ZT1767743', 1, N'Normal Tendam', 82, N'fghj', N'23456', N'2345', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'345', N'234', N'', CAST(N'2020-01-11T15:00:43.740' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (67, N'ZT1767745', 0, N'Normal Superman', 84, N'com', N'56789', N'678', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'789', N'78', N'', CAST(N'2020-01-19T08:22:34.703' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (68, N'ZT1767746', 0, N'Normal Superman', 85, N'ghjk', N'5678', N'hj', CAST(N'1900-01-01' AS Date), N'Nepali', N'Female', N'890', N'7890', N'', CAST(N'2020-01-19T08:23:06.773' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (69, N'ZT1767747', 0, N'Normal Classic', 86, N'ghjk', N'hjk', N'89', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'6789', N'789', N'', CAST(N'2020-01-19T08:27:03.863' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (70, N'ZT1767748', 0, N'Normal Classic', 87, N'ertyui', N'90', N'5678', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'hjkl', N'567890', N'', CAST(N'2020-01-19T13:23:28.633' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (71, N'ZT1767749', 0, N'Normal Classic', 88, N'test', N'345678', N'123', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'23456', N'1234', N'', CAST(N'2020-01-19T13:25:34.810' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (72, N'ZT1767750', 0, N'Normal Classic', 89, N'suraj', N'1234', N'1234', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'234567', N'123456', N'', CAST(N'2020-01-19T13:28:53.490' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (73, N'ZT17677151', 0, N'SAARC Classic', 90, N'saarc', N'1234', N'123', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'saarc', N'234', N'', CAST(N'2020-01-20T11:41:10.237' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (74, N'ZT17677152', 0, N'SAARC Classic', 91, N'sar', N'234', N'123', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'234', N'234', N'', CAST(N'2020-01-20T11:59:16.760' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (75, N'ZT17677153', 0, N'SAARC Classic', 92, N'tf', N'1234', N'123', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'1234', N'234', N'', CAST(N'2020-01-20T12:12:45.327' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (76, N'ZT17677154', 0, N'SAARC Superman', 93, N'hjk', N'12345', N'rtyu', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'tyuio', N'rtyui', N'', CAST(N'2020-01-20T12:51:17.153' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (77, N'ZT17677155', 0, N'Normal Classic', 94, N'solo', N'99', N'888', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'888', N'888', N'', CAST(N'2020-02-10T19:48:31.127' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (78, N'ZT17677157', 0, N'Normal Classic', 96, N'f', N'dfghj', N'4', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'', N'44', N'', CAST(N'2020-02-10T20:04:56.993' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (79, N'ZT17677158', 0, N'Normal Classic', 97, N'dfg', N'456', N'65', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'', N'3', N'', CAST(N'2020-02-10T20:06:40.933' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (80, N'ZT17677159', 0, N'Normal Classic', 98, N'ff', N'456', N'33', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'', N'23', N'', CAST(N'2020-02-10T20:09:53.153' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (81, N'ZT17677159', 1, N'Normal Classic', 99, N'bnm,', N'678io', N'789', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'', N'567890', N'', CAST(N'2020-02-10T20:13:02.070' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (82, N'ZT17677161', 0, N'Normal Classic', 100, N'tt', N'4444', N'44', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'44', N'44', N'', CAST(N'2020-02-10T20:17:18.460' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (83, N'ZT17677162', 1, N'Normal Classic', 102, N'yt', N'1234', N'23', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'', N'123', N'', CAST(N'2020-02-10T20:33:58.573' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (84, N'ZT17677165', 0, N'Normal Superman', 104, N'1', N'111', N'211', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'', N'21', N'', CAST(N'2020-02-10T20:36:20.123' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (85, N'ZT17677166', 0, N'Normal Classic', 105, N'suraj', N'98', N'98', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'98', N'98', N'', CAST(N'2020-02-11T10:05:47.123' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (86, N'ZT17677167', 0, N'Normal Classic', 106, N'rr', N'98', N'98', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'', N'988', N'', CAST(N'2020-02-11T10:14:56.900' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (87, N'ZT17677168', 0, N'Normal Classic', 107, N'hjhj', N'788', N'989', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'989', N'989', N'', CAST(N'2020-02-11T10:38:17.570' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (88, N'ZT17677169', 1, N'Normal Classic', 109, N'jd', N'11', N'909', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'', N'898', N'', CAST(N'2020-02-14T09:50:33.443' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (89, N'ZT17677173', 0, N'Normal Classic', 1111, N'gfg', N'657', N'768', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'gh', N'676', N'', CAST(N'2020-03-12T14:38:52.747' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (90, N'ZT17677174', 1, N'Normal Classic', 1113, N'te', N'55', N'65', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'hh', N'666', N'', CAST(N'2020-03-12T14:42:01.807' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (91, N'ZT17677176', 0, N'Normal Classic', 1114, N'h', N'7', N'77', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'', N'88', N'', CAST(N'2020-03-12T14:50:13.230' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (92, N'ZT1767777', 1, N'Normal Classic', 1116, N'te', N'56', N'56', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'56', N'56', N'', CAST(N'2020-03-14T10:59:56.117' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (93, N'ZT1767779', 1, N'Normal Classic', 1118, N'yg', N'66', N'78', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'88', N'78', N'', CAST(N'2020-03-14T11:06:27.950' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (94, N'ZT1767781', 1, N'Normal Classic', 1120, N'hhH', N'77', N'65', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'65', N'65', N'', CAST(N'2020-03-14T11:07:58.790' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (95, N'ZT1767783', 1, N'Normal Classic', 1122, N'jj', N'88', N'777', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'777', N'777', N'', CAST(N'2020-03-14T11:18:41.863' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (96, N'ZT1767785', 1, N'Normal Classic', 1124, N'hh', N'777', N'888', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'88', N'888', N'', CAST(N'2020-03-14T11:58:45.960' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (97, N'ZT1767787', 1, N'Normal Classic', 1126, N'y', N'666', N'777', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'7777', N'7777', N'', CAST(N'2020-03-14T18:26:28.823' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (98, N'ZT1767789', 0, N'Normal Classic', 1127, N'hh', N'666', N'666', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'666', N'666', N'', CAST(N'2020-03-14T20:40:45.723' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (99, N'ZT1767791', 0, N'Normal Superman', 1129, N't', N'7', N'7', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'7', N'7', N'', CAST(N'2020-03-14T22:17:50.230' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (100, N'ZT1767792', 0, N'Normal Classic', 1130, N'f', N'f', N'3', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'3', N'3', N'', CAST(N'2020-03-14T22:43:41.627' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (101, N'ZT1767794', 0, N'Normal Classic', 1132, N'tt', N'55', N'555', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'5', N'55', N'', CAST(N'2020-03-14T23:03:38.810' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (102, N'ZT1767796', 0, N'Normal Classic', 1134, N'h', N'7', N'777', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'888', N'888', N'', CAST(N'2020-03-14T23:09:06.530' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (103, N'ZT1767798', 0, N'Normal Classic', 1136, N'u', N'888', N'77', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'88', N'888', N'', CAST(N'2020-03-14T23:42:03.163' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (104, N'ZT17677106', 0, N'Normal Classic', 1144, N'e', N'1', N'44', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'444', N'44', N'', CAST(N'2020-03-14T23:59:13.473' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (105, N'ZT17677135', 1, N'Normal Classic', 1175, N'j', N'00', N'89', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'98', N'898', N'', CAST(N'2020-03-15T00:38:38.143' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (106, N'ZT17677143', 1, N'Normal Classic', 1183, N'kk', N'77', N'gg', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'7', N'77', N'', CAST(N'2020-03-15T00:44:56.583' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (107, N'ZT17677148', 0, N'Normal Classic', 1188, N'ty', N'55', N'65', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'65', N'65', N'', CAST(N'2020-03-15T08:17:28.550' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (108, N'ZT17677154', 1, N'Normal Superman', 1195, N'bh', N'bh', N'65', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'54', N'44', N'', CAST(N'2020-03-15T08:40:55.517' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (109, N'ZT17677161', 1, N'Normal Classic', 1202, N'TT', N'55', N'556', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'444', N'654', N'', CAST(N'2020-03-15T10:34:19.777' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (110, N'ZT17677165', 1, N'Normal Superman', 1204, N'jj', N'77', N'778', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'878', N'787', N'', CAST(N'2020-03-15T11:02:59.807' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (111, N'ZT17677167', 1, N'Normal Classic', 1206, N'uuu', N'ii', N'k', CAST(N'1900-01-01' AS Date), N'Nepali', N'Other', N'99', N'99', N'', CAST(N'2020-03-15T11:28:21.540' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (112, N'ZT17677177', 1, N'Normal Classic', 1218, N'hh', N'33', N'54', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'hg', N'54', N'', CAST(N'2020-03-15T11:56:31.987' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (113, N'ZT17677183', 1, N'Normal Classic', 1224, N'ff', N'43', N'345', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'gfgf', N'43', N'', CAST(N'2020-03-15T12:02:22.733' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (114, N'ZT17677187', 1, N'Normal Superman', 1228, N'v', N'55', N'gg', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'ggg', N'66', N'', CAST(N'2020-03-15T12:04:34.283' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (115, N'ZT17677188', 1, N'Normal Superman', 1228, N'v', N'55', N'gg', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'ggg', N'66', N'', CAST(N'2020-03-15T12:04:36.673' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (116, N'ZT17677191', 0, N'Normal Superman', 1232, N'h', N'4', N'76', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'dfg', N'3', N'', CAST(N'2020-03-15T12:08:36.563' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (117, N'ZT17677192', 0, N'Normal Superman', 1232, N'h', N'4', N'76', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'dfg', N'3', N'', CAST(N'2020-03-15T12:08:36.580' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (118, N'ZT17677193', 0, N'Normal Superman', 1232, N'h', N'4', N'76', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'dfg', N'3', N'', CAST(N'2020-03-15T12:08:36.593' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (119, N'ZT17677194', 0, N'Normal Superman', 1232, N'h', N'4', N'76', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'dfg', N'3', N'', CAST(N'2020-03-15T12:08:36.610' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (120, N'ZT17677195', 0, N'Normal Superman', 1242, N'jj', N'jj', N'87', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'887', N'878', N'', CAST(N'2020-03-15T12:18:59.127' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (121, N'ZT17677196', 0, N'Normal Superman', 1242, N'jj', N'jj', N'87', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'887', N'878', N'', CAST(N'2020-03-15T12:18:59.153' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (122, N'ZT17677197', 0, N'Normal Superman', 1242, N'jj', N'jj', N'87', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'887', N'878', N'', CAST(N'2020-03-15T12:18:59.170' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (123, N'ZT17677198', 0, N'Normal Superman', 1242, N'jj', N'jj', N'87', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'887', N'878', N'', CAST(N'2020-03-15T12:18:59.183' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (124, N'ZT17677199', 0, N'Normal Superman', 1242, N'jj', N'jj', N'87', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'887', N'878', N'', CAST(N'2020-03-15T12:18:59.200' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (125, N'ZT17677200', 0, N'Normal Superman', 1242, N'jj', N'jj', N'87', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'887', N'878', N'', CAST(N'2020-03-15T12:18:59.217' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (126, N'ZT17677201', 0, N'Normal Superman', 1242, N'jj', N'jj', N'87', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'887', N'878', N'', CAST(N'2020-03-15T12:18:59.230' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (127, N'ZT17677202', 0, N'Normal Superman', 1242, N'jj', N'jj', N'87', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'887', N'878', N'', CAST(N'2020-03-15T12:18:59.253' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (128, N'ZT17677203', 0, N'Normal Superman', 1242, N'jj', N'jj', N'87', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'887', N'878', N'', CAST(N'2020-03-15T12:18:59.267' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (129, N'ZT17677204', 0, N'Normal Superman', 1242, N'jj', N'jj', N'87', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'887', N'878', N'', CAST(N'2020-03-15T12:18:59.280' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (130, N'ZT17677205', 1, N'Normal Classic', 1246, N'n', N'kk', N'76', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'76', N'76', N'', CAST(N'2020-03-15T12:26:42.400' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (131, N'ZT17677206', 1, N'Normal Classic', 1246, N'n', N'kk', N'76', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'76', N'76', N'', CAST(N'2020-03-15T12:26:42.417' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (132, N'ZT17677209', 1, N'Normal Classic', 1250, N'tt', N'11', N'44', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'tt', N'444', N'', CAST(N'2020-03-17T16:45:55.957' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (133, N'ZT17677210', 1, N'Normal Classic', 1250, N'tt', N'11', N'44', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'tt', N'444', N'', CAST(N'2020-03-17T16:45:55.997' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (134, N'ZT17677213', 0, N'Normal Superman', 1251, N'Suraj', N'8876543218', N'8876543218', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'Ktm', N'8876543218', N'', CAST(N'2020-08-18T11:59:42.253' AS DateTime), N'8876543218@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (135, N'ZT17677214', 1, N'Normal Classic', 1253, N'hj', N'234', N'456', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'', N'2345', N'', CAST(N'2020-09-11T11:58:57.343' AS DateTime), N'@gmail.com')
INSERT [dbo].[FlyerInformation] ([id], [ticket_no], [has_video], [zipline_package], [ticket_id], [full_name], [mobile], [social], [dob], [nationality], [gender], [address], [emergency_contact], [relationship], [created_at], [email]) VALUES (136, N'ZT17778216', 1, N'Normal Tendam', 1255, N'fgh', N'6789', N'678', CAST(N'1900-01-01' AS Date), N'Nepali', N'Male', N'fghjk', N'78', N'', CAST(N'2020-09-27T22:00:32.830' AS DateTime), N's@gmail.com')
SET IDENTITY_INSERT [dbo].[FlyerInformation] OFF
SET IDENTITY_INSERT [dbo].[JobsHistory] ON 

INSERT [dbo].[JobsHistory] ([Id], [EmpId], [DesignationId], [DepartmentId], [StartDate], [EndDate], [ShiftId], [EmploymentTypeId], [Salary], [OTRate], [WorkingHR], [ContractExpiry], [PaySchedule], [IsCurrent], [CreatedBy], [CreatedDate], [ModifyBy], [ModifiedDate]) VALUES (11, 16, 3, 1002, CAST(N'2020-10-31' AS Date), CAST(N'2021-01-01' AS Date), 10, 1, N'12000', N'100', CAST(8.00 AS Decimal(18, 2)), CAST(N'2021-01-01' AS Date), N'Daily', 1, N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-06' AS Date), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-08' AS Date))
SET IDENTITY_INSERT [dbo].[JobsHistory] OFF
SET IDENTITY_INSERT [dbo].[LeaveApplications] ON 

INSERT [dbo].[LeaveApplications] ([Id], [DepartmentId], [EmployeeId], [Reason], [Type], [FromDate], [ToDate], [Remarks], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (3, 1002, 16, N'Emergency Leave', N'Full Day', CAST(N'2019-10-08' AS Date), CAST(N'2020-10-09' AS Date), N'sick leave', N'Rejected', N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-08T12:15:57.023' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-08' AS Date), 0)
SET IDENTITY_INSERT [dbo].[LeaveApplications] OFF
SET IDENTITY_INSERT [dbo].[Package] ON 

INSERT [dbo].[Package] ([id], [name], [code]) VALUES (1, N'BRIDGE', N'B')
INSERT [dbo].[Package] ([id], [name], [code]) VALUES (2, N'BUNGY', N'B')
INSERT [dbo].[Package] ([id], [name], [code]) VALUES (3, N'SWING', N'S')
INSERT [dbo].[Package] ([id], [name], [code]) VALUES (4, N'GIANT PING', N'GP')
SET IDENTITY_INSERT [dbo].[Package] OFF
SET IDENTITY_INSERT [dbo].[Province] ON 

INSERT [dbo].[Province] ([Id], [NameEn], [NameNp], [ProvinceNo], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (1, N'State 1', N'प्रदेश १', 1, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), N'Suraj', CAST(N'2018-03-18T11:27:41.127' AS DateTime), 1, NULL)
INSERT [dbo].[Province] ([Id], [NameEn], [NameNp], [ProvinceNo], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (2, N'State 2', N'प्रदेश २', 2, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL)
INSERT [dbo].[Province] ([Id], [NameEn], [NameNp], [ProvinceNo], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (3, N'State 3', N'प्रदेश ३', 3, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL)
INSERT [dbo].[Province] ([Id], [NameEn], [NameNp], [ProvinceNo], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (4, N'State 4', N'प्रदेश ४', 4, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL)
INSERT [dbo].[Province] ([Id], [NameEn], [NameNp], [ProvinceNo], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (5, N'State 5', N'प्रदेश ५', 5, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL)
INSERT [dbo].[Province] ([Id], [NameEn], [NameNp], [ProvinceNo], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (6, N'State 6', N'प्रदेश ६', 6, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL)
INSERT [dbo].[Province] ([Id], [NameEn], [NameNp], [ProvinceNo], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (7, N'State 7', N'प्रदेश ७', 7, N'Admin', CAST(N'2018-03-04T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[Province] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (1, N'Admin', N'', CAST(N'2019-11-08T12:10:47.087' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Role] ([Id], [Name], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (3, N'Cashier', N'', CAST(N'2019-11-08T12:17:39.203' AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Sequence] ON 

INSERT [dbo].[Sequence] ([Id], [Type], [ModuleId], [SequenceNo], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (2, N'Ticket', 1, 221, N'1', CAST(N'2019-11-29T00:00:00.000' AS DateTime), N'1', CAST(N'2019-11-29T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Sequence] ([Id], [Type], [ModuleId], [SequenceNo], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (3, N'Bill', 1, 84, N'1', CAST(N'2019-11-29T00:00:00.000' AS DateTime), N'Admin', CAST(N'2020-01-19T20:20:22.280' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Sequence] OFF
SET IDENTITY_INSERT [dbo].[Settings] ON 

INSERT [dbo].[Settings] ([Id], [TaxType], [TaxPercentage], [Date], [IsActive]) VALUES (2, N'VAT', CAST(13.00 AS Decimal(18, 2)), CAST(N'2019-11-12T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Settings] ([Id], [TaxType], [TaxPercentage], [Date], [IsActive]) VALUES (7, N'Service Charge', CAST(10.00 AS Decimal(18, 2)), CAST(N'2020-09-20T16:50:30.920' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Settings] OFF
SET IDENTITY_INSERT [dbo].[Shift] ON 

INSERT [dbo].[Shift] ([Id], [Name], [StartTime], [EndTime], [IsActive], [IsDeleted]) VALUES (10, N'Morning1', CAST(N'11:11:00' AS Time), CAST(N'23:00:00' AS Time), 1, 0)
INSERT [dbo].[Shift] ([Id], [Name], [StartTime], [EndTime], [IsActive], [IsDeleted]) VALUES (11, N'sdsd', CAST(N'01:00:00' AS Time), CAST(N'22:00:00' AS Time), 1, 1)
INSERT [dbo].[Shift] ([Id], [Name], [StartTime], [EndTime], [IsActive], [IsDeleted]) VALUES (12, N'mm', CAST(N'12:59:00' AS Time), CAST(N'01:00:00' AS Time), 1, 1)
SET IDENTITY_INSERT [dbo].[Shift] OFF
SET IDENTITY_INSERT [dbo].[Station] ON 

INSERT [dbo].[Station] ([Id], [Name], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (1, N'TOP', N'', CAST(N'2019-11-08T13:24:37.357' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Station] ([Id], [Name], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (2, N'BOTTOM', N'', CAST(N'2019-11-12T14:21:45.893' AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Station] OFF
SET IDENTITY_INSERT [dbo].[TicketDetail] ON 

INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (64, 64, N'ZT1767725', 10, 0.0000, 402.6500, 0.0000, 3097.3500, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-15T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-08T11:38:53.660' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (65, 65, N'ZT1767726', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-17T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-01-10T15:55:15.447' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (66, 65, N'ZT1767727', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-17T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-10T15:55:15.463' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (67, 66, N'ZT1767728', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-17T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-10T15:59:12.260' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (68, 66, N'ZT1767729', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-17T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-01-10T15:59:16.763' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (69, 67, N'ZT1767730', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-17T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-01-10T16:02:53.737' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (70, 67, N'ZT1767731', 7, 0.0000, 230.0900, 442.4800, 1769.9100, 2000.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-17T00:00:00.000' AS DateTime), N'123', 2000.0000, N'1', 1, 0, N'2', CAST(N'2020-01-10T16:02:53.753' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (71, 68, N'ZT1767732', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-18T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-11T14:11:48.093' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (72, 69, N'ZT1767733', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-18T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-11T14:20:51.053' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (73, 69, N'ZT1767734', 10, 0.0000, 269.7800, 1022.1300, 2075.2200, 2345.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-18T00:00:00.000' AS DateTime), N'123', 2345.0000, N'1', 1, 0, N'2', CAST(N'2020-01-11T14:20:59.587' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (74, 70, N'ZT1767735', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-18T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-11T14:24:36.957' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (75, 70, N'ZT1767736', 11, 0.0000, 346.8600, 1314.1600, 2668.1500, 3015.0100, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-18T00:00:00.000' AS DateTime), N'123', 3015.0100, N'1', 1, 0, N'2', CAST(N'2020-01-11T14:24:46.037' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (76, 71, N'ZT1767737', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-18T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-11T14:42:14.523' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (77, 71, N'ZT1767738', 10, 0.0000, 314.0700, 681.4200, 2415.9300, 2730.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-18T00:00:00.000' AS DateTime), N'123', 2730.0000, N'1', 1, 0, N'2', CAST(N'2020-01-11T14:42:40.417' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (78, 72, N'ZT1767739', 11, 0.0000, 517.7000, 0.0000, 3982.3100, 4500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-18T00:00:00.000' AS DateTime), N'123', 4500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-11T14:51:12.900' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (79, 73, N'ZT1767740', 11, 0.0000, 517.7000, 0.0000, 3982.3100, 4500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-18T00:00:00.000' AS DateTime), N'123', 4500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-11T14:52:52.153' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (80, 74, N'ZT1767741', 11, 0.0000, 517.7000, 0.0000, 3982.3100, 4500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-18T00:00:00.000' AS DateTime), N'123', 4500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-11T14:56:46.270' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (81, 74, N'ZT1767742', 10, 0.0000, 394.6000, 61.9500, 3035.4000, 3430.0100, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-18T00:00:00.000' AS DateTime), N'123', 3430.0100, N'1', 1, 0, N'2', CAST(N'2020-01-11T14:58:54.643' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (82, 75, N'ZT1767743', 11, 0.0000, 517.7000, 0.0000, 3982.3100, 4500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-18T00:00:00.000' AS DateTime), N'123', 4500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-11T15:00:35.143' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (83, 76, N'ZT1767744', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-26T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-19T08:22:24.813' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (84, 76, N'ZT1767745', 10, 0.0000, 394.6000, 61.9500, 3035.4000, 3430.0100, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-26T00:00:00.000' AS DateTime), N'123', 3430.0100, N'1', 1, 0, N'2', CAST(N'2020-01-19T08:22:31.117' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (85, 77, N'ZT1767746', 10, 0.0000, 402.6500, 0.0000, 3097.3500, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-26T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-19T08:23:03.803' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (86, 78, N'ZT1767747', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-26T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-19T08:27:00.827' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (87, 79, N'ZT1767748', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-26T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-19T13:23:20.653' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (88, 80, N'ZT1767749', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-26T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-01-19T13:25:29.720' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (89, 81, N'ZT1767750', 7, 0.0000, 224.3400, 486.7300, 1725.6600, 1950.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-26T00:00:00.000' AS DateTime), N'123', 1950.0000, N'1', 1, 0, N'2', CAST(N'2020-01-19T13:28:48.450' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (90, 82, N'ZT17677151', 12, 0.0000, 3.4500, 0.0000, 26.5500, 0.0300, N'USD', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-27T00:00:00.000' AS DateTime), N'123', 0.0300, N'1', 1, 0, N'2', CAST(N'2020-01-20T11:41:03.857' AS DateTime), NULL, NULL, 1, 0, CAST(113.68 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (91, 83, N'ZT17677152', 12, 0.0000, 3.4500, 0.0000, 26.5500, 0.0300, N'USD', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-27T00:00:00.000' AS DateTime), N'123', 0.0300, N'1', 1, 0, N'2', CAST(N'2020-01-20T11:59:13.380' AS DateTime), NULL, NULL, 1, 0, CAST(113.68 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (92, 86, N'ZT17677153', 12, 0.0000, 3.4500, 0.0000, 26.5500, 30.0000, N'USD', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-27T00:00:00.000' AS DateTime), N'123', 30.0000, N'1', 1, 0, N'2', CAST(N'2020-01-20T12:12:40.623' AS DateTime), NULL, NULL, 1, 0, CAST(113.68 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (93, 87, N'ZT17677154', 13, 0.0000, 4.6000, 0.0000, 35.4000, 40.0000, N'USD', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-01-27T00:00:00.000' AS DateTime), N'123', 40.0000, N'1', 1, 0, N'2', CAST(N'2020-01-20T12:51:12.310' AS DateTime), NULL, NULL, 1, 0, CAST(113.68 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (94, 88, N'ZT17677155', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-17T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-02-10T19:48:26.357' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (95, 89, N'ZT17677156', 10, 0.0000, 402.6500, 0.0000, 3097.3500, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-17T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-02-10T19:56:24.543' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (96, 90, N'ZT17677157', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-17T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-02-10T20:04:53.007' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (97, 91, N'ZT17677158', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-17T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-02-10T20:06:37.753' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (98, 92, N'ZT17677159', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-17T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-02-10T20:09:43.267' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (99, 93, N'ZT17677160', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-17T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-02-10T20:13:02.050' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (100, 94, N'ZT17677161', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-17T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-02-10T20:17:11.150' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (101, 95, N'ZT17677162', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-17T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-02-10T20:33:46.117' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (102, 95, N'ZT17677163', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-17T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-02-10T20:33:58.550' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (103, 96, N'ZT17677164', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-17T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-02-10T20:36:06.443' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (104, 96, N'ZT17677165', 10, 0.0000, 402.6500, 0.0000, 3097.3500, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-17T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-02-10T20:36:14.263' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (105, 97, N'ZT17677166', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-18T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-02-11T10:05:41.737' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (106, 98, N'ZT17677167', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-18T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-02-11T10:14:52.763' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (107, 99, N'ZT17677168', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-18T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-02-11T10:38:10.763' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (108, 100, N'ZT17677169', 7, 0.0000, 284.7300, 22.1200, 2190.2700, 2475.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-21T00:00:00.000' AS DateTime), N'123', 2475.0000, N'1', 1, 0, N'2', CAST(N'2020-02-14T09:50:26.220' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (109, 100, N'ZT17677170', 21, 0.0000, 79.7300, 6.1900, 613.2800, 693.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-02-21T00:00:00.000' AS DateTime), N'123', 693.0000, N'1', 1, 0, N'2', CAST(N'2020-02-14T09:50:33.420' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (110, 101, N'ZT17677171', 12, 0.0000, 380.8800, 122.0800, 2929.8500, 3310.7300, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-02T00:00:00.000' AS DateTime), N'123', 3310.7300, N'1', 1, 0, N'2', CAST(N'2020-02-24T11:02:43.420' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1110, 10101, N'ZT17677172', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-06T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-02-28T21:30:00.447' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1111, 10102, N'ZT17677173', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-19T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-12T14:38:44.847' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1112, 10103, N'ZT17677174', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-19T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-12T14:41:54.890' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1113, 10103, N'ZT17677175', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-19T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-12T14:42:01.760' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1114, 10104, N'ZT17677176', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-19T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-12T14:50:05.583' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1115, 10105, N'ZT1767777', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T10:59:26.723' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1116, 10105, N'ZT1767778', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T10:59:56.097' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1117, 10106, N'ZT1767779', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T11:05:59.567' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1118, 10106, N'ZT1767780', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T11:06:25.277' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1119, 10107, N'ZT1767781', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T11:07:47.350' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1120, 10107, N'ZT1767782', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T11:07:58.777' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1121, 10108, N'ZT1767783', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T11:18:35.160' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1122, 10108, N'ZT1767784', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T11:18:41.847' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1123, 10109, N'ZT1767785', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T11:55:57.590' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1124, 10109, N'ZT1767786', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T11:58:05.353' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1125, 10110, N'ZT1767787', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T18:25:27.740' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1126, 10110, N'ZT1767788', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T18:26:04.730' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1127, 10113, N'ZT1767789', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T20:40:36.580' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1128, 10114, N'ZT1767790', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T22:17:34.040' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1129, 10114, N'ZT1767791', 10, 0.0000, 402.6500, 0.0000, 3097.3500, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T22:17:46.513' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1130, 10116, N'ZT1767792', 7, 0.0000, 575.2200, 0.0000, 4424.7800, 5000.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 5000.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T22:42:45.340' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1131, 10117, N'ZT1767793', 7, 0.0000, 575.2200, 0.0000, 4424.7800, 5000.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 5000.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:01:42.357' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1132, 10117, N'ZT1767794', 7, 0.0000, 575.2200, 0.0000, 4424.7800, 5000.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 5000.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:03:26.493' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1133, 10118, N'ZT1767795', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:08:55.310' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1134, 10118, N'ZT1767796', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:09:03.010' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1135, 10119, N'ZT1767797', 7, 0.0000, 284.7400, 22.1300, 2190.2700, 2475.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2475.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:41:47.693' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1136, 10119, N'ZT1767798', 7, 0.0000, 284.7400, 22.1300, 2190.2700, 2475.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2475.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:41:59.737' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1137, 10120, N'ZT1767799', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:46:00.963' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1138, 10121, N'ZT17677100', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:50:42.880' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1139, 10121, N'ZT17677101', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:51:24.850' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1140, 10122, N'ZT17677102', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:54:15.290' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1141, 10122, N'ZT17677103', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:54:23.780' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1142, 10123, N'ZT17677104', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:58:32.213' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1143, 10123, N'ZT17677105', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:58:39.900' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1144, 10123, N'ZT17677106', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-14T23:59:07.247' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1145, 10124, N'ZT17677107', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:06:30.370' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1146, 10124, N'ZT17677108', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:06:41.957' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1147, 10124, N'ZT17677109', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:06:48.337' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1148, 10124, N'ZT17677110', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:06:59.417' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1149, 10125, N'ZT17677111', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:08:05.197' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1150, 10125, N'ZT17677112', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:08:13.957' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1151, 10125, N'ZT17677113', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:08:20.760' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1152, 10125, N'ZT17677114', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-21T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:08:23.830' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1153, 10126, N'ZT17677115', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:12:19.473' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1154, 10126, N'ZT17677116', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:12:26.460' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1155, 10126, N'ZT17677117', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:12:30.533' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1156, 10127, N'ZT17677118', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:14:55.820' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1157, 10127, N'ZT17677119', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:14:58.950' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1158, 10127, N'ZT17677120', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:15:04.863' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1159, 10128, N'ZT17677121', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:15:23.343' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1160, 10128, N'ZT17677122', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:15:28.620' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1161, 10128, N'ZT17677123', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:15:34.167' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1162, 10129, N'ZT17677124', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:15:47.070' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1163, 10129, N'ZT17677125', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:15:51.280' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1164, 10129, N'ZT17677126', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:15:53.327' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1165, 10130, N'ZT17677127', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:16:20.287' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1166, 10130, N'ZT17677128', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:16:29.980' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1167, 10130, N'ZT17677129', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:16:45.590' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1168, 10131, N'ZT17677130', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:22:26.160' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1169, 10131, N'ZT17677131', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:22:35.570' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1170, 10131, N'ZT17677132', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:22:41.507' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1171, 10131, N'ZT17677133', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:23:49.743' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1172, 10132, N'ZT17677134', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:38:28.187' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1173, 10132, N'ZT17677135', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:38:34.007' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1174, 10132, N'ZT17677136', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:38:38.083' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1175, 10132, N'ZT17677137', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:38:38.127' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1176, 10133, N'ZT17677138', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:41:35.203' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1177, 10133, N'ZT17677139', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:41:41.190' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1178, 10133, N'ZT17677140', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:41:46.757' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1179, 10133, N'ZT17677141', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:42:38.060' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1180, 10134, N'ZT17677142', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:44:42.560' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1181, 10134, N'ZT17677143', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:44:53.073' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1182, 10134, N'ZT17677144', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:44:56.547' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1183, 10134, N'ZT17677145', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T00:44:56.563' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1184, 10135, N'ZT17677146', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T08:17:15.043' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1185, 10135, N'ZT17677147', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T08:17:21.570' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1186, 10135, N'ZT17677148', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T08:17:25.023' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1187, 10135, N'ZT17677149', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T08:17:28.507' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1188, 10135, N'ZT17677150', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T08:17:28.527' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1189, 10136, N'ZT17677151', 10, 0.0000, 402.6500, 0.0000, 3097.3500, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T08:40:39.040' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1190, 10136, N'ZT17677152', 10, 0.0000, 402.6500, 0.0000, 3097.3500, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T08:40:45.623' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1191, 10136, N'ZT17677153', 10, 0.0000, 402.6500, 0.0000, 3097.3500, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T08:40:48.917' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1192, 10136, N'ZT17677154', 10, 0.0000, 402.6500, 0.0000, 3097.3500, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T08:40:52.103' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1193, 10136, N'ZT17677155', 22, 0.0000, 115.0400, 0.0000, 884.9600, 1000.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 1000.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T08:40:55.460' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1194, 10136, N'ZT17677156', 22, 0.0000, 115.0400, 0.0000, 884.9600, 1000.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 1000.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T08:40:55.480' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1195, 10136, N'ZT17677157', 22, 0.0000, 115.0400, 0.0000, 884.9600, 1000.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 1000.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T08:40:55.497' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1196, 10137, N'ZT17677158', 7, 0.0000, 258.8500, 221.2400, 497.7900, 2250.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2250.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T10:34:00.353' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1197, 10137, N'ZT17677159', 7, 0.0000, 258.8500, 221.2400, 497.7900, 2250.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2250.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T10:34:09.633' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1198, 10137, N'ZT17677160', 7, 0.0000, 258.8500, 221.2400, 497.7900, 2250.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2250.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T10:34:12.900' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1199, 10137, N'ZT17677161', 7, 0.0000, 258.8500, 221.2400, 497.7900, 2250.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2250.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T10:34:16.180' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1200, 10137, N'ZT17677162', 21, 0.0000, 76.5000, 30.9700, 196.1700, 665.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 665.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T10:34:19.720' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1201, 10137, N'ZT17677163', 21, 0.0000, 76.5000, 30.9700, 196.1700, 665.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 665.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T10:34:19.737' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1202, 10137, N'ZT17677164', 21, 0.0000, 76.5000, 30.9700, 196.1700, 665.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 665.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T10:34:19.757' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1203, 10138, N'ZT17677165', 10, 0.0000, 402.6500, 0.0000, 3097.3500, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:02:51.630' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1204, 10138, N'ZT17677166', 22, 0.0000, 115.0400, 0.0000, 884.9600, 1000.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 1000.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:02:59.790' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1205, 10139, N'ZT17677167', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:28:17.473' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1206, 10139, N'ZT17677168', 21, 0.0000, 80.5300, 0.0000, 619.4700, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:28:21.517' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1207, 10140, N'ZT17677169', 7, 0.0000, 287.6100, 0.0000, 737.4600, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:54:28.360' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1208, 10140, N'ZT17677170', 7, 0.0000, 287.6100, 0.0000, 737.4600, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:54:34.503' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1209, 10140, N'ZT17677171', 7, 0.0000, 287.6100, 0.0000, 737.4600, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:54:36.490' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1210, 10140, N'ZT17677172', 21, 0.0000, 72.4800, 61.9500, 185.8400, 630.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 630.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:54:38.587' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1211, 10140, N'ZT17677173', 21, 0.0000, 72.4800, 61.9500, 185.8400, 630.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 630.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:54:38.603' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1212, 10140, N'ZT17677174', 21, 0.0000, 72.4800, 61.9500, 185.8400, 630.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 630.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:54:38.623' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1213, 10141, N'ZT17677175', 7, 0.0000, 287.6100, 0.0000, 737.4600, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:55:59.263' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1214, 10141, N'ZT17677176', 7, 0.0000, 287.6100, 0.0000, 737.4600, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:56:03.497' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1215, 10141, N'ZT17677177', 7, 0.0000, 287.6100, 0.0000, 737.4600, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:56:05.450' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1216, 10141, N'ZT17677178', 21, 0.0000, 80.5300, 0.0000, 206.4900, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:56:07.450' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1217, 10141, N'ZT17677179', 21, 0.0000, 80.5300, 0.0000, 206.4900, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:56:07.463' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1218, 10141, N'ZT17677180', 21, 0.0000, 80.5300, 0.0000, 206.4900, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T11:56:07.480' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1219, 10142, N'ZT17677181', 7, 0.0000, 287.6100, 0.0000, 737.4600, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:01:04.700' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1220, 10142, N'ZT17677182', 7, 0.0000, 287.6100, 0.0000, 737.4600, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:01:08.250' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1221, 10142, N'ZT17677183', 7, 0.0000, 287.6100, 0.0000, 737.4600, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:01:10.197' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1222, 10142, N'ZT17677184', 21, 0.0000, 80.5300, 0.0000, 206.4900, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:01:12.043' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1223, 10142, N'ZT17677185', 21, 0.0000, 80.5300, 0.0000, 206.4900, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:01:12.060' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1224, 10142, N'ZT17677186', 21, 0.0000, 80.5300, 0.0000, 206.4900, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:01:12.077' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1225, 10143, N'ZT17677187', 10, 0.0000, 402.6500, 0.0000, 1548.6800, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:04:14.060' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1226, 10143, N'ZT17677188', 10, 0.0000, 402.6500, 0.0000, 1548.6800, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:04:18.453' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1227, 10143, N'ZT17677189', 21, 0.0000, 80.5300, 0.0000, 309.7400, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:04:20.403' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1228, 10143, N'ZT17677190', 21, 0.0000, 80.5300, 0.0000, 309.7400, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:04:20.420' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1229, 10144, N'ZT17677191', 10, 0.0000, 402.6500, 0.0000, 774.3400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:08:16.797' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1230, 10144, N'ZT17677192', 10, 0.0000, 402.6500, 0.0000, 774.3400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:08:23.137' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1231, 10144, N'ZT17677193', 10, 0.0000, 402.6500, 0.0000, 774.3400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:08:28.203' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1232, 10144, N'ZT17677194', 10, 0.0000, 402.6500, 0.0000, 774.3400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:08:31.430' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1233, 10145, N'ZT17677195', 10, 0.0000, 402.6500, 0.0000, 309.7400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:18:39.883' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1234, 10145, N'ZT17677196', 10, 0.0000, 402.6500, 0.0000, 309.7400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:18:41.810' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1235, 10145, N'ZT17677197', 10, 0.0000, 402.6500, 0.0000, 309.7400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:18:43.177' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1236, 10145, N'ZT17677198', 10, 0.0000, 402.6500, 0.0000, 309.7400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:18:45.053' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1237, 10145, N'ZT17677199', 10, 0.0000, 402.6500, 0.0000, 309.7400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:18:46.657' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1238, 10145, N'ZT17677200', 10, 0.0000, 402.6500, 0.0000, 309.7400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:18:48.473' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1239, 10145, N'ZT17677201', 10, 0.0000, 402.6500, 0.0000, 309.7400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:18:50.107' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1240, 10145, N'ZT17677202', 10, 0.0000, 402.6500, 0.0000, 309.7400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:18:51.967' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1241, 10145, N'ZT17677203', 10, 0.0000, 402.6500, 0.0000, 309.7400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:18:53.593' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1242, 10145, N'ZT17677204', 10, 0.0000, 402.6500, 0.0000, 309.7400, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:18:55.457' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1243, 10146, N'ZT17677205', 7, 0.0000, 287.6100, 0.0000, 1106.2000, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:26:37.687' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1244, 10146, N'ZT17677206', 7, 0.0000, 287.6100, 0.0000, 1106.2000, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:26:39.863' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1245, 10146, N'ZT17677207', 21, 0.0000, 80.5300, 0.0000, 309.7400, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:26:41.530' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1246, 10146, N'ZT17677208', 21, 0.0000, 80.5300, 0.0000, 309.7400, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-22T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-15T12:26:41.550' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1247, 10147, N'ZT17677209', 7, 0.0000, 287.6100, 0.0000, 1106.2000, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-24T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-17T16:45:32.720' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1248, 10147, N'ZT17677210', 7, 0.0000, 287.6100, 0.0000, 1106.2000, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-24T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'2', CAST(N'2020-03-17T16:45:46.137' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1249, 10147, N'ZT17677211', 21, 0.0000, 80.5300, 0.0000, 309.7400, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-24T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-17T16:45:55.890' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1250, 10147, N'ZT17677212', 21, 0.0000, 80.5300, 0.0000, 309.7400, 700.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-03-24T00:00:00.000' AS DateTime), N'123', 700.0000, N'1', 1, 0, N'2', CAST(N'2020-03-17T16:45:55.920' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1251, 10148, N'ZT17677213', 10, 0.0000, 402.6500, 0.0000, 3097.3500, 3500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-08-25T00:00:00.000' AS DateTime), N'123', 3500.0000, N'1', 1, 0, N'2', CAST(N'2020-08-18T11:59:27.627' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1252, 10149, N'ZT17677214', 7, 0.0000, 287.6100, 0.0000, 2212.3900, 2500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-09-18T00:00:00.000' AS DateTime), N'123', 2500.0000, N'1', 1, 0, N'3', CAST(N'2020-09-11T11:58:51.570' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1253, 10149, N'ZT17677215', 22, 0.0000, 115.0400, 0.0000, 884.9600, 1000.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-09-18T00:00:00.000' AS DateTime), N'123', 1000.0000, N'1', 1, 0, N'3', CAST(N'2020-09-11T11:58:57.313' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1254, 10150, N'ZT17778216', 11, 0.0000, 465.9300, 398.2300, 3584.0800, 4050.0100, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-10-04T00:00:00.000' AS DateTime), N'123', 4050.0100, N'1', 1, 0, N'1002', CAST(N'2020-09-27T22:00:27.633' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1255, 10150, N'ZT17778217', 21, 0.0000, 72.4800, 61.9500, 557.5200, 630.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-10-04T00:00:00.000' AS DateTime), N'123', 630.0000, N'1', 1, 0, N'1002', CAST(N'2020-09-27T22:00:32.810' AS DateTime), NULL, NULL, 1, 1, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1256, 10151, N'ZT17778218', 12, 0.0000, 0.0000, 0.0000, 7000.0000, 7000.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-11-06T00:00:00.000' AS DateTime), N'123', 7000.0000, N'1', 1, 0, N'2003', CAST(N'2020-10-30T13:01:05.663' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1257, 10152, N'ZT17778219', 10, 0.0000, 0.0000, 0.0000, 500.0000, 500.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-11-06T00:00:00.000' AS DateTime), N'123', 500.0000, N'1', 1, 0, N'2003', CAST(N'2020-10-30T13:05:33.033' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1258, 10153, N'ZT17778220', 12, 0.0000, 0.0000, 0.0000, 7000.0000, 7000.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-11-06T00:00:00.000' AS DateTime), N'123', 7000.0000, N'1', 1, 0, N'2003', CAST(N'2020-10-30T13:14:23.983' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[TicketDetail] ([Id], [TicketId], [TicketNo], [TicketRateID], [LocalTaxAmount], [VatAmount], [DiscountAmount], [BaseRate], [TotalAfterTax], [Currency], [TicketValidity], [ExpireDate], [BarCode], [TotalPrice], [BranchName], [OneWay], [TwoWay], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [has_video], [exchnage_rate]) VALUES (1259, 10154, N'ZT17778221', 12, 0.0000, 0.0000, 0.0000, 7000.0000, 7000.0000, N'NRS', CAST(N'1900-01-08T00:00:00.000' AS DateTime), CAST(N'2020-11-06T00:00:00.000' AS DateTime), N'123', 7000.0000, N'1', 1, 0, N'2003', CAST(N'2020-10-30T13:15:06.660' AS DateTime), NULL, NULL, 1, 0, CAST(1.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[TicketDetail] OFF
SET IDENTITY_INSERT [dbo].[TicketRate] ON 

INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (7, 1, 1015, N'LOCAL', 2, 1, N'NRS', 120.0000, 0.0000, 0.0000, 120.0000, 0.0000, 120.0000, N'0', CAST(N'2019-11-28T00:00:00.000' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:24:52.453' AS DateTime), 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (10, 2, 1015, N'BC, RESORT', 2, 2, N'NRS', 500.0000, 0.0000, 0.0000, 500.0000, 0.0000, 500.0000, N'0', CAST(N'2019-11-28T00:00:00.000' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:25:05.980' AS DateTime), 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (11, 3, 1015, N'BC,GP,RESORT ENTRY', 2, 3, N'NRS', 700.0000, 0.0000, 0.0000, 700.0000, 0.0000, 700.0000, N'0', CAST(N'2019-11-28T00:00:00.000' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:33:44.740' AS DateTime), 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (12, 4, 1018, N'BUNGEE', 2, 2, N'NRS', 7000.0000, 0.0000, 0.0000, 7000.0000, 0.0000, 7000.0000, N'0', CAST(N'2019-11-28T00:00:00.000' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:44:29.170' AS DateTime), 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (13, 5, 1018, N'SWING', 2, 3, N'NRS', 7000.0000, 0.0000, 0.0000, 7000.0000, 0.0000, 7000.0000, N'0', CAST(N'2019-11-28T00:00:00.000' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:42:50.717' AS DateTime), 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (14, 6, 1018, N'TANDEM SWING', 2, 3, N'NRS', 12000.0000, 0.0000, 0.0000, 12000.0000, 0.0000, 12000.0000, N'0', CAST(N'2019-11-28T00:00:00.000' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:44:02.380' AS DateTime), 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (15, 7, 1017, N'TANDEM THRILL DAY TRIP', 2, 3, N'NRS', 15000.0000, 0.0000, 0.0000, 15000.0000, 0.0000, 15000.0000, N'0', CAST(N'2019-11-28T00:00:00.000' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:45:43.123' AS DateTime), 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (16, 8, 1017, N'CRAZY DUO TRIP', 2, 3, N'NRS', 27000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 27000.0000, N'0', CAST(N'2019-11-28T00:00:00.000' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T11:46:49.600' AS DateTime), 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (17, 9, 1018, N'2nd JUMP', 2, 2, N'NRS', 3500.0000, 0.0000, 0.0000, 3500.0000, 0.0000, 3500.0000, N'0', CAST(N'2019-11-28T00:00:00.000' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T12:05:43.310' AS DateTime), 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (21, 10, 1018, N'3rd JUMP', 2, 2, N'NRS', 2500.0000, 0.0000, 0.0000, 2500.0000, 0.0000, 2500.0000, N'0', CAST(N'2019-12-08T00:00:00.000' AS DateTime), N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T12:06:42.753' AS DateTime), 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (22, 11, 8, N'Video Tendam', 1, 4, N'NRS', 884.9600, 0.0000, 115.0400, 1000.0000, 0.0000, 1000.0000, N'0', CAST(N'2019-12-08T00:00:00.000' AS DateTime), N'0', CAST(N'2019-12-08T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (10023, 12, 1018, N'4th JUMP', 2, 2, N'NRS', 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T12:08:09.293' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (10024, 13, 1016, N'GO & SEE', 2, 1, N'NRS', 2000.0000, 0.0000, 0.0000, 2000.0000, 0.0000, 2000.0000, N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T12:11:36.270' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (10025, 14, 1016, N'BUNGY OR SWING DAT TRIP', 2, 2, N'NRS', 8450.0000, 0.0000, 0.0000, 8450.0000, 0.0000, 8450.0000, N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T12:12:27.860' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (10026, 15, 1016, N'BUNGY & SWING DAY TRIP', 2, 2, N'NRS', 11600.0000, 0.0000, 0.0000, 11600.0000, 0.0000, 11600.0000, N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T12:13:10.830' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (10027, 16, 1016, N'TRIPLE THRILLS DAY', 2, 2, N'NRS', 14000.0000, 0.0000, 0.0000, 14000.0000, 0.0000, 14000.0000, N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T12:13:54.370' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[TicketRate] ([Id], [Code], [category_id], [name], [type_id], [package_id], [Currency], [base_rate], [local_tax], [vat], [total], [round_of], [grand_total], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (10028, 17, 1019, N'GIANT PING ONLY', 2, 4, N'NRS', 250.0000, 0.0000, 0.0000, 250.0000, 0.0000, 250.0000, N'fff867aa-491a-4124-bb05-4c03394e7a4f', CAST(N'2020-10-30T12:15:47.120' AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[TicketRate] OFF
SET IDENTITY_INSERT [dbo].[Tickets] ON 

INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (64, N'Z1767725', 1, 2, CAST(N'2020-01-08T11:38:53.600' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 3097.3500, 0.0000, 402.6500, 3500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-08T11:38:53.600' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (65, N'Z1767726', 1, 2, CAST(N'2020-01-10T15:55:15.417' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2831.8600, 0.0000, 368.1400, 3200.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-10T15:55:15.417' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (66, N'Z1767727', 1, 2, CAST(N'2020-01-10T15:59:12.240' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 9, N'', 1, 0.0000, 2831.8600, 0.0000, 368.1400, 3200.0000, 1, 0, 6068444, N'Sasto Ticket', N'NRS', NULL, N'james', CAST(N'2020-01-10T15:59:12.240' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (67, N'Z1767728', 1, 2, CAST(N'2020-01-10T16:02:53.713' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'bbb', 1, 442.4800, 2389.3800, 0.0000, 310.6200, 2700.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-10T16:02:53.713' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (68, N'Z1767729', 1, 2, CAST(N'2020-01-11T14:11:48.003' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-11T14:11:48.003' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (69, N'Z1767730', 1, 2, CAST(N'2020-01-11T14:20:50.970' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'fgn', 1, 1022.1300, 4287.6100, 0.0000, 557.3900, 4845.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-11T14:20:50.970' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (70, N'Z1767731', 1, 2, CAST(N'2020-01-11T14:24:36.873' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'44', 1, 1314.1600, 4880.5400, 0.0000, 634.4700, 5515.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-11T14:24:36.873' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(-0.01 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (71, N'Z1767732', 1, 2, CAST(N'2020-01-11T14:42:14.440' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'123', 1, 681.4200, 4628.3200, 0.0000, 601.6800, 5230.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-11T14:42:14.440' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (72, N'Z1767733', 1, 2, CAST(N'2020-01-11T14:51:12.790' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'4', 1, 0.0000, 3982.3100, 0.0000, 517.7000, 4500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-11T14:51:12.790' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (73, N'Z1767734', 1, 2, CAST(N'2020-01-11T14:52:52.063' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'cvb', 1, 0.0000, 3982.3100, 0.0000, 517.7000, 4500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-11T14:52:52.063' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (74, N'Z1767735', 1, 2, CAST(N'2020-01-11T14:56:26.660' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'cvbn', 1, 61.9500, 7017.7100, 0.0000, 912.3000, 7930.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-11T14:56:26.660' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(-0.01 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (75, N'Z1767736', 1, 2, CAST(N'2020-01-11T15:00:35.063' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'3456', 1, 0.0000, 3982.3100, 0.0000, 517.7000, 4500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-11T15:00:35.063' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (76, NULL, 1, 2, CAST(N'2020-01-19T08:22:24.780' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Complementary', 0, N'hjk', 1, 61.9500, 5247.7900, 0.0000, 682.2100, 5930.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-19T08:22:24.780' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(-0.01 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (77, NULL, 1, 2, CAST(N'2020-01-19T08:23:03.780' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 3097.3500, 0.0000, 402.6500, 3500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-19T08:23:03.780' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (78, NULL, 1, 2, CAST(N'2020-01-19T08:27:00.803' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Complementary', 0, N'hjkl', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-19T08:27:00.803' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (79, NULL, 1, 2, CAST(N'2020-01-19T13:23:20.603' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-19T13:23:20.603' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (80, NULL, 1, 2, CAST(N'2020-01-19T13:25:29.660' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-19T13:25:29.660' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (81, NULL, 1, 2, CAST(N'2020-01-19T13:28:48.410' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'dfghjk', 1, 486.7300, 1725.6600, 0.0000, 224.3400, 1950.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-01-19T13:28:48.410' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (82, NULL, 1, 2, CAST(N'2020-01-20T11:41:03.833' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 26.5500, 0.0000, 3.4500, 30.0000, 1, 0, 0, N'', N'USD', NULL, N'james', CAST(N'2020-01-20T11:41:03.833' AS DateTime), NULL, NULL, 1, CAST(113.68 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (83, NULL, 1, 2, CAST(N'2020-01-20T11:57:20.353' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 26.5500, 0.0000, 3.4500, 30.0000, 1, 0, 0, N'', N'USD', NULL, N'james', CAST(N'2020-01-20T11:57:20.353' AS DateTime), NULL, NULL, 1, CAST(113.68 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (84, NULL, 1, 2, CAST(N'2020-01-20T12:00:18.083' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 26.5500, 0.0000, 3.4500, 30.0000, 1, 0, 0, N'', N'USD', NULL, N'james', CAST(N'2020-01-20T12:00:18.083' AS DateTime), NULL, NULL, 1, CAST(113.68 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (85, NULL, 1, 2, CAST(N'2020-01-20T12:08:37.337' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 26.5500, 0.0000, 3.4500, 30.0000, 1, 0, 0, N'', N'USD', NULL, N'james', CAST(N'2020-01-20T12:08:37.337' AS DateTime), NULL, NULL, 1, CAST(113.68 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (86, NULL, 1, 2, CAST(N'2020-01-20T12:12:19.760' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 26.5500, 0.0000, 3.4500, 30.0000, 1, 0, 0, N'', N'USD', NULL, N'james', CAST(N'2020-01-20T12:12:19.760' AS DateTime), NULL, NULL, 1, CAST(113.68 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (87, NULL, 1, 2, CAST(N'2020-01-20T12:51:11.550' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 35.4000, 0.0000, 4.6000, 40.0000, 1, 0, 0, N'', N'USD', NULL, N'james', CAST(N'2020-01-20T12:51:11.550' AS DateTime), NULL, NULL, 1, CAST(113.68 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (88, NULL, 1, 2, CAST(N'2020-02-10T19:48:26.327' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-10T19:48:26.327' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (89, NULL, 1, 2, CAST(N'2020-02-10T19:56:09.423' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 3097.3500, 0.0000, 402.6500, 3500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-10T19:56:09.423' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (90, NULL, 1, 2, CAST(N'2020-02-10T20:04:50.987' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-10T20:04:50.987' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (91, NULL, 1, 2, CAST(N'2020-02-10T20:06:27.920' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-10T20:06:27.920' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (92, NULL, 1, 2, CAST(N'2020-02-10T20:09:33.843' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-10T20:09:33.843' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (93, NULL, 1, 2, CAST(N'2020-02-10T20:12:59.673' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 619.4700, 0.0000, 80.5300, 700.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-10T20:12:59.673' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (94, NULL, 1, 2, CAST(N'2020-02-10T20:17:09.283' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-10T20:17:09.283' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (95, NULL, 1, 2, CAST(N'2020-02-10T20:33:44.050' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2831.8600, 0.0000, 368.1400, 3200.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-10T20:33:44.050' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (96, NULL, 1, 2, CAST(N'2020-02-10T20:36:06.420' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5309.7400, 0.0000, 690.2600, 6000.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-10T20:36:06.420' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (97, NULL, 1, 2, CAST(N'2020-02-11T10:05:41.703' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Complementary', 0, N'admin', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-11T10:05:41.703' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (98, NULL, 1, 2, CAST(N'2020-02-11T10:14:52.740' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-11T10:14:52.740' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (99, NULL, 1, 2, CAST(N'2020-02-11T10:38:10.743' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-11T10:38:10.743' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (100, NULL, 1, 2, CAST(N'2020-02-14T09:50:26.193' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'sasa', 1, 28.3100, 2803.5500, 0.0000, 364.4600, 3168.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-14T09:50:26.193' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (101, NULL, 1, 2, CAST(N'2020-02-24T11:02:43.397' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'ghjkl', 1, 122.0800, 2929.8500, 0.0000, 380.8800, 3311.0000, 1, 0, 567, N'de', N'NRS', NULL, N'james', CAST(N'2020-02-24T11:02:43.397' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.27 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10101, NULL, 1, 2, CAST(N'2020-02-28T21:30:00.363' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 619.4700, 0.0000, 80.5300, 700.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-02-28T21:30:00.363' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10102, NULL, 1, 2, CAST(N'2020-03-12T14:38:44.790' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-12T14:38:44.790' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10103, NULL, 1, 2, CAST(N'2020-03-12T14:41:54.823' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2831.8600, 0.0000, 368.1400, 3200.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-12T14:41:54.823' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10104, NULL, 1, 2, CAST(N'2020-03-12T14:47:33.350' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-12T14:47:33.350' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10105, N'Z1767732', 1, 2, CAST(N'2020-03-14T10:58:35.947' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2831.8600, 0.0000, 368.1400, 3200.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T10:58:35.947' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10106, N'Z1767733', 1, 2, CAST(N'2020-03-14T11:05:42.653' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2831.8600, 0.0000, 368.1400, 3200.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T11:05:42.653' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10107, N'Z1767734', 1, 2, CAST(N'2020-03-14T11:07:46.380' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2831.8600, 0.0000, 368.1400, 3200.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T11:07:46.380' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10108, N'Z1767738', 1, 2, CAST(N'2020-03-14T11:18:34.653' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2831.8600, 0.0000, 368.1400, 3200.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T11:18:34.653' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10109, N'Z1767739', 1, 2, CAST(N'2020-03-14T11:55:08.880' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2831.8600, 0.0000, 368.1400, 3200.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T11:55:08.880' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 0)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10110, N'Z1767740', 1, 2, CAST(N'2020-03-14T18:24:56.647' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2831.8600, 0.0000, 368.1400, 3200.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T18:24:56.647' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10113, N'Z1767743', 1, 2, CAST(N'2020-03-14T20:40:04.800' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2212.3900, 0.0000, 287.6100, 2500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T20:40:04.800' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10114, N'Z1767744', 1, 2, CAST(N'2020-03-14T22:17:34.017' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5309.7400, 0.0000, 690.2600, 6000.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T22:17:34.017' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10116, N'Z1767746', 1, 2, CAST(N'2020-03-14T22:42:33.077' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 4424.7800, 0.0000, 575.2200, 5000.0000, 1, 0, 0, N'r', N'NRS', NULL, N'james', CAST(N'2020-03-14T22:42:33.077' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10117, N'Z1767747', 1, 2, CAST(N'2020-03-14T23:01:15.910' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 4424.7800, 0.0000, 575.2200, 5000.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T23:01:15.910' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10118, N'Z1767748', 1, 2, CAST(N'2020-03-14T23:08:54.640' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 4424.7800, 0.0000, 575.2200, 5000.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T23:08:54.640' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10119, N'Z1767749', 1, 2, CAST(N'2020-03-14T23:41:42.670' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'jjj', 1, 44.2500, 4380.5300, 0.0000, 569.4700, 4950.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T23:41:42.670' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10120, N'Z1767750', 1, 2, CAST(N'2020-03-14T23:46:00.940' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 4424.7800, 0.0000, 575.2200, 5000.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T23:46:00.940' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10121, N'Z1767751', 1, 2, CAST(N'2020-03-14T23:50:42.857' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 4424.7800, 0.0000, 575.2200, 5000.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T23:50:42.857' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10122, N'Z1767752', 1, 2, CAST(N'2020-03-14T23:54:15.263' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 4424.7800, 0.0000, 575.2200, 5000.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T23:54:15.263' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10123, N'Z1767753', 1, 2, CAST(N'2020-03-14T23:58:32.190' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 6637.1700, 0.0000, 862.8300, 7500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-14T23:58:32.190' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10124, N'Z1767754', 1, 2, CAST(N'2020-03-15T00:06:30.343' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 8495.5800, 0.0000, 1104.4200, 9600.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T00:06:30.343' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10125, N'Z1767755', 1, 2, CAST(N'2020-03-15T00:08:03.053' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 8495.5800, 0.0000, 1104.4200, 9600.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T00:08:03.053' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10126, N'Z1767756', 1, 2, CAST(N'2020-03-15T00:12:19.447' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5663.7200, 0.0000, 736.2800, 6400.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T00:12:19.447' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10127, N'Z1767757', 1, 2, CAST(N'2020-03-15T00:14:55.800' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5663.7200, 0.0000, 736.2800, 6400.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T00:14:55.800' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10128, N'Z1767758', 1, 2, CAST(N'2020-03-15T00:15:23.323' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5663.7200, 0.0000, 736.2800, 6400.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T00:15:23.323' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10129, N'Z1767759', 1, 2, CAST(N'2020-03-15T00:15:47.040' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5663.7200, 0.0000, 736.2800, 6400.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T00:15:47.040' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10130, N'Z1767760', 1, 2, CAST(N'2020-03-15T00:16:20.263' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5663.7200, 0.0000, 736.2800, 6400.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T00:16:20.263' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10131, N'Z1767761', 1, 2, CAST(N'2020-03-15T00:22:26.137' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5663.7200, 0.0000, 736.2800, 6400.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T00:22:26.137' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10132, N'Z1767762', 1, 2, CAST(N'2020-03-15T00:38:28.163' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5663.7200, 0.0000, 736.2800, 6400.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T00:38:28.163' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10133, N'Z1767763', 1, 2, CAST(N'2020-03-15T00:41:35.183' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5663.7200, 0.0000, 736.2800, 6400.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T00:41:35.183' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10134, N'Z1767764', 1, 2, CAST(N'2020-03-15T00:44:42.533' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5663.7200, 0.0000, 736.2800, 6400.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T00:44:42.533' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10135, N'Z1767765', 1, 2, CAST(N'2020-03-15T08:17:15.020' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 7876.1100, 0.0000, 1023.8900, 8900.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T08:17:15.020' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10136, N'Z1767766', 1, 2, CAST(N'2020-03-15T08:40:39.017' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 15044.2800, 0.0000, 1955.7200, 17000.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T08:40:39.017' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 0)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10137, N'Z1767767', 1, 2, CAST(N'2020-03-15T10:34:00.330' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'YYY', 1, 977.8800, 9730.1000, 0.0000, 1264.9100, 10995.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T10:34:00.330' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10138, N'Z1767768', 1, 2, CAST(N'2020-03-15T11:02:51.607' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 3982.3100, 0.0000, 517.6900, 4500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T11:02:51.607' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10139, N'Z1767769', 1, 2, CAST(N'2020-03-15T11:28:17.453' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 2831.8600, 0.0000, 368.1400, 3200.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T11:28:17.453' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10140, N'Z1767770', 1, 2, CAST(N'2020-03-15T11:54:28.337' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'k', 1, 185.8400, 8309.7300, 0.0000, 1080.2600, 9390.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T11:54:28.337' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10141, N'Z1767771', 1, 2, CAST(N'2020-03-15T11:55:59.240' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 8495.5800, 0.0000, 1104.4200, 9600.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T11:55:59.240' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10142, N'Z1767772', 1, 2, CAST(N'2020-03-15T12:01:04.677' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 8495.5800, 0.0000, 1104.4200, 9600.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T12:01:04.677' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10143, N'Z1767773', 1, 2, CAST(N'2020-03-15T12:04:14.040' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 7433.6400, 0.0000, 966.3600, 8400.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T12:04:14.040' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10144, N'Z1767774', 1, 2, CAST(N'2020-03-15T12:08:16.777' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 12389.4000, 0.0000, 1610.6000, 14000.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T12:08:16.777' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 0)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10145, N'Z1767775', 1, 2, CAST(N'2020-03-15T12:18:39.860' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 30973.5000, 0.0000, 4026.5000, 35000.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T12:18:39.860' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 0)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10146, N'Z1767776', 1, 2, CAST(N'2020-03-15T12:26:37.663' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5663.7200, 0.0000, 736.2800, 6400.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-15T12:26:37.663' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10147, N'Z1767777', 1, 2, CAST(N'2020-03-17T16:45:32.660' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 5663.7200, 0.0000, 736.2800, 6400.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-03-17T16:45:32.660' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10148, N'Z1767778', 1, 2, CAST(N'2020-08-18T11:59:27.600' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 3097.3500, 0.0000, 402.6500, 3500.0000, 1, 0, 0, N'', N'NRS', NULL, N'james', CAST(N'2020-08-18T11:59:27.600' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10149, N'Z1767779', 1, 2, CAST(N'2020-09-11T11:58:51.547' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'86d38e99-c572-42f7-ba35-50dd82c836b7', N'Cash', 0, N'', 1, 0.0000, 3097.3500, 0.0000, 402.6500, 3500.0000, 1, 0, 0, N'', N'NRS', NULL, N'suraj', CAST(N'2020-09-24T00:00:00.000' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10150, N'Z1777880', 1, 7, CAST(N'2020-09-27T22:00:27.610' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'1002', N'Cash', 0, N'cc', 1, 460.1800, 4141.6000, 0.0000, 538.4100, 4680.0000, 1, 0, 0, N'', N'NRS', NULL, N'suraj1', CAST(N'2020-09-27T22:00:27.610' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(-0.01 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10151, N'Z1777881', 1, 7, CAST(N'2020-10-30T13:01:05.620' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'2003', N'Cash', 0, N'', 1, 0.0000, 26000.0000, 0.0000, 0.0000, 26000.0000, 1, 0, 0, N'', N'NRS', NULL, N'Suraj', CAST(N'2020-10-30T13:01:05.620' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10152, N'Z1777882', 1, 7, CAST(N'2020-10-30T13:05:33.030' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'2003', N'Cash', 0, N'', 1, 0.0000, 1200.0000, 0.0000, 0.0000, 1200.0000, 1, 0, 0, N'', N'NRS', NULL, N'Suraj', CAST(N'2020-10-30T13:05:33.030' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10153, N'Z1777883', 1, 7, CAST(N'2020-10-30T13:14:23.977' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'2003', N'Cash', 0, N'', 1, 0.0000, 7500.0000, 0.0000, 0.0000, 7500.0000, 1, 0, 0, N'', N'NRS', NULL, N'Suraj', CAST(N'2020-10-30T13:14:23.977' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
INSERT [dbo].[Tickets] ([Id], [BillNo], [BranchId], [FY_ID], [PrintedDate], [LocalTaxPercentage], [VatPercentage], [UserId], [PaymentMode], [AgentId], [Description], [RePrint], [DiscountAmount], [TaxableAmount], [TotalLocalTax], [TotalVatAmount], [GrandTotal], [OneWay], [TwoWay], [CustomerVatNo], [CustomerName], [Currency], [TicketFrom], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [exchange_rate], [round_off], [pay_via], [pay_code], [credit_customer], [credit_phone], [Status]) VALUES (10154, N'Z1777884', 1, 7, CAST(N'2020-10-30T13:15:06.657' AS DateTime), CAST(0.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'2003', N'Cash', 0, N'', 1, 0.0000, 7000.0000, 0.0000, 0.0000, 7000.0000, 1, 0, 0, N'', N'NRS', NULL, N'Suraj', CAST(N'2020-10-30T13:15:06.657' AS DateTime), NULL, NULL, 1, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', N'', N'', N'', 1)
SET IDENTITY_INSERT [dbo].[Tickets] OFF
SET IDENTITY_INSERT [dbo].[Type] ON 

INSERT [dbo].[Type] ([Id], [Type], [ShortName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (1, N'1 Way', N'1W', 0, CAST(N'2019-11-08T13:49:33.803' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Type] ([Id], [Type], [ShortName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (2, N'2 Way', N'2W', 0, CAST(N'2019-11-12T15:09:57.253' AS DateTime), N'', CAST(N'2019-11-12T15:35:13.607' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Type] OFF
SET IDENTITY_INSERT [dbo].[UserProfile] ON 

INSERT [dbo].[UserProfile] ([Id], [UserId], [EmployeeId], [PhoneNumber], [Mobile], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [State], [VDCMunc], [District], [City], [Address], [WardNo]) VALUES (2, N'fff867aa-491a-4124-bb05-4c03394e7a4f', NULL, N'0258888', N'9896532155', N'Ram', N'', N'Thapa', N'Male', CAST(N'2000-02-01' AS Date), 3, 376, 34, N'Kathmandu', NULL, 5)
INSERT [dbo].[UserProfile] ([Id], [UserId], [EmployeeId], [PhoneNumber], [Mobile], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [State], [VDCMunc], [District], [City], [Address], [WardNo]) VALUES (2003, N'4e20c47b-795f-4fc9-9d09-b1365e544b75', 16, N'9845578643', N'9845578643', N'Suraj', N'', N'Deuja', N'Male', CAST(N'2016-10-30' AS Date), 3, NULL, 26, NULL, N'Banepa', NULL)
SET IDENTITY_INSERT [dbo].[UserProfile] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Username], [Password], [Role], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsBlocked]) VALUES (2, N'james', N'2B37DDB1972061B91F24F3E1B9D84C66AD00DD14', 3, 0, CAST(N'2019-11-28T00:00:00.000' AS DateTime), NULL, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Role], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsBlocked]) VALUES (3, N'suraj', N'2B37DDB1972061B91F24F3E1B9D84C66AD00DD14', 1, 1, CAST(N'2020-01-23T16:42:00.037' AS DateTime), NULL, NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[WorkingPoints] ON 

INSERT [dbo].[WorkingPoints] ([Id], [Code], [Name], [IsActive], [IsDeleted]) VALUES (2, N'10', N'Parking-1', 0, 1)
INSERT [dbo].[WorkingPoints] ([Id], [Code], [Name], [IsActive], [IsDeleted]) VALUES (3, N'1', N'Parking', 1, 0)
INSERT [dbo].[WorkingPoints] ([Id], [Code], [Name], [IsActive], [IsDeleted]) VALUES (4, N'9', N'sds', 1, 0)
SET IDENTITY_INSERT [dbo].[WorkingPoints] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 2020-11-30 11:46:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 2020-11-30 11:46:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 2020-11-30 11:46:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RoleId]    Script Date: 2020-11-30 11:46:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 2020-11-30 11:46:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 2020-11-30 11:46:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Users_Role]    Script Date: 2020-11-30 11:46:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_Users_Role] ON [dbo].[Users]
(
	[Role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Denomination] ADD  CONSTRAINT [DF__denominat__statu__1ED998B2]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[online_booking] ADD  CONSTRAINT [DF_online_booking_dob]  DEFAULT (NULL) FOR [dob]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[District]  WITH CHECK ADD  CONSTRAINT [FK_District_Province] FOREIGN KEY([ProvinceId])
REFERENCES [dbo].[Province] ([Id])
GO
ALTER TABLE [dbo].[District] CHECK CONSTRAINT [FK_District_Province]
GO
ALTER TABLE [dbo].[JobsHistory]  WITH CHECK ADD  CONSTRAINT [FK_JobsHistory_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([Id])
GO
ALTER TABLE [dbo].[JobsHistory] CHECK CONSTRAINT [FK_JobsHistory_Department]
GO
ALTER TABLE [dbo].[JobsHistory]  WITH CHECK ADD  CONSTRAINT [FK_JobsHistory_Designation] FOREIGN KEY([DesignationId])
REFERENCES [dbo].[Designation] ([Id])
GO
ALTER TABLE [dbo].[JobsHistory] CHECK CONSTRAINT [FK_JobsHistory_Designation]
GO
ALTER TABLE [dbo].[JobsHistory]  WITH CHECK ADD  CONSTRAINT [FK_JobsHistory_EmployeeDetails] FOREIGN KEY([EmpId])
REFERENCES [dbo].[EmployeeDetails] ([Id])
GO
ALTER TABLE [dbo].[JobsHistory] CHECK CONSTRAINT [FK_JobsHistory_EmployeeDetails]
GO
ALTER TABLE [dbo].[TicketDetail]  WITH CHECK ADD  CONSTRAINT [FK_TicketDetail_Tickets] FOREIGN KEY([TicketId])
REFERENCES [dbo].[Tickets] ([Id])
GO
ALTER TABLE [dbo].[TicketDetail] CHECK CONSTRAINT [FK_TicketDetail_Tickets]
GO
ALTER TABLE [dbo].[TicketRate]  WITH CHECK ADD  CONSTRAINT [FK_TicketRate_Package] FOREIGN KEY([package_id])
REFERENCES [dbo].[Package] ([id])
GO
ALTER TABLE [dbo].[TicketRate] CHECK CONSTRAINT [FK_TicketRate_Package]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Role] FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Role]
GO
/****** Object:  StoredProcedure [dbo].[SP_AGENTS]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AGENTS]

AS
BEGIN
	SET NOCOUNT ON;
	SELECT
	*
	FROM Agents WHERE  Agents.IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[SP_BILL_BY_ID]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Jeetendra Pathak 9849713894
-- =============================================
CREATE PROCEDURE [dbo].[SP_BILL_BY_ID]
	@bill_id bigint
AS
	SELECT * FROM Tickets
	  WHERE Tickets.id = @bill_id
     



GO
/****** Object:  StoredProcedure [dbo].[SP_BILL_VOID]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BILL_VOID]
	@bill_id bigint,
	@remarks text
AS
	UPDATE [dbo].Tickets
	SET [status] = 0
	  WHERE Tickets.id = @bill_id
     



GO
/****** Object:  StoredProcedure [dbo].[SP_COMPANY]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_COMPANY]

AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1
	*
	FROM CompanyInfo 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Flyer_DETAIL_BY_Ticket_No]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Flyer_DETAIL_BY_Ticket_No]
(
@TicketNo varchar(max)
)
AS
BEGIN
select * from FlyerInformation where ticket_no=@TicketNo
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FY]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FY]

AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
	FiscalYear.id, FiscalYear.ShortName, FiscalYear.YearCode, GETDATE() as server_date
	FROM FiscalYear 
	WHERE FiscalYear.IsActive = 1 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_AGENT_BY_ID]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_AGENT_BY_ID]
    @id bigint
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1
	*
	FROM Agents WHERE  Agents.Id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_BOOKING_DATA_BY_ID]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_BOOKING_DATA_BY_ID]
(
@booking_id int
)
AS
BEGIN
SELECT *
from online_booking
WHERE online_booking.booking_id = @booking_id 
order by online_booking.Id asc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_BOOKING_DATE]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_BOOKING_DATE]
(
@date date,
@booking_id int
)
AS
BEGIN
SELECT *
from online_booking
WHERE (CAST(online_booking.zipline_date AS DATE) = CAST(@date AS DATE)) 
order by online_booking.Id asc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CATEGORY]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_CATEGORY]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
	*
	FROM Category order by Name
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_COMPLEMENTARY]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_COMPLEMENTARY]
(
@from		  date		,	
@to			  date		,	
@operatorId   NVARCHAR(128)	= NULL
)
AS
BEGIN
SELECT Tickets.BillNo as 'bill_no', Tickets.PaymentMode as 'payment_mode',
Tickets.GrandTotal * Tickets.exchange_rate as 'grand_total',
Tickets.Description  as 'remarks'
from Tickets
WHERE (CAST(Tickets.CreatedDate AS DATE) >= CAST(@from AS DATE)  AND CAST(Tickets.CreatedDate AS DATE) <= CAST(@to AS DATE) )
AND Tickets.PaymentMode = 'Complementary' AND  Tickets.UserId=@operatorId 
order by Tickets.Id asc
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_DISCOUNT_SUMMARY]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_DISCOUNT_SUMMARY]
(
@from date = null,
@to date   = null,
@operatorId   NVARCHAR(128)	= NULL

)
AS
BEGIN
SELECT Tickets.BillNo as 'bill_no', Tickets.PaymentMode as 'payment_mode',
(Tickets.TaxableAmount * Tickets.exchange_rate) as 'taxable_amount',
Tickets.TotalVatAmount * Tickets.exchange_rate as 'tax_amount',
Tickets.DiscountAmount * Tickets.exchange_rate as 'discount_amount',
Tickets.round_off * Tickets.exchange_rate as 'round_off',
Tickets.GrandTotal * Tickets.exchange_rate as 'grand_total',
Tickets.Description  as 'remarks',
Tickets.VatPercentage,
CAST(Tickets.CreatedDate AS DATE) CreatedDate
from Tickets
WHERE (CAST(Tickets.CreatedDate AS DATE) >= CAST(@from AS DATE) OR ISNULL(@from,'')=''  
AND CAST(Tickets.CreatedDate AS DATE) <= CAST(@to AS DATE) OR ISNULL(@to,'')='' )
AND  Tickets.UserId= @operatorId OR ISNULL(@operatorId,'')=''
AND Tickets.DiscountAmount > 0 
order by Tickets.Id asc
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_SUMMARY]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_SUMMARY]
(
@from		  date		,	
@to			  date		,	
@operatorId   NVARCHAR(128)	= NULL

)
AS
BEGIN
	If(OBJECT_ID('tempdb..##temp') Is Not Null)
		Begin
		    Drop Table ##temp
		End

create table ##temp(	
	 count bigint
	,total decimal(18,4)
	,title NVARCHAR (100)
	,o_b nvarchar(50)
	,Type	nvarchar(20)
	);

		
		
BEGIN
	INSERT INTO ##temp
	
	SELECT count(TicketRate.Id) as 'count', SUM(TotalPrice * TicketDetail.exchnage_rate) as 'total', 'Classic Zipline' as 'title', 'A' as 'o_b', 'z' as 'Type'
	from TicketDetail
	inner join TicketRate on TicketDetail.TicketRateID = TicketRate.Id
	inner join Tickets on  TicketDetail.TicketId = Tickets.Id
	WHERE (CAST(TicketDetail.CreatedDate AS DATE) >= CAST(@from AS DATE) AND CAST(TicketDetail.CreatedDate AS DATE) <= CAST(@to AS DATE))
	 AND TicketRate.package_id = 1 AND Tickets.UserId=@operatorId AND Tickets.status = 1
	union
	(
	SELECT count(TicketRate.Id) as 'count', SUM(TotalPrice * TicketDetail.exchnage_rate) as 'total', 'Superman Zipline' as 'title', 'B' as 'o_b','z' as 'Type'
	from TicketDetail
	inner join TicketRate on TicketDetail.TicketRateID = TicketRate.Id
	inner join Tickets on  TicketDetail.TicketId = Tickets.Id
	WHERE  Tickets.status = 1 AND (CAST(TicketDetail.CreatedDate AS DATE) >= CAST(@from AS DATE) AND CAST(TicketDetail.CreatedDate AS DATE) <= CAST(@to AS DATE))
	 AND TicketRate.package_id = 2 AND Tickets.UserId=@operatorId
		
	)
	union
	(
	SELECT count(TicketRate.Id) as 'count', SUM(TotalPrice * TicketDetail.exchnage_rate) as 'total', 'Tendam Zipline' as 'title', 'C' as 'o_b','z' as 'Type'
	from TicketDetail
	inner join TicketRate on TicketDetail.TicketRateID = TicketRate.Id
	inner join Tickets on  TicketDetail.TicketId = Tickets.Id
	WHERE (CAST(TicketDetail.CreatedDate AS DATE) >= CAST(@from AS DATE) AND CAST(TicketDetail.CreatedDate AS DATE) <= CAST(@to AS DATE)) 
	AND TicketRate.package_id = 3 AND Tickets.status = 1 AND Tickets.UserId=@operatorId
			
	)

	declare @count int
	SET @count = (select count(total) from ##temp)

	IF(@count>0)
	BEGIN
		INSERT INTO ##temp
	
			SELECT  COUNT(*)as 'count',SUM(TotalPrice * TicketDetail.exchnage_rate) as 'total','Video Normal' as 'title' ,'D' as 'o_b','v' as 'Type'  
			from TicketDetail
			inner join TicketRate on TicketDetail.TicketRateID = TicketRate.Id
			inner join Tickets ON TicketDetail.TicketId = Tickets.Id
			where (CAST(TicketDetail.CreatedDate AS DATE) >= CAST(@from AS DATE) AND CAST(TicketDetail.CreatedDate AS DATE) <= CAST(@to AS DATE))
			AND TicketDetail.has_video =1 AND  TicketRate.Id = 21 AND Tickets.status=1 AND Tickets.UserId=@operatorId
			UNION
			(
			SELECT  COUNT(*)as 'count',SUM(TotalPrice * TicketDetail.exchnage_rate) as 'total','Video Tendam' as 'title' ,'E' as 'o_b','v' as 'Type'  
			from TicketDetail
			inner join TicketRate on TicketDetail.TicketRateID = TicketRate.Id
			inner join Tickets ON TicketDetail.TicketId = Tickets.Id
			where (CAST(TicketDetail.CreatedDate AS DATE) >= CAST(@from AS DATE) AND CAST(TicketDetail.CreatedDate AS DATE) <= CAST(@to AS DATE))
			AND TicketDetail.has_video =1 AND  TicketRate.Id = 22 AND Tickets.status=1 AND Tickets.UserId=@operatorId
			)

 --	select  COUNT(*)as 'count',SUM(TotalPrice * TicketDetail.exchnage_rate) as 'total','Video Normal' as 'title' ,'D' as 'o_b','v' as 'Type'  
	--from FlyerInformation
	--INNER JOIN TicketDetail ON FlyerInformation.ticket_id = TicketDetail.Id
	--inner join TicketRate on TicketDetail.TicketRateID = TicketRate.Id
	--where (CAST(created_at AS DATE) >= CAST(@from AS DATE) AND CAST(created_at AS DATE) <= CAST(@to AS DATE))
	-- AND FlyerInformation.has_video =1 AND  TicketRate.Id = 21
	--UNION
	--(
	--select  COUNT(*)as 'count',SUM(TotalPrice * TicketDetail.exchnage_rate) as 'total','Video Tendam' as 'title' ,'E' as 'o_b','v' as 'Type' 
 --   from FlyerInformation
	--INNER JOIN TicketDetail ON FlyerInformation.ticket_id = TicketDetail.Id
	--inner join TicketRate on TicketDetail.TicketRateID = TicketRate.Id
	--where (CAST(created_at AS DATE) >= CAST(@from AS DATE) AND CAST(created_at AS DATE) <= CAST(@to AS DATE))
	--AND FlyerInformation.has_video =1 AND  TicketRate.Id = 22
	--)

	END
		select * from ##temp

END

END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_TICKET_BY_CODE]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_TICKET_BY_CODE]
    @code bigint
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1
	*
	FROM TicketRate WHERE  TicketRate.Code = @code
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_TICKET_RATE_BY_CATEGORY_ID]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_TICKET_RATE_BY_CATEGORY_ID]
@category_id int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
	*
	FROM TicketRate where category_id = @category_id
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_USER_VAT_LEDGER]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GET_USER_VAT_LEDGER]
(
@bill_number varchar(max)
)
AS
BEGIN

SELECT Tickets.Id, Tickets.BillNo as 'bill_no', Tickets.PaymentMode as 'payment_mode',
CONVERT(numeric(10,2),(Tickets.TaxableAmount * Tickets.exchange_rate)) as 'taxable_amount',
CONVERT(numeric(10,2),(Tickets.TotalVatAmount * Tickets.exchange_rate)) as 'tax_amount',
CONVERT(numeric(10,2),(Tickets.DiscountAmount * Tickets.exchange_rate)) as 'discount_amount',
Tickets.round_off * Tickets.exchange_rate as 'round_off',
CONVERT(numeric(10,2),(Tickets.GrandTotal * Tickets.exchange_rate)) as 'grand_total',
Tickets.VatPercentage
from Tickets
WHERE --(CAST(Tickets.CreatedDate AS DATE) >= CAST(GETDATE() AS DATE)) AND 
(Tickets.BillNo = @bill_number or @bill_number = '')
order by Tickets.Id desc
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_VAT_LEDGER]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_VAT_LEDGER]
(
@from		  Date			= NULL,
@to			  DATE			= NULL,
@operatorId   NVARCHAR(128)	= NULL
)
AS
BEGIN
DECLARE @sql NVARCHAR(MAX)
SET @sql = 
			'SELECT Tickets.BillNo as bill_no , Tickets.PaymentMode as payment_mode,
			(Tickets.TaxableAmount * Tickets.exchange_rate) as taxable_amount,
			Tickets.TotalVatAmount * Tickets.exchange_rate as tax_amount,
			Tickets.DiscountAmount * Tickets.exchange_rate as discount_amount,
			Tickets.round_off * Tickets.exchange_rate as round_off,
			Tickets.GrandTotal * Tickets.exchange_rate as grand_total,
			Tickets.VatPercentage,
			Tickets.CreatedDate
			from Tickets
			WHERE 1=1 AND Tickets.UserId ='''+ CONVERT(NVARCHAR(MAX),@operatorId)+''''

			IF (ISNULL(@from, '') <> '' AND ISNULL(@to, '') <> '')                
               BEGIN                    
                   SET @sql = @sql+' '+'AND Tickets.CreatedDate>='''+CONVERT(VARCHAR, @from)+'''';                    
                   SET @sql = @sql+' '+'AND Tickets.CreatedDate<='''+CONVERT(VARCHAR, @to)+'''';                    
               END;  

			    IF (ISNULL(@from, '') <> '' AND ISNULL(@to, '') = '')                  
                    BEGIN                    
                        SET @sql = @sql+' '+'AND Tickets.CreatedDate>='''+CONVERT(VARCHAR, @from)+'''';                    
                    END; 

				 IF (ISNULL(@from, '') = '' AND ISNULL(@to, '') <> '')                   
                    BEGIN                    
                        SET @sql = @sql+' '+'AND Tickets.CreatedDate<='''+CONVERT(VARCHAR, @to)+'''';                    
                     END;

			SET @sql = @sql +' '+ 'AND Tickets.PaymentMode != ''Complementary'' order by Tickets.Id asc'

			PRINT @sql

			EXEC(@sql)
			
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_VIDEO_PACKAGE]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_VIDEO_PACKAGE]
(
@from date,
@to date
)
AS
BEGIN
SELECT * 
from FlyerInformation
WHERE (CAST(FlyerInformation.created_at AS DATE) >= CAST(@from AS DATE)  AND CAST(FlyerInformation.created_at AS DATE) <= CAST(@to AS DATE) )
AND FlyerInformation.has_video = 1
order by FlyerInformation.Id asc
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_Video_SUMMARY]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GET_Video_SUMMARY]
(
@from date,
@to date
)
AS
BEGIN
	
	(
select  COUNT(*)as 'count',SUM(700) as 'total','Video' as 'title'   from FlyerInformation
where (CAST(created_at AS DATE) >= CAST(@from AS DATE) AND CAST(created_at AS DATE) <= CAST(@to AS DATE))
AND zipline_package = ('Normal Classic') OR zipline_package= ('Normal Superman') 
	)
UNION
(
select  COUNT(*)as 'count',SUM(1000) as 'total','Video' as 'title'   from FlyerInformation
where zipline_package = ('Normal Tendam') AND
(CAST(created_at AS DATE) >= CAST(@from AS DATE) AND CAST(created_at AS DATE) <= CAST(@to AS DATE))
)

END
--select * from FlyerInformation
--where
--(CAST(created_at AS DATE) >= CAST(@from AS DATE) AND CAST(created_at AS DATE) <= CAST(@to AS DATE))
--order by zipline_package
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_BILL]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jeetendra Pathak 9849713894
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_BILL]
	@BRANCH_ID INT,
	@FY_ID INT,
	@FY_NAME VARCHAR(10),
	@LOCAL_TAX_PERCENT DECIMAL(18, 2),
	@VAT_PERCENT DECIMAL(18, 2),
	@USER_ID INT,
	@USERNAME varchar(max),
	@PAYMENT_MODE VARCHAR(max),
	@AGENT_ID INT,
	@REMARKS TEXT,
	@TAXABLE_AMOUNT DECIMAL(18, 2),
	@VAT_AMOUNT DECIMAL(18, 2),
	@GRAND_TOTAL DECIMAL(18, 2),
	@CUSTOMER_NAME VARCHAR(MAX),
	@CUSTOMER_VAT_PAN VARCHAR(MAX),
	@DISCOUNT_AMOUNT DECIMAL(18, 2),
	@EXCHANGE DECIMAL(18, 2),
	@CURRENCY VARCHAR(MAX),

	@ROUND_OFF DECIMAL(18, 2),
	@PAY_VIA VARCHAR(MAX),
	@PAY_CODE VARCHAR(MAX),
	@CREDITOR VARCHAR(MAX),
	@CREDITOR_PHONE VARCHAR(MAX)
AS
	DECLARE @SEQ_NO VARCHAR(MAX)
	DECLARE @BILL_NO VARCHAR(MAX)
	DECLARE @TICkeT_NO int
	
	IF (@PAYMENT_MODE != 'Complementary')
	BEGIN
		SET @SEQ_NO = dbo.GET_TABLE_SEQUENCE('Bill', 0)
		UPDATE [Sequence] SET [SequenceNo] = @SEQ_NO WHERE [Sequence].Type = 'Bill' AND [Sequence].ModuleId = 1
		SET @BILL_NO = 'Z' + CAST( @BRANCH_ID AS VARCHAR) + CAST(  @FY_NAME AS VARCHAR ) + CAST(  @SEQ_NO AS VARCHAR)
	END
	

	INSERT INTO [dbo].Tickets
           ([BillNo]
           ,[BranchId]
           ,[FY_ID]
           ,[PrintedDate]
           ,[LocalTaxPercentage]
           ,[VatPercentage]
           ,[UserId]
           ,[PaymentMode]
           ,[AgentId]
           ,[Description]
           ,[RePrint]
           ,[DiscountAmount]
           ,[TaxableAmount]
           ,[TotalLocalTax]
           ,[TotalVatAmount]
           ,[GrandTotal]
           ,[OneWay]
           ,[TwoWay]
           ,[CustomerVatNo]
           ,[CustomerName]
           ,[Currency]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[IsActive]
		   ,[exchange_rate]
		   ,[round_off]
           ,[pay_via]
           ,[pay_code]
           ,[credit_customer]
           ,[credit_phone]
		   ,[Status])
		   
	VALUES
	(
		@BILL_NO,
		@BRANCH_ID,
		@FY_ID,
		GETDATE(),
		0, 
		@VAT_PERCENT,
		@USER_ID,
		@PAYMENT_MODE,
		@AGENT_ID,
		@REMARKS,
		1,
		@DISCOUNT_AMOUNT,
		@TAXABLE_AMOUNT,
		0,
		@VAT_AMOUNT,
		@GRAND_TOTAL,
		1,
		0,
		@CUSTOMER_VAT_PAN,
		@CUSTOMER_NAME,
		@CURRENCY,
		@USERNAME,
		GETDATE(),
		1,
		@EXCHANGE,
		@ROUND_OFF,
		@PAY_VIA,
		@PAY_CODE,
		@CREDITOR,
		@CREDITOR_PHONE,
		1
	)

SELECT SCOPE_IDENTITY() as id, @BILL_NO as BILL_NO


GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_BILL_DETAIL]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jeetendra Pathak 9849713894
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_BILL_DETAIL]
	@BILL_ID INT,
	@TICKET_RATE_ID INT,
	@BRANCH_ID INT,
	@FY_ID INT,
	@FY_NAME VARCHAR(10),
	@VAT_PERCENT DECIMAL(18, 2),
	@DISCOUNT_PERCENT DECIMAL(18, 2),
	@USER_ID INT,
	@USERNAME varchar(max),
	@PAYMENT_MODE VARCHAR(10),
	@REMARKS TEXT,
	@HAS_VIDEO int,
	@VALIDITY int,
	@EXPIRY_DATE VARCHAR(MAX),
	@TAXABLE_AMOUNT DECIMAL(18, 2),
	@DISCOUNT_AMOUNT DECIMAL(18, 2),
	@VAT_AMOUNT DECIMAL(18, 2),
	@GRAND_TOTAL DECIMAL(18, 2),
	@BARCODE VARCHAR(MAX),
	@CURRENCY VARCHAR(MAX),
	@EXCHANGE DECIMAL(18, 2)
AS
	DECLARE @SEQ_NO VARCHAR(MAX)
	DECLARE @TICKET_NO VARCHAR(MAX)
	
	SET @SEQ_NO = dbo.GET_TABLE_SEQUENCE('Ticket', 0)
	UPDATE [Sequence] SET [SequenceNo] = @SEQ_NO WHERE [Sequence].Type = 'Ticket' AND [Sequence].ModuleId = 1
	SET @TICKET_NO = 'ZT' + CAST( @BRANCH_ID AS VARCHAR) + CAST(  @FY_NAME AS VARCHAR ) + CAST(  @SEQ_NO AS VARCHAR)
	

	INSERT INTO [dbo].TicketDetail
           ([TicketId]
           ,[TicketNo]
           ,[TicketRateID]
           ,[LocalTaxAmount]
           ,[VatAmount]
           ,[DiscountAmount]
           ,[BaseRate]
           ,[TotalAfterTax]
           ,[Currency]
           ,[TicketValidity]
           ,[ExpireDate]
           ,[BarCode]
           ,[TotalPrice]
           ,[BranchName]
           ,[OneWay]
           ,[TwoWay]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[IsActive]
		   ,[has_video]
		   ,[exchnage_rate])
	VALUES
	(
		@BILL_ID,
		@TICkeT_NO,
		@TICKET_RATE_ID,
		0, 
		@VAT_AMOUNT,
		@DISCOUNT_AMOUNT,
		@TAXABLE_AMOUNT,
		@GRAND_TOTAL,
		@CURRENCY,
		@VALIDITY,
		@EXPIRY_DATE,
		@BARCODE,
		@GRAND_TOTAL,
		@BRANCH_ID,
		1,
		0,
		@USER_ID,
		GETDATE(),
		1,
		@HAS_VIDEO,
		@EXCHANGE
	)

SELECT SCOPE_IDENTITY() as id, @TICKET_NO as TICKET_NO


GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_BOOKING_DATA]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jeetendra Pathak 9849713894
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_BOOKING_DATA]
	@booking_id BIGINT,
	@fullname VARCHAR(MAX),
	@mobile_no VARCHAR(MAX),
	@email VARCHAR(MAX),
	@dob varchar(max),
	@address VARCHAR(MAX),
	@zipline_type VARCHAR(MAX),
	@emergency_contact VARCHAR(MAX),
	@zipline_date DATE,
	@social_media_contact VARCHAR(MAX),
	@nationality VARCHAR(MAX),
	@gender VARCHAR(MAX),
	@payment_method VARCHAR(MAX),
	@relationship VARCHAR(MAX),
	@know_about_us TEXT,
	@note TEXT
AS
    if exists(Select 1 From online_booking Where online_booking.booking_id = @booking_id)
     BEGIN
		SELECT @booking_id as id
	 END
    ELSE
      BEGIN
        INSERT INTO [dbo].online_booking
           ([booking_id]
           ,[fullname]
           ,[mobile_no]
           ,[email]
           ,[dob]
           ,[address]
           ,[zipline_type]
           ,[emergency_contact]
           ,[zipline_date]
           ,[social_media_contact]
           ,[nationality]
           ,[gender]
           ,[payment_method]
           ,[relationship]
           ,[know_about_us]
           ,[note]
           ,[created_at])
	VALUES
	(
		@booking_id,
		@fullname,
		@mobile_no,
		@email,
		@dob, 
		@address,
		@zipline_type,
		@emergency_contact,
		@zipline_date,
		@social_media_contact,
		@nationality,
		@gender,
		@payment_method,
		@relationship,
		@know_about_us,
		@note,
		GETDATE()
	)
       END
  


	

SELECT SCOPE_IDENTITY() as id

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_FLYER]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jeetendra Pathak 9849713894
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_FLYER]
	@TICKER_ID BIGINT,
	@FULL_NAME VARCHAR(MAX),
	@MOBILE VARCHAR(MAX),
	@SOCIAL VARCHAR(MAX),
	@DOB DATE,
	@NATIONALITY VARCHAR(MAX),
	@GENDER VARCHAR(MAX),
	@ADDRESS VARCHAR(MAX),
	@EMEGENCY VARCHAR(MAX),
	@RELATIONSHIP VARCHAR(MAX),
	@EMAIL VARCHAR(MAX),
	@TICKET_NO VARCHAR(MAX),
	@ZIPLINE VARCHAR(MAX),
	@HAS_VIDEO int
AS

	INSERT INTO [dbo].FlyerInformation
           ([ticket_no]
           ,[has_video]
           ,[zipline_package]
		   ,[ticket_id]
           ,[full_name]
           ,[mobile]
           ,[social]
           ,[dob]
           ,[nationality]
           ,[gender]
           ,[address]
           ,[emergency_contact]
           ,[relationship]
           ,[created_at]
		   ,[email])
	VALUES
	(
		@TICKET_NO,
		@HAS_VIDEO,
		@ZIPLINE,
		@TICKER_ID,
		@FULL_NAME,
		@MOBILE,
		@SOCIAL,
		@DOB,
		@NATIONALITY,
		@GENDER,
		@ADDRESS,
		@EMEGENCY,
		@RELATIONSHIP,
		GETDATE(),
		@EMAIL
	)

SELECT SCOPE_IDENTITY() as id


GO
/****** Object:  StoredProcedure [dbo].[SP_Ticket_DETAIL_BY_Ticket_ID]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Ticket_DETAIL_BY_Ticket_ID]
(
@bill_Id varchar(max)
)
AS
BEGIN
	select TicketRate.name,TicketRate.Code, TicketDetail.* from TicketDetail
	INNER JOIN TicketRate ON 
	TicketRate.Id = TicketDetail.TicketRateID
	where  TicketId=@bill_Id
 END
GO
/****** Object:  StoredProcedure [dbo].[SP_USER_LOGIN]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_USER_LOGIN]
    @username VARCHAR(MAX),
	@password VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	--SELECT users.id as 'user_id', users.*, Role.Name as 'user_role' FROM users 
	--INNER JOIN [Role] ON users.Role = [Role].id
	--WHERE Users.IsActive = 1
	--AND Users.IsBlocked = 0
	--AND Users.Username = @username AND Users.Password = @password
	
	SELECT UP.Id as 'user_id',AU.UserName, ANR.Name AS 'user_role'  FROM AspNetUsers AU
	INNER JOIN AspNetUserRoles AR ON AU.Id = AR.UserId
	INNER JOIN AspNetRoles ANR ON AR.RoleId = ANR.Id
	INNER JOIN UserProfile UP ON AU.Id = UP.UserId
	WHERE ANR.Name = 'Ticketing' AND AU.PasswordDesk = @password AND AU.UserName = @username
END


select * from AspNetUsers
GO
/****** Object:  StoredProcedure [dbo].[SP_VAT]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_VAT]

AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1
	*
	FROM Settings WHERE  Settings.TaxType = 'VAT'
END
GO
/****** Object:  StoredProcedure [dbo].[spAgents]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spAgents]
 @Id					INT				= Null
,@Name					NVARCHAR(50)	= NULL
,@Address				NVARCHAR(50)	= NULL
,@ContactPerson			NVARCHAR(50)	= NULL
,@Telephone				VARCHAR(20)		= NULL
,@CommissionPercentage	DECIMAL(18, 2)  = NULL
,@IsActive				BIT				= NULL
,@flag					VARCHAR(10)		= NULL
,@user					NVARCHAR(128)	= NULL
,@VAT					VARCHAR(100)	= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
	INSERT INTO [dbo].[Agents]
	(
		 [Name]					
		,[Address]
		,[ContactPerson]
		,[Telephone]
		,[CommissionPercentage]
		,[CreatedBy]
		,[CreatedDate]
		,[IsActive]
		,[vat_no]
	)
	VALUES
	(
		 @Name	 
		,@Address		 
		,'NA'-- @ContactPerson	 
		,@Telephone
		,@CommissionPercentage
		,@user
		,GETDATE()		
		,@IsActive	
		,@VAT	 
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	UPDATE [dbo].[Agents]
	SET
		 [Name]						= @Name
		,[Address]					= @Address
		,[Telephone]				= @Telephone
		,[CommissionPercentage]		= @CommissionPercentage
		,[ModifiedBy]				= @user
		,[ModifiedDate]				= GETDATE()
		,[IsActive]					= @IsActive
		,[vat_no]					= @VAT
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	Update Agents 
	SET IsDeleted = 1
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		Id
		,[Name]					
		,[Address]
		,[ContactPerson]
		,[Telephone]
		,[CommissionPercentage]		
		,[IsActive]
		,[vat_no]
	FROM [dbo].[Agents] (NOLOCK)
	WHERE ISNULL(IsDeleted,0)<>1

END

ELSE IF(@flag='la')
BEGIN
	SELECT 
		Id
		 ,[Name]					
		,[Address]
		,[ContactPerson]
		,[Telephone]
		,[CommissionPercentage]
		,[IsActive]
		,[vat_no]

	FROM [dbo].[Agents] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1 AND ISNULL(IsDeleted,0)<>1
END

ELSE IF(@flag='s')
BEGIN
	SELECT 
		Id
		, [Name]					
		,[Address]
		,[ContactPerson]
		,[Telephone]
		,[CommissionPercentage]		
		,[IsActive]
		,[vat_no]
	FROM [dbo].[Agents] (NOLOCK)
	WHERE Id=@Id
	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spApplicationLog]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spApplicationLog](
	 @flag VARCHAR(50)			= NULL
	,@id BIGINT					= NULL
	,@errorPage VARCHAR(MAX)	= NULL
	,@errorMsg VARCHAR(MAX)		= NULL
	,@errorDetails VARCHAR(MAX) = NULL
	,@referer VARCHAR(MAX)		= NULL
	,@ipAddress VARCHAR(20)		= NULL
	,@user NVARCHAR(128)		= NULL
	,@fromDate VARCHAR(25)	= NULL
	,@toDate VARCHAR(25)	= NULL
	,@createdBy	  NVARCHAR(128) = NULL
)

AS
SET NOCOUNT ON
DECLARE  @sql				VARCHAR(MAX)
		,@table				VARCHAR(MAX)
		,@sql_filter		VARCHAR(MAX)
		

IF @flag = 'i' 
BEGIN
	DECLARE @newId BIGINT
	INSERT INTO ApplicationLog(ErrorPage,ErrorMsg,ErrorDetails,IpAddress,Referer,CreatedBy,CreatedDate)
	SELECT @errorPage, @errorMsg, @errorDetails,@ipAddress,@referer, @user, GETDATE()
	
	SET @newId=SCOPE_IDENTITY()
	EXEC spErrorHandler 0, 'LogRecordedSuccessfully', @newId
	RETURN
END
ELSE IF @flag = 's' 
BEGIN
	SELECT ErrorPage,ErrorMsg,ErrorDetails,IpAddress,Referer,CreatedBy,CreatedDate FROM ApplicationLog(NOLOCK) WHERE Id=@id
	RETURN
END
ELSE IF @flag='a'
BEGIN
	SET @table = '
			SELECT 
				 A.Id
				,A.ErrorPage
				,LEFT(A.ErrorMsg, 100) ErrorMsg
				,A.ErrorDetails
				,A.Referer
				,CreatedBy=U.UserName
				,A.CreatedDate 
				,ipAddress
			FROM ApplicationLog A WITH(NOLOCK) 
			JOIN AspNetUsers U WITH(NOLOCK)  ON A.CreatedBy=U.Id
			WHERE 1 = 1 
				'

	SET @sql_filter = ''
	

	IF (ISNULL(@fromDate,'') != '' AND ISNULL(@toDate,'') != '')
		SET @sql_filter = @sql_filter + ' AND A.CreatedDate BETWEEN ''' + CONVERT(VARCHAR,@fromDate,101) + ''' AND ''' + CONVERT(VARCHAR,@toDate,101) + ' 23:59:59'''
	
	 IF (ISNULL(@id,'')!='')
		SET @sql_filter = @sql_filter + ' AND A.Id = ' + CAST(@id AS VARCHAR)

		
    SET @sql_filter=@sql_filter+'  ORDER BY A.CreatedDate DESC'
	
	SET @sql=@table+@sql_filter
    EXEC(@sql)
END




GO
/****** Object:  StoredProcedure [dbo].[spAspNetUserRoles]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAspNetUserRoles] 
 @UserId			NVARCHAR(128)	= NULL
,@RoleId			NVARCHAR(128)	= NULL
,@flag				VARCHAR(10)		= NULL
,@user				NVARCHAR(50)	= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
IF EXISTS (SELECT TOP 1 'X' FROM [dbo].[AspNetUserRoles] WHERE UserId = @UserId)
	BEGIN
	  EXEC spErrorHandler 1, 'AlreadyExists', @UserId
	  RETURN
	END  

	INSERT INTO [dbo].[AspNetUserRoles]
	(
		 [RoleId],
		 [UserId],
		 [CreatedBy],
		 [CreatedDate]
	)
	VALUES
	(
		@RoleId,
		@UserId,
		@user,
		GETDATE()	 
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	UPDATE [dbo].[AspNetUserRoles]
	SET
		  [RoleId]	 = @RoleId
	 WHERE [UserId]	= @UserId
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	DELETE from AspNetUserRoles 
	Where UserId = @UserId
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		 AU.UserName ,
		 R.Name AS Role,
		 AR.UserId,
		 AR.RoleId
	FROM [dbo].[AspNetUserRoles] AR (NOLOCK)
	INNER JOIN AspNetUsers AU ON AR.UserId = AU.Id
	INNER JOIN AspNetRoles R ON AR.RoleId = R.Id
END


ELSE IF(@flag='s')
BEGIN
	SELECT
		 [UserId],
		 [RoleId]
	FROM [dbo].[AspNetUserRoles] (NOLOCK)
	WHERE UserId = @UserId
END
END









GO
/****** Object:  StoredProcedure [dbo].[spCategory]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCategory]
 @Id					INT				= Null
,@Name					VARCHAR(250)	= NULL
,@Unit					VARCHAR(50)		= NULL
,@ShortName				VARCHAR(50)		= NULL
,@flag					VARCHAR(10)		= NULL
,@user					NVARCHAR(128)	= NULL
,@IsActive				BIT				= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
IF EXISTS(SELECT  'X' FROM Category(NOLOCK) WHERE  Name=@Name OR ShotName = @ShortName)
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	INSERT INTO [dbo].[Category]
	(
		 [Name]					
		,[Unit]
		,[ShotName]
		,[CreatedBy]
		,[CreatedDate]
		,[IsActive]
	)
	VALUES
	(
		 @Name	 
		,@Unit
		,@ShortName
		,@user
		,GETDATE()		
		,@IsActive	
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	IF EXISTS(SELECT  'X' FROM Category(NOLOCK) WHERE  Id <> @Id AND (Name=@Name OR ShotName=@ShortName))
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	UPDATE [dbo].[Category]
	SET
		 [Name]				= @Name
		,[Unit]				= @Unit
		,[ShotName]			= @ShortName
		,[ModifiedBy]		= @user
		,[ModifiedDate]		= GETDATE()
		,[IsActive]			= @IsActive
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	Update Category 
	SET IsDeleted = 1
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		Id
		,[Name]					
		,[Unit]
		,[ShotName]	
		,[IsActive]
	FROM [dbo].[Category] (NOLOCK)
	WHERE ISNULL(IsDeleted,0)<>1

END

ELSE IF(@flag='la')
BEGIN
	SELECT 
		Id
		 ,[Name]					
		 ,[Unit]
		 ,[ShotName]
		,[IsActive]

	FROM [dbo].[Category] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1 AND ISNULL(IsDeleted,0)<>1
END

ELSE IF(@flag='s')
BEGIN
	SELECT 
		 Id
		,[Name]					
		,[unit]
		,[ShotName]
		,[IsActive]
	FROM [dbo].[Category] (NOLOCK)
	WHERE Id=@Id
	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spCompanyInfo]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCompanyInfo]
@Id				 INT			= Null
,@Name			 NVARCHAR(50)	= NULL
,@Address		 NVARCHAR(50)	= NULL
,@ContactNo		 INT			= NULL
,@VatNo			 NVARCHAR(50)   = NULL
,@IsActive		 BIT			= NULL
,@flag			 VARCHAR(10)	= NULL
,@user			 NVARCHAR(50)	= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
	INSERT INTO [dbo].[CompanyInfo]
	(
		 [Name]
		,[Address]
		,[ContactNo]
		,[VatNo]
		,[IsActive]
	)
	VALUES
	(
		 @Name	 
		,@Address		 
		,@ContactNo	 
		,@VatNo
		,@IsActive		 
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	UPDATE [dbo].[CompanyInfo]
	SET
		 [Name]			=@Name
		,[Address]			=@Address
		,[ContactNo]		=@ContactNo
		,[VatNo]			=@VatNo
		,[IsActive]			=@IsActive
	 WHERE [id]=@Id
	EXEC spErrorHandler 0, 'UpdatedSuccessfully', NULL

 END


ELSE IF(@flag='d')
BEGIN
IF((SELECT COUNT(Id) FROM CompanyInfo)>0)
BEGIN
DELETE from CompanyInfo 
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', NULL
 END
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		 Id
		, Name
		, Address
		, ContactNo
		, VatNo
		,IsActive
	FROM [dbo].[CompanyInfo] (NOLOCK)

END

ELSE IF(@flag='la')
BEGIN
	SELECT 
		 Id
		, Name
		, Address
		, ContactNo
		, VatNo
		,IsActive
	FROM [dbo].[CompanyInfo] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1
END

ELSE IF(@flag='s')
BEGIN
	SELECT 
		 Id
		, Name
		, Address
		, ContactNo
		, VatNo
		,IsActive
	FROM [dbo].[CompanyInfo] (NOLOCK)
	WHERE Id=@Id
	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spComplementaryReport]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spComplementaryReport]
(
@from date = null,
@to date   = null,
@operatorId   NVARCHAR(128)	= NULL

)
AS
BEGIN
DECLARE @SQL NVARCHAR(MAX)

SET @SQL= '
SELECT Tickets.BillNo as ''bill_no'', Tickets.PaymentMode as ''payment_mode'',
(Tickets.TaxableAmount * Tickets.exchange_rate) as ''taxable_amount'',
Tickets.TotalVatAmount * Tickets.exchange_rate as ''tax_amount'',
Tickets.DiscountAmount * Tickets.exchange_rate as ''discount_amount'',
Tickets.round_off * Tickets.exchange_rate as ''round_off'',
Tickets.GrandTotal * Tickets.exchange_rate as ''grand_total'',
Tickets.Description  as ''remarks'',
Tickets.VatPercentage,
CAST(Tickets.CreatedDate AS DATE) CreatedDate
from Tickets WHERE 1=1 '

	IF (ISNULL(@from, '') <> '' AND ISNULL(@to, '') <> '')                
	BEGIN
		  SET @sql = @sql+' '+'AND Tickets.CreatedDate>='''+CONVERT(VARCHAR, @from)+'''';                    
             SET @sql = @sql+' '+'AND Tickets.CreatedDate<='''+CONVERT(VARCHAR, @to)+'''';  
	END

	IF (ISNULL(@from, '') <> '' AND ISNULL(@to, '') = '')                  
               BEGIN                    
                   SET @sql = @sql+' '+'AND Tickets.CreatedDate>='''+CONVERT(VARCHAR, @from)+'''';                    
               END; 

		 IF (ISNULL(@from, '') = '' AND ISNULL(@to, '') <> '')                   
               BEGIN                    
                   SET @sql = @sql+' '+'AND Tickets.CreatedDate<='''+CONVERT(VARCHAR, @to)+'''';                    
                END;

		IF(ISNULL(@operatorId,'')<>'')
		BEGIN
            SET @sql = @sql+' '+'AND Tickets.UserId ='''+CONVERT(VARCHAR(MAX), @operatorId)+'''';                    
		END

            SET @sql = @sql+' '+'AND Tickets.PaymentMode = ''Complementary'' order by Tickets.Id asc'                 

--print @sql
EXEC(@sql)
END

GO
/****** Object:  StoredProcedure [dbo].[spCounterSettlement]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCounterSettlement]  
  @Date			DATE		    = NULL  
 ,@UserId		NVARCHAR(128)	= NULL  
 ,@Status		INT				= NULL  
 ,@Remarks		VARCHAR(100)	= NULL  
 ,@Id			INT				= NULL  
 ,@flag			VARCHAR(50)		= NULL,  
  
 @Rs1000		int				= NULL,  
 @Rs500			int				= NULL,  
 @Rs100			int				= NULL,  
 @Rs50			int				= NULL,  
 @Rs20			int				= NULL,  
 @Rs10			int				= NULL,  
 @Rs5			int				= NULL,  
 @Coins			int				= NULL,  
 @Ic			int				= NULL,  
 @Request		text			= NULL,  
 @Impression	text			= NULL  
AS  
BEGIN  
  
  IF(@flag='s')
  BEGIN
	SELECT T.PaymentMode , sum(GrandTotal) AS GrandTotal 
	FROM [dbo].[Tickets] T(NOLOCK)
	WHERE T.UserId = @UserId AND T.status = 1 AND  CAST(T.CreatedDate AS DATE) = CAST(@Date AS DATE)
	AND T.PaymentMode <> 'Complementary'
	  GROUP BY T.PaymentMode

	SELECT TOP 1 * FROM Denomination(NOLOCK) 
	WHERE status =0 AND CreatedDate  = CAST(@Date AS DATE) AND UserId = @UserId 
  END
  
 ELSE IF(@flag ='approve')  
 BEGIN  
 UPDATE Denomination  
  SET 
	Status		= 1,  
    Remarks		= @remarks,  
    SettledBy	= @UserId  
  WHERE Id		= @Id  
 EXEC spErrorHandler 0, 'ApprovedSuccessfully', null
 END  
END  
  
GO
/****** Object:  StoredProcedure [dbo].[spDeductions]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spDeductions]
 @Id					INT				= Null
,@Name					VARCHAR(50)		= NULL
,@flag					VARCHAR(20)		= NULL
,@IsActive				BIT				= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
IF EXISTS(SELECT  'X' FROM Deductions(NOLOCK) WHERE  Name=@Name)
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	INSERT INTO [dbo].[Deductions]
	(
		 [Name]					
		,[IsActive]
		,[IsDeleted]
	)
	VALUES
	(
		 @Name	 		
		,@IsActive	
		,0
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	IF EXISTS(SELECT  'X' FROM Deductions(NOLOCK) WHERE  Id <> @Id AND (Name=@Name))
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	UPDATE [dbo].[Deductions]
	SET
		 [Name]				= @Name		
		,[IsActive]			= @IsActive
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	Update Deductions 
	SET IsDeleted = 1
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		Id
		,[Name]							
		,[IsActive]
	FROM [dbo].[Deductions] (NOLOCK)
	WHERE ISNULL(IsDeleted,0)<>1

END

ELSE IF(@flag='la')
BEGIN
	SELECT 
		  Id
		,[Name]					
		,[IsActive]

	FROM [dbo].[Deductions] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1 AND ISNULL(IsDeleted,0)<>1
END

ELSE IF(@flag='s')
BEGIN
	SELECT 
		 Id
		,[Name]							
		,[IsActive]
	FROM [dbo].[Deductions] (NOLOCK)
	WHERE Id=@Id
	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spDepartment]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spDepartment]
  @Id			INT				 = NULL
 ,@Code			NVARCHAR(10)	 = NULL
 ,@Name			VARCHAR(200)	 = NULL
 ,@Description	NVARCHAR(200)	 = NULL
 ,@flag			VARCHAR(10)		 = NULL
 ,@user			NVARCHAR(50)	 = NULL

AS
BEGIN
	IF(@flag='i')
	BEGIN 
		IF EXISTS(SELECT  'X' FROM Department(NOLOCK) WHERE  Name=@Name)
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END
		INSERT INTO [dbo].[Department]
		(
			 [Name]
			,[Code]
			,[Description]
			,[CreatedBy]
			,[CreatedDate]
			,[IsDeleted]
		)
		VALUES
		(
		 @Name
		,@Code
		,@Description	
		,@user		
		,GETDATE()
		,0		
		)
		EXEC spErrorHandler 0, 'AddedSuccessfully', 125
	END
	ELSE IF(@flag='u')
	BEGIN
		IF EXISTS(SELECT  'X' FROM Department(NOLOCK) WHERE  Name=@Name AND Id <> @Id)
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END
		UPDATE [dbo].[Department]
		SET
		 [Name]			= @Name
		,[Code]			= @Code
		,[Description]	= @Description
		,[ModifiedBy]	 =	@user
		,[ModifiedDate]	 =	GETDATE()
		WHERE [Id]=@Id
		EXEC spErrorHandler 0, 'UpdatedSuccessfully', NULL
	END

	ELSE IF(@flag='d')
	BEGIN
		UPDATE [dbo].[Department]
		SET
		[IsDeleted]=1
		WHERE [Id]=@Id
		EXEC spErrorHandler 0, 'DeletedSuccessfully', NULL
	END

	ELSE IF(@flag='a')
	BEGIN
		SELECT 
			D.Id,
			D.Name,
			D.Code,
 			D.Description
		FROM [dbo].[Department] D(NOLOCK)
		WHERE ISNULL(d.IsDeleted,0) <> 1
	END

	
	ELSE IF(@flag='s')
	BEGIN
		SELECT 
		    D.Id,
			D.Name,
 			D.Description,
			D.Code
		 FROM [dbo].[Department] D (NOLOCK)
		WHERE Id=@Id
	END

END




GO
/****** Object:  StoredProcedure [dbo].[spDesignation]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spDesignation]
 @Id					INT				= Null
,@Name					VARCHAR(50)		= NULL
,@flag					VARCHAR(20)		= NULL
,@IsActive				BIT				= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
IF EXISTS(SELECT  'X' FROM Designation(NOLOCK) WHERE  Name=@Name)
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	INSERT INTO [dbo].[Designation]
	(
		 [Name]					
		,[IsActive]
		,[IsDeleted]
	)
	VALUES
	(
		 @Name	 		
		,@IsActive	
		,0
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	IF EXISTS(SELECT  'X' FROM Designation(NOLOCK) WHERE  Id <> @Id AND (Name=@Name))
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	UPDATE [dbo].[Designation]
	SET
		 [Name]				= @Name		
		,[IsActive]			= @IsActive
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	Update Designation 
	SET IsDeleted = 1
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		Id
		,[Name]							
		,[IsActive]
	FROM [dbo].[Designation] (NOLOCK)
	WHERE ISNULL(IsDeleted,0)<>1

END

ELSE IF(@flag='la')
BEGIN
	SELECT 
		  Id
		,[Name]					
		,[IsActive]

	FROM [dbo].[Designation] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1 AND ISNULL(IsDeleted,0)<>1
END

ELSE IF(@flag='s')
BEGIN
	SELECT 
		 Id
		,[Name]							
		,[IsActive]
	FROM [dbo].[Designation] (NOLOCK)
	WHERE Id=@Id
	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spDropdownlist]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spDropdownlist]

@flag VARCHAR(100)=NULL
,@SearchBy VARCHAR(100)=''

As
BEGIN
/*** Dropdownlist for District ***/
	If(@flag='district')
	BEGIN
			DECLARE @sqlDistrict NVARCHAR(500)
			SET @sqlDistrict ='
			SELECT 
			Id
			,NameEn  as DisplayName
			
			FROM District(NOLOCK) 
			WHERE (IsDeleted IS NULL OR IsDeleted <>1) 
			  AND (IsActive IS NULL OR IsActive=1)'
			  if(@SearchBy <>'')
				BEGIN
					SET @sqlDistrict =@sqlDistrict +' AND ProvinceId='''+@SearchBy+''''
				END
				EXEC(@sqlDistrict)
	END

	ELSE IF(@flag = 'Province')        
	BEGIN        
		SELECT Id,         
		NameNp AS DisplayName        
		FROM Province(NOLOCK)        
		WHERE IsDeleted IS NULL        
		AND IsActive = 1        
	END;  


	ELSE IF(@flag='roles')
	BEGIN
		SELECT Id, Name AS DisplayName FROM AspNetRoles(NOLOCK) WHERE ISNULL(IsDeleted,0)<>1
	END

	ELSE IF(@flag = 'users')
	BEGIN
		SELECT Id,UserName AS DisplayName  FROM AspNetUsers(NOLOCK) WHERE ISNULL(IsDeleted,0)<>1
	END

	ELSE IF(@flag = 'types')
	BEGIN
		SELECT Id,Type AS DisplayName  FROM [dbo].[Type] (NOLOCK) WHERE ISNULL(IsActive,1)=1
	END

	ELSE IF(@flag = 'categories')
	BEGIN
		SELECT Id,Name AS DisplayName  FROM [Category] (NOLOCK) WHERE ISNULL(IsDeleted,0)<>1 AND ISNULL(IsActive,1)=1
	END

	ELSE IF(@flag = 'packages')
	BEGIN
		SELECT Id,name AS DisplayName  FROM [Package](NOLOCK)
	END

	ELSE IF(@flag = 'counterUsers')
	BEGIN
		SELECT U.Id,U.UserName AS DisplayName FROM AspNetUserRoles R
		INNER JOIN AspNetUsers U ON R.UserId = U.Id
		INNER JOIN AspNetRoles AR ON R.RoleId = AR.Id
		WHERE ISNULL(U.IsDeleted,0)=0 AND ISNULL(U.IsActive,1)=1 AND
		RoleId='6e228195135c48629991b4bd5a2dd88b'
	END

	ELSE IF(@flag = 'ticketUsers')
	BEGIN
		SELECT U.Id,U.UserName AS DisplayName FROM AspNetUserRoles R
		INNER JOIN AspNetUsers U ON R.UserId = U.Id
		INNER JOIN AspNetRoles AR ON R.RoleId = AR.Id
		WHERE ISNULL(U.IsDeleted,0)=0 AND ISNULL(U.IsActive,1)=1 AND
		RoleId='6e228195135c48629991b4bd5a2dd88b'
	END

	ELSE IF(@flag = 'ticketItems')
	BEGIN
		SELECT Id, name AS DisplayName FROM TicketRate WHERE ISNULL(IsActive,1)=1 
	END

	ELSE IF(@flag = 'agents')
	BEGIN
		SELECT Id, name AS DisplayName FROM Agents WHERE ISNULL(IsActive,1)=1  AND ISNULL(IsDeleted,0)=0
	END

	ELSE IF(@flag = 'department')
	BEGIN
		SELECT Id, name AS DisplayName FROM Department WHERE ISNULL(IsDeleted,0)=0
	END

	ELSE IF(@flag = 'designation')
	BEGIN
		SELECT Id, name AS DisplayName FROM Designation WHERE ISNULL(IsDeleted,0)=0 AND  ISNULL(IsActive,1)=1 
	END

	ELSE IF(@flag = 'shift')
	BEGIN
		SELECT Id, name AS DisplayName FROM [Shift] WHERE ISNULL(IsDeleted,0)=0 AND  ISNULL(IsActive,1)=1 
	END

	ELSE IF(@flag = 'employment-Types')
	BEGIN
		SELECT Id, name AS DisplayName FROM EmploymentTypes WHERE ISNULL(IsDeleted,0)=0 AND  ISNULL(IsActive,1)=1 
	END

	ELSE If(@flag='employee')
	BEGIN
			DECLARE @sqlEmp NVARCHAR(500)
			SET @sqlEmp = '
				SELECT 
					E.Id
				   ,E.FirstName+'' ''+ISNULL(E.MiddleName,'' '')+'' ''+E.LastName  as DisplayName
			from EmployeeDetails E
			WHERE E.IsFired <>1 AND E.IsSuspended<>1 AND E.IsActive <> 0'
			  if(@SearchBy <>'')
				BEGIN
					SET @sqlEmp =@sqlEmp +' AND E.DepartmentId ='''+@SearchBy+''''
				END
				--print @sqlEmp
				EXEC(@sqlEmp)
	END

	ELSE IF(@flag = 'get-earnings')
	BEGIN
		SELECT Id, name AS DisplayName FROM Earnings WHERE ISNULL(IsDeleted,0)=0 AND  ISNULL(IsActive,1)=1 
	END

	ELSE IF(@flag = 'get-deductions')
	BEGIN
		SELECT Id, name AS DisplayName FROM Deductions WHERE ISNULL(IsDeleted,0)=0 AND  ISNULL(IsActive,1)=1 
	END
END
	
	
GO
/****** Object:  StoredProcedure [dbo].[spEarnings]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spEarnings]
 @Id					INT				= Null
,@Name					VARCHAR(50)		= NULL
,@flag					VARCHAR(20)		= NULL
,@IsActive				BIT				= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
IF EXISTS(SELECT  'X' FROM Earnings(NOLOCK) WHERE  Name=@Name)
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	INSERT INTO [dbo].[Earnings]
	(
		 [Name]					
		,[IsActive]
		,[IsDeleted]
	)
	VALUES
	(
		 @Name	 		
		,@IsActive	
		,0
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	IF EXISTS(SELECT  'X' FROM Earnings(NOLOCK) WHERE  Id <> @Id AND (Name=@Name))
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	UPDATE [dbo].[Earnings]
	SET
		 [Name]				= @Name		
		,[IsActive]			= @IsActive
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	Update Earnings 
	SET IsDeleted = 1
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		Id
		,[Name]							
		,[IsActive]
	FROM [dbo].[Earnings] (NOLOCK)
	WHERE ISNULL(IsDeleted,0)<>1

END

ELSE IF(@flag='la')
BEGIN
	SELECT 
		  Id
		,[Name]					
		,[IsActive]

	FROM [dbo].[Earnings] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1 AND ISNULL(IsDeleted,0)<>1
END

ELSE IF(@flag='s')
BEGIN
	SELECT 
		 Id
		,[Name]							
		,[IsActive]
	FROM [dbo].[Earnings] (NOLOCK)
	WHERE Id=@Id
	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spEmployee]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spEmployee]
  @Id					INT					= NULL
 ,@FirstName			VARCHAR(50)			= NULL
 ,@MiddleName			VARCHAR(30)			= NULL
 ,@LastName				VARCHAR(30)			= NULL
 ,@Gender				VARCHAR(20)			= NULL
 ,@Phone				VARCHAR(20)			= NULL
 ,@Nationality			VARCHAR(20)			= NULL
 ,@DOB					DATE				= NULL
 ,@MaritalStatus		VARCHAR(20)			= NULL
 ,@Ethnicity			VARCHAR(30)			= NULL
 ,@StateId				INT					= NULL
 ,@DistrictId			INT					= NULL
 ,@Address				VARCHAR(50)			= NULL
 ,@Email				VARCHAR(60)			= NULL
 ,@BasicSalary			VARCHAR(20)			= NULL
 ,@DepartmentId			INT					= NULL
 ,@DesignationId		INT					= NULL
 ,@StartDate			DATE				= NULL
 ,@ShiftId				INT					= NULL
 ,@EmploymentTypeId		INT					= NULL
 ,@ContractFile			VARCHAR(50)			= NULL
 ,@ContractExpiry		DATE				= NULL
 ,@BankName				VARCHAR(50)			= NULL
 ,@BankBranch			VARCHAR(50)			= NULL
 ,@AccountNo			VARCHAR(50)			= NULL
 ,@AccountName			VARCHAR(50)			= NULL
 ,@IsActive				BIT					= NULL
 ,@IsSuspended			BIT					= NULL
 ,@IsFired				BIT					= NULL


 ,@flag					VARCHAR(60)			= NULL
 ,@userId				NVARCHAR(130)		= NULL
 ,@EmployeeId			INT					= NULL
 ,@EndDate				DATE				= NULL
 ,@PaySchedule			VARCHAR(40)			= NULL
 ,@OTRate				VARCHAR(20)			= NULL
 ,@WorkingHR			VARCHAR(20)			= NULL
 ,@ProfilePath			VARCHAR(100)		= NULL
AS
BEGIN

--Insert Personal Detail-------
	IF(@flag='i')
	BEGIN 
		INSERT INTO [dbo].[EmployeeDetails]
		(
			 [FirstName]
			,[MiddleName]
			,[LastName]
			,[Gender]
			,[Phone]
			,[Nationality]
			,[DOB]
			,[MaritalStatus]
			,[Ethnicity]
			,[StateId]
			,[DistrictId]
			,[Address]
			,[Email]
			,[CreatedBy]
			,[CreatedDate]
			,[IsActive]
			,[IsSuspended]
			,[IsFired]
		)
		VALUES
		(
		  @FirstName
		 ,@MiddleName
		 ,@LastName
		 ,@Gender
		 ,@Phone
		 ,@Nationality
		 ,@DOB
		 ,@MaritalStatus
		 ,@Ethnicity
		 ,@StateId
		 ,@DistrictId
		 ,@Address
		 ,@Email	
		 ,@userId
		 ,GETDATE()	 
		 ,1
		 ,0
		 ,0	
		)
		DECLARE @newId INT = (SELECT SCOPE_IDENTITY())
		EXEC spErrorHandler 0, 'AddedSuccessfully', @newId
	END


	-------Update Personal Detail-------
	IF(@flag='u')
	BEGIN
		UPDATE [dbo].EmployeeDetails
		SET	
			 [FirstName]			= @FirstName
			,[MiddleName]			= @MiddleName
			,[LastName]				= @LastName
			,[Gender]				= @Gender
			,[Phone]				= @Phone
			,[Nationality]			= @Nationality
			,[DOB]					= @DOB
			,[MaritalStatus]		= @MaritalStatus
			,[Ethnicity]			= @Ethnicity
			,[StateId]				= @StateId
			,[DistrictId]			= @DistrictId
			,[Address]				= @Address
			,[Email]				= @Email	
			,[ModifiedDate]			= GETDATE()
			,[ModifiedBy]			= @userId
		WHERE [Id] = @Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
	END


	ELSE IF(@flag='i-employment')   --insert employemnt---
	BEGIN
		INSERT INTO [dbo].[JobsHistory]
		(
			 [EmpId]
			,[DesignationId]
			,[DepartmentId]
			,[StartDate]
			,[EndDate]
			,[ShiftId]
			,[EmploymentTypeId]
			,[ContractExpiry]
			,[CreatedBy]
			,[CreatedDate]
			,[IsCurrent]
			,[Salary]
		)
		VALUES(
			@EmployeeId
		   ,@DesignationId
		   ,@DepartmentId
		   ,@StartDate
		   ,@EndDate
		   ,@ShiftId
		   ,@EmploymentTypeId
		   ,@EndDate
		   ,@userId
		   ,GETDATE()
		   ,1
		   ,0
		)

		--IF(@ContractFile IS NOT NULL AND @ContractFile <> '')
		--BEGIN
			UPDATE  [dbo].[EmployeeDetails]
			SET ContractFile = @ContractFile,
				Designation  = @DesignationId,
				StartDate	 = @StartDate,
				DepartmentId	= @DepartmentId
			WHERE Id = @EmployeeId



		DECLARE @newId1 INT = (SELECT SCOPE_IDENTITY())
		EXEC spErrorHandler 0, 'AddedSuccessfully', @newId1
	END


	------Update Employment---------

	ELSE IF(@flag='u-employment') 
	BEGIN
		UPDATE [dbo].[JobsHistory]
		SET
			 [EmpId]				= @EmployeeId
			,[DesignationId]		= @DesignationId
			,[DepartmentId]			= @DepartmentId
			,[StartDate]			= @StartDate
			,[EndDate]				= @EndDate		
			,[ShiftId]				= @ShiftId
			,[EmploymentTypeId]		= @EmploymentTypeId
			,[ContractExpiry]		= @EndDate			
			--,[Salary]				= @BasicSalary
			,[ModifyBy]				= @userId
			,[ModifiedDate]			= GETDATE()
			WHERE Id = @Id

	IF(@ContractFile IS NOT NULL AND @ContractFile <> '')
		BEGIN
			UPDATE  [dbo].[EmployeeDetails]
			SET ContractFile = @ContractFile,
				Designation  = @DesignationId,
				StartDate	 = @StartDate,
				DepartmentId  = @DepartmentId
			WHERE Id = @EmployeeId 
		END
		ELSE
		BEGIN
			UPDATE  [dbo].[EmployeeDetails]
				SET 
					Designation  = @DesignationId,
					StartDate	 = @StartDate,
					DepartmentId	= @DepartmentId
				WHERE Id = @EmployeeId 
		END

			 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null

	END


	ELSE IF(@flag='i-pay')
	BEGIN
		UPDATE [dbo].EmployeeDetails 
		SET 
		BankName	= @BankName,
		BankBranch	= @BankBranch,
		AccountNo	= @AccountNo,
		AccountName = @AccountName,
		BasicSalary	= @BasicSalary
		WHERE Id = @EmployeeId

		UPDATE [dbo].JobsHistory
		SET
		PaySchedule		= @PaySchedule,
		Salary			= @BasicSalary,
		OTRate			= @OTRate,
		WorkingHR		= @WorkingHR
		WHERE EmpId = @EmployeeId

		DECLARE @newId2 INT = (SELECT SCOPE_IDENTITY())
		EXEC spErrorHandler 0, 'AddedSuccessfully', @newId2
	END

	---Update Payment----
ELSE IF(@flag='u-pay')
 BEGIN

	UPDATE [dbo].EmployeeDetails 
		SET 
		BankName	= @BankName,
		BankBranch	= @BankBranch,
		AccountNo	= @AccountNo,
		AccountName = @AccountName,
		BasicSalary	= @BasicSalary
		WHERE Id = @EmployeeId

		UPDATE [dbo].JobsHistory
		SET
		PaySchedule		= @PaySchedule,
		Salary			= @BasicSalary,
		OTRate			= @OTRate,
		WorkingHR		= @WorkingHR
		WHERE EmpId = @EmployeeId

			 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null

	END

	ELSE IF(@flag='a')
	BEGIN
		SELECT 
				E.Id,
				FirstName +' '+ LastName AS Name,
				DP.Name AS Department,
				D.Name AS Post,
				ET.Name AS Type,
				Phone,
				Gender,
				DE.NameEn AS District, 
				Address,
				E.StartDate AS JoinedDate
		FROM EmployeeDetails E
		 INNER JOIN JobsHistory J ON E.Id = J.EmpId
		 INNER JOIN Designation D ON J.DesignationId = D.Id
		 INNER JOIN Department DP ON J.DepartmentId = DP.Id
		 INNER JOIN EmploymentTypes ET ON J.EmploymentTypeId = ET.Id
		 INNER JOIN District DE ON E.DistrictId = DE.Id
		WHERE E.IsActive =1 AND E.IsSuspended =0 AND E.IsFired=0 AND J.IsCurrent =1

	END

	ELSE IF(@flag='getPersonalById')
	BEGIN
		SELECT 
			 [Id],
			 [FirstName],
			 [MiddleName],
			 [LastName],
			 [Gender],
			 [Phone],
			 [Nationality],
			 [DOB],
			 [MaritalStatus],
			 [Ethnicity]
			,[StateId]
			,[DistrictId]
			,[Address]
			,[Email]
		FROM EmployeeDetails
		WHERE Id = @EmployeeId
	END

	ELSE IF(@flag='getEmploymentById')
	BEGIN

		SELECT
			 J.[Id]
			,J.[EmpId]
			,J.[DesignationId]
			,J.[DepartmentId]
			,J.[StartDate]
			,J.[EndDate]
			,J.[ShiftId]
			,J.[EmploymentTypeId]
			,J.[ContractExpiry]			
			,J.[IsCurrent]
			,J.[Salary]
			,E.ContractFile
		FROM  [dbo].[JobsHistory] J(NOLOCK)
		INNER JOIN [dbo].[EmployeeDetails] E ON J.EmpId = E.Id
		WHERE J.EmpId = @EmployeeId
	END

		ELSE IF(@flag='getPayById')
		BEGIN
			SELECT 
				J.Id
				,E.Id AS EmpId
				 ,E.BankName	
				,E.BankBranch
				,E.AccountNo	
				,E.AccountName
				,E.BasicSalary
				,J.PaySchedule
				,J.Salary
				,j.OTRate
				,j.WorkingHR
			FROM EmployeeDetails E (NOLOCK)
			INNER JOIN JobsHistory J ON (E.Id = J.EmpId AND J.IsCurrent=1)
			WHERE E.Id = @EmployeeId
		END

	ELSE IF(@flag='getJobHistoryById')
	BEGIN
		SELECT
				J.EmpId,
				J.DepartmentId,
				J.DesignationId,
				J.StartDate,
				J.EndDate,
				J.Salary
			FROM JobsHistory J (NOLOCK)
			WHERE J.EmpId = @EmployeeId AND J.IsCurrent =1
	END

	ELSE IF(@flag='i-newJob')
	BEGIN

	UPDATE JobsHistory
	SET IsCurrent = 0
	WHERE EmpId = @EmployeeId

		INSERT INTO [dbo].[JobsHistory]
		(
			 [EmpId]
			,[DesignationId]
			,[DepartmentId]
			,[StartDate]
			,[EndDate]
			,[ShiftId]
			,[EmploymentTypeId]
			,[ContractExpiry]
			,[CreatedBy]
			,[CreatedDate]
			,[IsCurrent]
			,[Salary]
			,[OTRate]
			,[WorkingHR]
			,[PaySchedule]
			
		)
		VALUES(
			@EmployeeId
		   ,@DesignationId
		   ,@DepartmentId
		   ,@StartDate
		   ,@EndDate
		   ,(SELECT TOP 1 ShiftId FROM JobsHistory WHERE EmpId=@EmployeeId)
		   ,(SELECT TOP 1 EmploymentTypeId FROM JobsHistory WHERE EmpId=@EmployeeId)
		   ,@EndDate
		   ,@userId
		   ,GETDATE()
		   ,1
		   ,@BasicSalary
		   ,(SELECT TOP 1 OTRate FROM JobsHistory WHERE EmpId=@EmployeeId)
		   ,(SELECT TOP 1 WorkingHR FROM JobsHistory WHERE EmpId=@EmployeeId)
		   ,(SELECT TOP 1 PaySchedule FROM JobsHistory WHERE EmpId=@EmployeeId)
		)
	
	UPDATE EmployeeDetails
	SET Designation		= @DesignationId,
		DepartmentId	= @DepartmentId,
		BasicSalary		= @BasicSalary,
		ModifiedBy		= @userId,
		ModifiedDate	= GETDATE()
	WHERE Id = @EmployeeId

 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null

	END

	ELSE IF(@flag='fire-Employee')
	BEGIN
		UPDATE EmployeeDetails
		SET
			IsFired = 1
			WHERE Id = @EmployeeId
				
			EXEC spErrorHandler 0, 'FiredSuccessfully', null

	END

	ELSE IF(@flag='suspend-Employee')
	BEGIN
		UPDATE EmployeeDetails
		SET
			IsSuspended = 1
			WHERE Id = @EmployeeId

				EXEC spErrorHandler 0, 'SuspendedSuccessfully', null

	END

	ELSE IF(@flag='upload-img')
	BEGIN
		UPDATE [dbo].[EmployeeDetails]
		SET
			ProfilePath = @ProfilePath
		WHERE Id= @EmployeeId

		EXEC spErrorHandler 0, 'ImageUploaded', null

	END

	ELSE IF(@flag='get-img')
	BEGIN
		SELECT 
			ProfilePath
		FROM [dbo].[EmployeeDetails] (NOLOCK)
		WHERE Id = @EmployeeId
	END


  ELSE IF(@flag='get-details')
	BEGIN
		SELECT	
	     E.FirstName
		,E.MiddleName
		,E.LastName
		,E.Gender
		,E.Phone
		,E.Nationality
		,E.DOB
		,E.MaritalStatus
		,E.Ethnicity
		,P.NameEn AS Province
		,D.NameEn AS District
		,E.Address
		,E.Email
		,E.BasicSalary
		,E.ProfilePath
		,E.ContractFile
		,E.BankName
		,E.BankBranch
		,E.AccountNo
		,E.AccountName
		,E.StartDate
	FROM EmployeeDetails E(NOLOCK)
	INNER JOIN Province P ON E.StateId = P.Id
	INNER JOIN District D ON E.DistrictId	= D.Id
	WHERE E.Id = @EmployeeId
	AND ISNULL(E.IsActive,1)=1 AND ISNULL(IsFired,0)=0 AND ISNULL(IsSuspended,0)=0
	-------JOB HISTORY-------------
	SELECT	
		 D.Name AS Designation,
		 DE.Name AS Department,
		 J.StartDate,
		 J.EndDate,
		 S.Name AS Shift,
		 ET.Name AS EmployementType,
		 J.Salary,
		 J.OTRate,
		 J.WorkingHR,
		 J.ContractExpiry,
		 J.PaySchedule,
		 J.IsCurrent
	FROM JobsHistory J (NOLOCK)
	INNER JOIN Designation D ON J.DesignationId = D.Id
	INNER JOIN Department DE ON J.DepartmentId	= DE.Id
	INNER JOIN EmploymentTypes ET ON J.EmploymentTypeId	= ET.Id
	INNER JOIN [Shift] S ON J.ShiftId = S.Id 
	WHERE J.EmpId = @EmployeeId

	END

END




GO
/****** Object:  StoredProcedure [dbo].[spErrorHandler]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spErrorHandler](   
  @errorCode VARCHAR(10)   
,@msg   NVARCHAR(MAX)   
,@id   NVARCHAR(50)     
)     
AS   
SET NOCOUNT ON   
SELECT @errorCode errorCode, @msg msg, @id id

GO
/****** Object:  StoredProcedure [dbo].[spFiscalYear]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spFiscalYear]
@Id						INT				= Null
,@ShortName				NVARCHAR(50)	= NULL
,@YearCode				NVARCHAR(50)	= NULL
,@StartDate				DATETIME		= NULL
,@EndDate				DATETIME		= NULL
,@CreatedDate			DATETIME		= NULL
,@ModifiedDate			DATETIME		= NULL
,@IsActive				BIT				= NULL
,@flag					VARCHAR(10)		= NULL
,@user					NVARCHAR(128)	= NULL

AS
BEGIN

IF(@flag='i')
BEGIN

IF(SELECT COUNT(Id) FROM FiscalYear(NOLOCK)) > 0
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @ShortName
			RETURN
		END
	INSERT INTO [dbo].[FiscalYear]
	(
		 [ShortName]					
		,[YearCode]
		,[StartDate]
		,[EndDate]
		,[CreatedBy]
		,[CreatedDate]		
		,[IsActive]
	)
	VALUES
	(
		 @ShortName	 
		,@YearCode		 
		,@StartDate 
		,@EndDate
		,@user
		,GETDATE()
		,1		 
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	UPDATE [dbo].[FiscalYear]
	SET
		 [ShortName]				= @ShortName
		,[YearCode]					= @YearCode
		,[StartDate]				= @StartDate
		,[EndDate]					= @EndDate
		,[ModifiedBy]				= @user
		,[ModifiedDate]				= GETDATE()
		,[IsActive]					= 1
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	DELETE from FiscalYear 
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		Id
		,[ShortName]					
		,[YearCode]
		,[StartDate]
		,[EndDate]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[FiscalYear] (NOLOCK)

END

ELSE IF(@flag='la')
BEGIN
	SELECT 
		Id
		,[ShortName]					
		,[YearCode]
		,[StartDate]
		,[EndDate]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[FiscalYear] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1
END

ELSE IF(@flag='s')
BEGIN
	SELECT 
		 Id
		,[ShortName]					
		,[YearCode]
		,[StartDate]
		,[EndDate]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[FiscalYear] (NOLOCK)
	WHERE Id=@Id
	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spGetAgentReport]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetAgentReport]
(
@from		  Date			= NULL,
@to			  DATE			= NULL,
@agentId	  INT			= NULL
)
AS
BEGIN

SELECT A.Name,A.CommissionPercentage,T.BillNo,T.PaymentMode,
T.DiscountAmount * T.exchange_rate AS DiscountAmt,
T.TaxableAmount * T.exchange_rate AS Taxable,
T.TotalVatAmount * T.exchange_rate AS VAT,
T.GrandTotal * T.exchange_rate AS GrandTotal ,
((A.CommissionPercentage/100) * (T.GrandTotal * T.exchange_rate)) AS CommissionAmt,
CAST(T.CreatedDate AS DATE) AS date
FROM Tickets T 
INNER JOIN Agents A ON T.AgentId = A.Id
WHERE CAST(T.CreatedDate AS DATE) >= CAST(@from AS DATE) AND CAST(T.CreatedDate AS DATE) <=CAST( @to AS DATE)
AND (A.Id = @agentId OR ISNULL(@agentId,'')='' )

END
GO
/****** Object:  StoredProcedure [dbo].[spGetDenominationReport]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spGetDenominationReport]
(
@from		  Date			= NULL,
@to			  DATE			= NULL,
@userId		  VARCHAR(128)	= NULL
)
AS
BEGIN

SELECT D.Rs1000,D.Rs500,D.Rs100,D.Rs50,D.Rs20,D.Rs10,D.Rs5,D.Coins,D.IC,D.SettlementRequest,D.Impression,D.Remarks,
CASE WHEN (ISNULL(D.Status,0)=0) THEN 'Open' ELSE 'Close' END Status,
CAST(D.CreatedDate AS DATE) AS CreatedDate,
 A.UserName AS Operator
 FROM Denomination D(NOLOCK)
INNER JOIN AspNetUsers A ON D.UserId = A.Id
WHERE CAST(D.CreatedDate AS DATE) >= CAST(@from AS DATE) AND CAST(D.CreatedDate AS DATE) <=CAST( @to AS DATE)
AND (D.UserId = @userId OR ISNULL(@userId,'')='' )


END
GO
/****** Object:  StoredProcedure [dbo].[spGetDiscountDetails]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spGetDiscountDetails]
(
@from date,
@to date,
@operatorId   NVARCHAR(128)	= NULL

)
AS
BEGIN

	SELECT P.name,TD.TicketNo,T.PaymentMode,
	 (TD.BaseRate * exchange_rate) AS 'taxable_amount',
	(TD.VatAmount * exchange_rate) AS 'tax_amount',
	(TD.DiscountAmount * exchange_rate) AS 'discount_amount',
	 (TD.TotalPrice * exchange_rate) AS 'grand_total',
	 TD.CreatedDate,
	 T.Description
	 FROM TicketDetail TD
	INNER JOIN TicketRate TR ON TD.TicketRateID = TR.Id
	INNER JOIN Package P ON TR.package_id = P.id
	INNER JOIN Tickets T ON TD.TicketId = T.Id
	WHERE (CAST(T.CreatedDate AS DATE) >= CAST(@from AS DATE)  
	AND CAST(T.CreatedDate AS DATE) <= CAST(@to AS DATE) )
	AND T.DiscountAmount > 0 AND  T.UserId = @operatorId OR ISNULL(@operatorId,'')=''
	order by TD.Id desc
END
GO
/****** Object:  StoredProcedure [dbo].[spGetItemBasedReport]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetItemBasedReport]
(
@from			DATE		= NULL,
@to				DATE		= NULL,
@itemId			INT			= NULL
)
AS
BEGIN
SELECT TR.name, TD.TicketNo,T.PaymentMode,
		 (TD.BaseRate * exchange_rate) AS 'taxable_amount',
		(TD.VatAmount * exchange_rate) AS 'tax_amount',
		(TD.DiscountAmount * exchange_rate) AS 'discount_amount',
		 (TD.TotalPrice * exchange_rate) AS 'grand_total',
		 TD.CreatedDate,
		 T.Description
		 FROM TicketDetail TD
		INNER JOIN TicketRate TR ON TD.TicketRateID = TR.Id
		INNER JOIN Category C ON TR.category_id = C.id
		INNER JOIN Tickets T ON TD.TicketId = T.Id
		WHERE (CAST(T.CreatedDate AS DATE) >= CAST(@from AS DATE)  
		AND CAST(T.CreatedDate AS DATE) <= CAST(@to AS DATE) )
		AND (TR.Id = @itemId OR ISNULL(@itemId,'')='')
		ORDER BY TR.name


		END


GO
/****** Object:  StoredProcedure [dbo].[spGetPackage_CategoryReport]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spGetPackage_CategoryReport]
(
@from			DATE		= NULL,
@to				DATE		= NULL,
@packageId		INT			= NULL,
@categoryId		INT			= NULL,
@operatorId   NVARCHAR(128)	= NULL,

@flag			VARCHAR(40)	= NULL


)
AS
BEGIN

IF(@flag='package')
BEGIN
	SELECT P.name,TD.TicketNo,T.PaymentMode,
		 (TD.BaseRate * exchange_rate) AS 'taxable_amount',
		(TD.VatAmount * exchange_rate) AS 'tax_amount',
		(TD.DiscountAmount * exchange_rate) AS 'discount_amount',
		 (TD.TotalPrice * exchange_rate) AS 'grand_total',
		 TD.CreatedDate,
		 T.Description
		 FROM TicketDetail TD
		INNER JOIN TicketRate TR ON TD.TicketRateID = TR.Id
		INNER JOIN Package P ON TR.package_id = P.id
		INNER JOIN Tickets T ON TD.TicketId = T.Id
		WHERE (CAST(T.CreatedDate AS DATE) >= CAST(@from AS DATE)  
		AND CAST(T.CreatedDate AS DATE) <= CAST(@to AS DATE) )
		AND (TR.package_id = @packageId OR ISNULL(@packageId,'')='')
		order by P.name
END

ELSE IF(@flag='category')
BEGIN
SELECT C.name,TD.TicketNo,T.PaymentMode,
		 (TD.BaseRate * exchange_rate) AS 'taxable_amount',
		(TD.VatAmount * exchange_rate) AS 'tax_amount',
		(TD.DiscountAmount * exchange_rate) AS 'discount_amount',
		 (TD.TotalPrice * exchange_rate) AS 'grand_total',
		 TD.CreatedDate,
		 T.Description
		 FROM TicketDetail TD
		INNER JOIN TicketRate TR ON TD.TicketRateID = TR.Id
		INNER JOIN Category C ON TR.category_id = C.id
		INNER JOIN Tickets T ON TD.TicketId = T.Id
		WHERE (CAST(T.CreatedDate AS DATE) >= CAST(@from AS DATE)  
		AND CAST(T.CreatedDate AS DATE) <= CAST(@to AS DATE) )
		AND (TR.category_id = @categoryId OR ISNULL(@categoryId,'')='')
		order by C.name
END

	END
GO
/****** Object:  StoredProcedure [dbo].[spLeaveApplications]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spLeaveApplications]
 @Id					INT				= NUll

,@DepartmentId			INT				= NULL
,@EmployeeId			INT				= NULL
,@Reason				VARCHAR(50)		= NULL
,@Type					VARCHAR(50)		= NULL

,@FromDate				DATE			= NULL
,@ToDate				DATE			= NULL
,@Remarks				VARCHAR(300)	= NULL
,@Status				VARCHAR(50)		= NULL
,@flag					VARCHAR(20)		= NULL
,@IsActive				BIT				= NULL
,@UserId				NVARCHAR(128)	= NULL
AS
BEGIN

IF(@flag='i')
BEGIN
	INSERT INTO [dbo].[LeaveApplications]
	(
		 [DepartmentId]
		,[EmployeeId]
		,[Reason]
		,[Type]
		,[FromDate]
		,[ToDate]
		,[Remarks]
		,[Status]
		,[CreatedBy]
		,[CreatedDate]		 
		,[IsDeleted]
	)
	VALUES
	(
		 @DepartmentId
		,@EmployeeId
		,@Reason
		,@Type
		,@FromDate
		,@ToDate
		,@Remarks
		,'Pending'
		,@UserId		 
		,GETDATE()
		,0
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	
	UPDATE [dbo].[LeaveApplications]
	SET
		DepartmentId	= @DepartmentId,
		EmployeeId		= @EmployeeId,
		Reason			= @Reason,
		Type			= @Type,
		FromDate		= @FromDate,
		ToDate			= @ToDate,
		Remarks			= @Remarks,
		--Status			= @Status,
		ModifiedBy		= @UserId,
		ModifiedDate	= GETDATE()
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	Update LeaveApplications 
	SET IsDeleted = 1
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT	
		L.Id,
		D.Name AS Department,
		E.FirstName +' '+ E.LastName AS Name,
		L.Reason,
		L.Type,
		L.FromDate,
		L.ToDate,
		L.Remarks,
		L.Status
	FROM [dbo].[LeaveApplications] L (NOLOCK)
	INNER JOIN Department D ON L.DepartmentId = D.Id
	INNER JOIN EmployeeDetails E ON L.EmployeeId = E.Id
	WHERE ISNULL(L.IsDeleted,0)<>1

END


ELSE IF(@flag='s')
BEGIN
	SELECT 
		 Id
		,DepartmentId
		,EmployeeId
		,Reason
		,[Type]
		,FromDate
		,ToDate
		,Remarks
		,Status
		,IsDeleted
	FROM [dbo].[LeaveApplications] (NOLOCK)
	WHERE Id=@Id
END

ELSE IF(@flag='action')
BEGIN
	UPDATE [dbo].LeaveApplications
	SET
		 Status			= @Status
		,ModifiedBy		= @UserId
		,ModifiedDate	= GETDATE()
	WHERE Id = @Id
	EXEC spErrorHandler 0, 'StatusUpdated', null

END


END









GO
/****** Object:  StoredProcedure [dbo].[spPackage]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spPackage]
 @Id					INT				= Null
,@Name					VARCHAR(100)	= NULL
,@Code					VARCHAR(50)		=NULL
,@flag					VARCHAR(10)		= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
	INSERT INTO [dbo].[Package]
	(
		 [Name]	
		,[code]
	)
	VALUES
	(
		 @Name
		,@Code		 
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	UPDATE [dbo].[Package]
	SET
		 [Name]			= @Name
		,[code]			= @Code
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	DELETE from Package 
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT
		Id 
		 ,[Name]	
		 ,[code]
	FROM [dbo].[Package] (NOLOCK)

END

ELSE IF(@flag='s')
BEGIN
	SELECT
		Id 
		,[Name]	
		,[code]
	FROM [dbo].[Package] (NOLOCK)
	WHERE Id=@Id	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spRole]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spRole]
	 @flag		 VARCHAR(50)
	,@user		 NVARCHAR(128)	=	NULL
	,@Name		 VARCHAR(100)	=	NULL
	,@Id		 NVARCHAR(128)	=	NULL
	
AS
BEGIN
	IF(@flag='i')
	BEGIN
		INSERT INTO [dbo].AspNetRoles
		(
			[Name],
			[CreatedBy],
			[CreatedDate],
			[IsDeleted]
		)
		VALUES(
			@Name,
			@user,
			GETDATE(),
			0
		)

		EXEC spErrorHandler 0, 'AddedSuccessfully', NULL
	END
	ELSE IF(@flag='u')
	BEGIN
		UPDATE [dbo].AspNetRoles
		SET
			 ModifiedBy = @user
			,ModifiedDate = GETDATE()
			,Name=@Name
		WHERE Id=@id

		EXEC spErrorHandler 0, 'UpdatedSuccessfully', NULL
	END
	ELSE IF(@flag='d')
	BEGIN
		UPDATE [dbo].AspNetRoles 
		SET IsDeleted=1
			,ModifiedBy=@user
			,ModifiedDate=GETDATE()
		WHERE id=@id
		EXEC spErrorHandler 0, 'DeletedSuccessfully', NULL
	END
	ELSE IF(@flag='a')
	BEGIN
		SELECT  Name
				,Id
				,CreatedBy
		FROM [dbo].AspNetRoles(NOLOCK)
		WHERE  ISNULL(IsDeleted,0)<>1			
	END
	ELSE IF(@flag='s')
	BEGIN
		SELECT Id
				,Name
			,CreatedBy
			,CreatedDate
		FROM [dbo].AspNetRoles(NOLOCK)
		WHERE Id=@id
	END
	
END




GO
/****** Object:  StoredProcedure [dbo].[spSequence]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSequence]
@Id						INT				= Null
,@Type					NVARCHAR(50)	= NULL
,@ModuleId				INT				= NULL
,@SequenceNo			INT				= NULL
,@CreatedBy				NVARCHAR(30)	= NULL
,@CreatedDate			DATETIME		= NULL
,@ModifiedBy			NVARCHAR(30)	= NULL
,@ModifiedDate			DATETIME		= NULL
,@IsActive				BIT				= NULL
,@flag					VARCHAR(10)		= NULL
,@user					NVARCHAR(50)	= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
	INSERT INTO [dbo].[Sequence]
	(
		 [Type]					
		,[ModuleId]
		,[SequenceNo]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	)
	VALUES
	(
		 @Type	 
		,@ModuleId
		,@SequenceNo
		,@CreatedBy
		,@CreatedDate
		,@ModifiedBy
		,@ModifiedDate
		,@IsActive		 
	)
END


ELSE IF(@flag='u')
BEGIN
	UPDATE [dbo].[Sequence]
	SET
		 [Type]						= @Type
		,[ModuleId]					= @ModuleId
		,[SequenceNo]				= @SequenceNo
		,[CreatedBy]				= @CreatedBy
		,[CreatedDate]				= @CreatedDate
		,[ModifiedBy]				= @ModifiedBy
		,[ModifiedDate]				= @ModifiedDate
		,[IsActive]					= @IsActive
	 WHERE [id]=@Id
 END


ELSE IF(@flag='d')
BEGIN
	DELETE from Sequence 
	Where Id = @Id
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		 [Type]					
		,[ModuleId]
		,[SequenceNo]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[Sequence] (NOLOCK)

END

ELSE IF(@flag='la')
BEGIN
	SELECT 
		 [Type]					
		,[ModuleId]
		,[SequenceNo]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[Sequence] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1
END

ELSE IF(@flag='s')
BEGIN
	SELECT 
		 [Type]					
		,[ModuleId]
		,[SequenceNo]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[Sequence] (NOLOCK)
	WHERE Id=@Id
	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spSettings]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSettings] 
 @Id				INT				= Null
,@TaxType			NVARCHAR(30)	= NULL
,@TaxPercentage		DECIMAL(18,2)	= NULL
,@flag				VARCHAR(10)		= NULL
,@user				NVARCHAR(50)	= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
IF EXISTS (SELECT TOP 1 'X' FROM [dbo].[Settings] WHERE TaxType=@TaxType)
	BEGIN
	  EXEC spErrorHandler 1, 'AlreadyExists', @TaxType
	  RETURN
	END  

	INSERT INTO [dbo].[Settings]
	(
		 [TaxType],
		 [TaxPercentage],
		 [Date],
		 [IsActive]
	)
	VALUES
	(
		@TaxType,
		@TaxPercentage,
		GETDATE(),
		1	 
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
IF EXISTS (SELECT TOP 1 'X' FROM [dbo].[Settings] WHERE TaxType=@TaxType AND Id <> @Id)
	BEGIN
	  EXEC spErrorHandler 1, 'AlreadyExists', @TaxType
	  RETURN
	END  

	UPDATE [dbo].[Settings]
	SET
		  [TaxType]			= @TaxType
		 ,[TaxPercentage]	= @TaxPercentage
		 ,[Date]			= GETDATE()
		 ,[IsActive]		= 1
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	DELETE from Settings 
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		 Id
		,[TaxType]
		,[TaxPercentage]
		,[Date]
		,[IsActive]
	FROM [dbo].[Settings] (NOLOCK)

END

ELSE IF(@flag='la')
BEGIN
	SELECT 
		 Id
		,[TaxType]
		,[TaxPercentage]
		,[Date]
		,[IsActive]
	FROM [dbo].[Settings] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1
END

ELSE IF(@flag='s')
BEGIN
	SELECT
		 Id
		,[TaxType]
		,[TaxPercentage]
		,[Date]
		,[IsActive]
	FROM [dbo].[Settings] (NOLOCK)
	WHERE Id=@Id	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spShift]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spShift]
 @Id					INT				= Null
,@Name					VARCHAR(50)		= NULL
,@StartTime				TIME(7)			= NULL
,@EndTime				TIME(7)			= NULL

,@flag					VARCHAR(20)		= NULL
,@IsActive				BIT				= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
IF EXISTS(SELECT  'X' FROM [Shift](NOLOCK) WHERE  Name=@Name)
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	INSERT INTO [dbo].[Shift]
	(
		 [Name]		
		,[StartTime]
		,[EndTime]			
		,[IsActive]
		,[IsDeleted]
	)
	VALUES
	(
		 @Name	
		,@StartTime
		,@EndTime
		,@IsActive	
		,0
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	IF EXISTS(SELECT  'X' FROM [Shift](NOLOCK) WHERE  Id <> @Id AND (Name=@Name))
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	UPDATE [dbo].[Shift]
	SET
		 [Name]				= @Name		
		,[StartTime]		= @StartTime
		,[EndTime]			= @EndTime
		,[IsActive]			= @IsActive
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	Update [Shift] 
	SET IsDeleted = 1
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
	     Id
		,[Name]	
		,[StartTime]
		,[EndTime]						
		,[IsActive]
	FROM [dbo].[Shift] (NOLOCK)
	WHERE ISNULL(IsDeleted,0)<>1

END

ELSE IF(@flag='la')
BEGIN
	SELECT 
		 Id
		,[Name]	
		,[StartTime]
		,[EndTime]						
		,[IsActive]

	FROM [dbo].[Shift] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1 AND ISNULL(IsDeleted,0)<>1
END

ELSE IF(@flag='s')
BEGIN
	SELECT 
	    	Id
		,[Name]	
		,[StartTime]
		,[EndTime]						
		,[IsActive]
	FROM [dbo].[Shift] (NOLOCK)
	WHERE Id=@Id
	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spStation]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spStation]
 @Id					INT				= Null
,@Name					VARCHAR(100)	= NULL
,@User					NVARCHAR(128)	= NULL
,@IsActive				BIT				= NULL
,@flag					VARCHAR(10)		= NULL

AS
BEGIN
IF(@flag='i')
BEGIN
IF EXISTS(SELECT  'X' FROM Station(NOLOCK) WHERE  Name=@Name)
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	INSERT INTO [dbo].[Station]
	(
		 [Name]	
		,[CreatedBy]
		,[CreatedDate]
		,[IsActive]
	)
	VALUES
	(
		 @Name
		,@User
		,GETDATE()
		,@IsActive
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END

ELSE IF(@flag='u')
BEGIN
IF EXISTS(SELECT  'X' FROM Station(NOLOCK) WHERE  Id <> @Id AND (Name=@Name))
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	UPDATE [dbo].[Station]
	SET
		 [Name]			= @Name,
		 [IsActive]		= @IsActive,
		 [ModifiedBy]	= @User,
		 [ModifiedDate]	= GETDATE()
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END

ELSE IF(@flag='d')
BEGIN
	DELETE from Station 
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT
		  Id 
		 ,[Name]	
		 ,[IsActive]
	FROM [dbo].[Station] (NOLOCK)

END

ELSE IF(@flag='s')
BEGIN
	SELECT
		Id 
		,[Name]	
		,[IsActive]
	FROM [dbo].[Station] (NOLOCK)
	WHERE Id=@Id	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spTicketCategory]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTicketCategory]
@Id						INT				= Null
,@Type					NVARCHAR(50)	= NULL
,@Unit					NVARCHAR(25)	= NULL
,@CategoryId			INT				= NULL
,@CreatedBy				NVARCHAR(30)	= NULL
,@CreatedDate			DATETIME		= NULL
,@ModifiedBy			NVARCHAR(30)	= NULL
,@ModifiedDate			DATETIME		= NULL
,@IsActive				BIT				= NULL
,@flag					VARCHAR(10)		= NULL
,@user					NVARCHAR(50)	= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
	INSERT INTO [dbo].[TicketCategory]
	(
		 [Type]	
		,[Unit]
		,[CategoryId]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	)
	VALUES
	(
		 @Type
		,@Unit
		,@CategoryId
		,@CreatedBy
		,@CreatedDate
		,@ModifiedBy
		,@ModifiedDate
		,@IsActive		 
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	UPDATE [dbo].[TicketCategory]
	SET
		 [Type]						= @Type
		,[Unit]						= @Unit
		,[CategoryId]				= @CategoryId
		,[CreatedBy]				= @CreatedBy
		,[CreatedDate]				= @CreatedDate
		,[ModifiedBy]				= @ModifiedBy
		,[ModifiedDate]				= @ModifiedDate
		,[IsActive]					= @IsActive
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	DELETE from TicketCategory 
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT
		Id 
		,[Type]	
		,[Unit]
		,[CategoryId]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[TicketCategory] (NOLOCK)

END

ELSE IF(@flag='la')
BEGIN
	SELECT
		Id 
		,[Type]	
		,[Unit]
		,[CategoryId]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[TicketCategory] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1
END

ELSE IF(@flag='s')
BEGIN
	SELECT 
		Id
		,[Type]	
		,[Unit]
		,[CategoryId]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[TicketCategory] (NOLOCK)
	WHERE Id=@Id
	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spTicketDetail]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTicketDetail]
@Id						INT				= Null
,@TicketId				INT				= NULL
,@TicketNo				INT				= NULL
,@LocalTaxAmount		money			= NULL
,@VatAmount				money			= NULL
,@DiscountAmount		money			= NULL
,@BaseRate				money			= NULL
,@TotalAfterTax			money			= NULL
,@Currency				nvarchar(50)	= NULL
,@TicketValidity		datetime		= NULL
,@ExpireDate			datetime		= NULL
,@BarCode				nvarchar(50)	= NULL
,@TotalPrice			money			= NULL
,@BranchName			nvarchar(30)	= NULL
,@OneWay				BIT				= NULL
,@TwoWay				BIT				= NULL
,@CreatedBy				NVARCHAR(30)	= NULL
,@CreatedDate			DATETIME		= NULL
,@ModifiedBy			NVARCHAR(30)	= NULL
,@ModifiedDate			DATETIME		= NULL
,@IsActive				BIT				= NULL
,@flag					VARCHAR(10)		= NULL
,@user					NVARCHAR(50)	= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
	INSERT INTO [dbo].[TicketDetail]
	(
		 [TicketId]	
		,[TicketNo]
		,[LocalTaxAmount]
		,[VatAmount]
		,[DiscountAmount]
		,[BaseRate]
		,[TotalAfterTax]
		,[Currency]
		,[TicketValidity]
		,[ExpireDate]
		,[BarCode]
		,[TotalPrice]
		,[BranchName]
		,[OneWay]
		,[TwoWay]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	)
	VALUES
	(
		 @TicketId	
		,@TicketNo
		,@LocalTaxAmount
		,@VatAmount
		,@DiscountAmount
		,@BaseRate
		,@TotalAfterTax
		,@Currency
		,@TicketValidity
		,@ExpireDate
		,@BarCode
		,@TotalPrice
		,@BranchName
		,@OneWay
		,@TwoWay
		,@CreatedBy
		,@CreatedDate
		,@ModifiedBy
		,@ModifiedDate
		,@IsActive		 
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	UPDATE [dbo].[TicketDetail]
	SET
		 [TicketId]					= @TicketId
		,[TicketNo]					= @TicketNo
		,[LocalTaxAmount]			= @LocalTaxAmount
		,[VatAmount]				= @VatAmount
		,[DiscountAmount]			= @DiscountAmount
		,[BaseRate]					= @BaseRate
		,[TotalAfterTax]			= @TotalAfterTax
		,[Currency]					= @Currency
		,[TicketValidity]			= @TicketValidity
		,[ExpireDate]				= @ExpireDate
		,[BarCode]					= @BarCode
		,[TotalPrice]				= @TotalPrice
		,[BranchName]				= @BranchName
		,[OneWay]					= @OneWay
		,[TwoWay]					= @TwoWay
		,[CreatedBy]				= @CreatedBy
		,[CreatedDate]				= @CreatedDate
		,[ModifiedBy]				= @ModifiedBy
		,[ModifiedDate]				= @ModifiedDate
		,[IsActive]					= @IsActive
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	DELETE from TicketDetail 
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		Id
		, [TicketId]	
		,[TicketNo]
		,[LocalTaxAmount]
		,[VatAmount]
		,[DiscountAmount]
		,[BaseRate]
		,[TotalAfterTax]
		,[Currency]
		,[TicketValidity]
		,[ExpireDate]
		,[BarCode]
		,[TotalPrice]
		,[BranchName]
		,[OneWay]
		,[TwoWay]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[TicketDetail] (NOLOCK)

END

ELSE IF(@flag='la')
BEGIN
	SELECT
		Id 
		,[TicketId]	
		,[TicketNo]
		,[LocalTaxAmount]
		,[VatAmount]
		,[DiscountAmount]
		,[BaseRate]
		,[TotalAfterTax]
		,[Currency]
		,[TicketValidity]
		,[ExpireDate]
		,[BarCode]
		,[TotalPrice]
		,[BranchName]
		,[OneWay]
		,[TwoWay]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[TicketDetail] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1
END

ELSE IF(@flag='s')
BEGIN
	SELECT 
		Id
		,[TicketId]	
		,[TicketNo]
		,[LocalTaxAmount]
		,[VatAmount]
		,[DiscountAmount]
		,[BaseRate]
		,[TotalAfterTax]
		,[Currency]
		,[TicketValidity]
		,[ExpireDate]
		,[BarCode]
		,[TotalPrice]
		,[BranchName]
		,[OneWay]
		,[TwoWay]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[TicketDetail] (NOLOCK)
	WHERE Id=@Id
	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spTicketRate]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spTicketRate]
 @Id					INT				= Null
,@Name					VARCHAR(100)	= NULL
,@Code					BIGINT			= NULL
,@Category_id			BIGINT			= NULL
,@Type_id				BIGINT			= NULL
,@Package_id			BIGINT			= NULL
,@Currency				VARCHAR(50)		= NULL
,@BaseRate				MONEY			= NULL
,@LocalTax				MONEY			= NULL
,@VAT					MONEY			= NULL
,@Total					MONEY			= NULL
,@RoundOff				MONEY			= NULL
,@GrandTotal			MONEY			= NULL

,@User					NVARCHAR(128)	= NULL
,@IsActive				BIT				= NULL
,@flag					VARCHAR(10)		= NULL

AS
BEGIN
IF(@flag='i')
BEGIN
IF EXISTS(SELECT  'X' FROM TicketRate(NOLOCK) WHERE  Name=@Name OR Code = @Code)
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	INSERT INTO [dbo].[TicketRate]
	(
		 [Name]	
		,[Code]
		,[category_id]
		,[type_id]
		,[package_id]
		,[Currency]
		,[base_rate]
		,[local_tax]
		,[vat]
		,[total]
		,[round_of]
		,[grand_total]
		,[CreatedBy]
		,[CreatedDate]
		,[IsActive]
	)
	VALUES
	(
		 @Name
		,@Code
		,@Category_id
		,@Type_id
		,@Package_id
		,@Currency
		,@BaseRate
		,@LocalTax
		,@VAT
		,@Total
		,@RoundOff
		,@GrandTotal

		,@User
		,GETDATE()
		,@IsActive
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END

ELSE IF(@flag='u')
BEGIN
IF EXISTS(SELECT  'X' FROM TicketRate(NOLOCK) WHERE  Id <> @Id AND (Name=@Name OR Code = @Code))
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	UPDATE [dbo].[TicketRate]
	SET
		 [Name]			= @Name,
		 [Code]			= @Code,
		 [category_id]	= @Category_id,
		 [type_id]		= @Type_id,
		 [package_id]	= @Package_id,
		 [Currency]		= @Currency,
		 [base_rate]	= @BaseRate,
		 [local_tax]	= @LocalTax,
		 [vat]			= @VAT,
		 [total]		= @Total,
		 [round_of]		= @RoundOff,
		 [grand_total]	= @GrandTotal,	
	
		 [IsActive]		= @IsActive,
		 [ModifiedBy]	= @User,
		 [ModifiedDate]	= GETDATE()
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END

ELSE IF(@flag='d')
BEGIN
	DELETE from TicketRate 
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT
		  T.Id 
		 ,T.[Name]	
		 ,T.[Code]
		 ,C.Name AS Category
		 ,TP.Type AS Type
		 ,P.name AS Package
		 ,T.[Currency]
		 ,T.[base_rate]
		 ,T.[local_tax]
		 ,T.[vat]
		 ,T.[total]
		 ,T.[round_of]
		 ,T.[grand_total]
		 ,T.[IsActive]
	FROM [dbo].[TicketRate]  T(NOLOCK)
	INNER JOIN Package P ON T.package_id = P.id
	LEFT JOIN Category C ON T.category_id = C.Id 
	LEFT JOIN Type TP ON T.type_id = TP.Id
	ORDER BY C.Name
END


ELSE IF(@flag='la')
BEGIN
	SELECT
		  T.Id 
		 ,T.[Name]	
		 ,T.[Code]
		 ,C.Name AS Category
		 ,TP.Type AS Type
		 ,P.name AS Package
		 ,T.[Currency]
		 ,T.[base_rate]
		 ,T.[local_tax]
		 ,T.[vat]
		 ,T.[total]
		 ,T.[round_of]
		 ,T.[grand_total]
		 ,T.[IsActive]
	FROM [dbo].[TicketRate]  T(NOLOCK)
	INNER JOIN Package P ON T.package_id = P.id
	LEFT JOIN Category C ON T.category_id = C.Id 
	LEFT JOIN Type TP ON T.type_id = TP.Id
	WHERE ISNULL(T.IsActive,1)=1
		ORDER BY C.Name

END

ELSE IF(@flag='s')
BEGIN
	SELECT
		  Id 
		 ,[Name]	
		 ,[Code]
		 ,[category_id]
		 ,[type_id]
		 ,[package_id]
		 ,[Currency]
		 ,[base_rate]
		 ,[local_tax]
		 ,[vat]
		 ,[total]
		 ,[round_of]
		 ,[grand_total]

		 ,[IsActive]
	FROM [dbo].[TicketRate] (NOLOCK)
	WHERE Id=@Id	
END
END









GO
/****** Object:  StoredProcedure [dbo].[spUser]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUser]
 @Id					INT				= Null
,@Username				NVARCHAR(50)	= NULL
,@Password				NVARCHAR(300)	= NULL
,@Role					INT				= NULL
,@CreatedBy				NVARCHAR(50)	= NULL
,@CreatedDate			DATETIME		= NULL
,@ModifiedBy			NVARCHAR(50)	= NULL
,@ModifiedDate			DATETIME		= NULL
,@IsActive				BIT				= NULL
,@flag					VARCHAR(10)		= NULL
,@IsBlocked				BIT				= NULL
,@user					NVARCHAR(50)	= NULL

AS
BEGIN
	
IF(@flag='i')
BEGIN
	INSERT INTO [dbo].[Users]
	(
		 [Username]	
		,[Password]	
		,[Role]			
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
		,[IsBlocked]
	)
	VALUES
	(
		 @Username
		,@Password
		,@Role
		,@CreatedBy
		,GETDATE()
		,@ModifiedBy
		,@ModifiedDate
		,1
		,@IsBlocked		 
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	UPDATE [dbo].[Users]
	SET
		 [Username]				 	= @Username
		,[Password]					= @Password
		,[Role]						= @Role
		,[ModifiedBy]				= @ModifiedBy
		,[ModifiedDate]				= GETDATE()
		,[IsActive]					= 1
		,[IsBlocked]				= @IsBlocked
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END

 
ELSE IF(@flag='d')
BEGIN
	DELETE from Users 
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		Id
		,[Username]					
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[Users] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1

END


ELSE IF(@flag='s')
BEGIN
	SELECT
		Id
		,[Username]					
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
	FROM [dbo].[Users] (NOLOCK)
	WHERE Id=@Id
	
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spUserProfile]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spUserProfile]
	 @flag				VARCHAR(50)
	,@user				NVARCHAR(128) 
	,@id				NVARCHAR(128)	= NULL
	,@userName			VARCHAR(100)	= NULL
	,@phone				VARCHAR(15)		= NULL
	,@mobile			VARCHAR(15)		= NULL
	,@firstName			NVARCHAR(15)	= NULL
	,@middleName		NVARCHAR(15)	= NULL
	,@lastName			NVARCHAR(15)	= NULL
	,@gender			NVARCHAR(8)		= NULL
	,@dob				DATE			= NULL
	,@state				SMALLINT		= NULL
	,@vdcMunc			SMALLINT		= NULL
	,@district			SMALLINT		= NULL
	,@city				NVARCHAR(50)	= NULL
	,@address			NVARCHAR(200)	= NULL
	,@wardNo			SMALLINT		= NULL
	,@menuIds			VARCHAR(MAX)	= NULL
	,@roleIds			VARCHAR(MAX)	= NULL
	,@HashPassword		NVARCHAR(MAX)	= NULL
	,@employee			INT				= NULL
	,@email				VARCHAR(30)		= NULL
AS
BEGIN
	IF(@flag='i')
	BEGIN TRY
	    BEGIN TRANSACTION SCHEDULEUPDATE
		DECLARE @RoleName VARCHAR(50)
		SET @RoleName =(SELECT Name FROM AspNetRoles WHERE Id=@roleIds AND ISNULL(IsDeleted,0)<>1)

		UPDATE [dbo].AspNetUsers
		SET
			 CreatedBy = @user
			,CreatedDate = GETDATE()
			,PasswordDesk = @HashPassword
		WHERE UserName=@userName

		INSERT INTO UserProfile(UserId,PhoneNumber,Mobile,FirstName,MiddleName,LastName,Gender,DOB,State,District,VDCMunc,City,Address,WardNo,EmployeeId)
		SELECT @id,@phone,@mobile,@firstName,@middleName,@lastName,@gender,@dob,@state,@district,@vdcMunc,@city,@address,@wardNo,@employee

		-----------ROlE ASSIGNED-------------
			INSERT INTO [dbo].[AspNetUserRoles]
				(
				 [RoleId],
				 [UserId],
				 [CreatedBy],
				 [CreatedDate]
				)
				VALUES
				(
				  @roleIds,
				  @id,
				  @user,
				  GETDATE()	 
				)
		COMMIT TRANSACTION SCHEDULEUPDATE
		EXEC spErrorHandler 0, 'AddedSuccessfully', NULL
		 END TRY

	BEGIN CATCH
		IF (@@TRANCOUNT > 0)
		 BEGIN
			ROLLBACK TRANSACTION SCHEDULEDELETE
			PRINT 'Error detected, all changes reversed'
			Declare @errormsg nvarchar(max)	
			  SELECT @errormsg= ERROR_MESSAGE() +' line ' + ERROR_LINE()
        --ERROR_NUMBER() AS ErrorNumber,
        --ERROR_SEVERITY() AS ErrorSeverity,
        --ERROR_STATE() AS ErrorState,
        --ERROR_PROCEDURE() AS ErrorProcedure,
        --ERROR_LINE() AS ErrorLine,
        --ERROR_MESSAGE() AS ErrorMessage
			EXEC spErrorHandler 1, @errormsg, NULL		
		  END  
	END CATCH

	ELSE IF(@flag='u')
	BEGIN
		UPDATE [dbo].AspNetUsers
		SET
			 ModifiedBy = @user
			,ModifiedDate = GETDATE()
		WHERE Id=@id

		UPDATE UserProfile
		SET  PhoneNumber=@phone
			,Mobile=@mobile
			,FirstName=@firstName
			,MiddleName=@middleName
			,LastName=@lastName
			,Gender=@gender
			,DOB=@dob
			,State=@state
			,District=@district
			,VDCMunc=@vdcMunc
			,City=@city
			,Address=@address
			,WardNo=@wardNo
		WHERE UserId=@id

		EXEC spErrorHandler 0, 'UpdatedSuccessfully', NULL
	END
	ELSE IF(@flag='d')
	BEGIN
		UPDATE [dbo].AspNetUsers 
		SET IsDeleted=1
			,ModifiedBy=@user
			,ModifiedDate=GETDATE()
		WHERE id=@id
		EXEC spErrorHandler 0, 'DeletedSuccessfully', NULL
	END

	ELSE IF(@flag='u-user')
	BEGIN
	UPDATE [dbo].AspNetUsers
		SET
   			 UserName	= @userName
			,Email		= @email
			,ModifiedBy = @user
			,ModifiedDate = GETDATE()
		WHERE Id=@id


		--------UPDATE ROLE------------
		UPDATE [dbo].[AspNetUserRoles]
		SET
			UserId	= @id,
			RoleId	= @roleIds,
			CreatedDate	= GETDATE(),
			CreatedBy	= @user
		WHERE UserId = @id
				EXEC spErrorHandler 0, 'UpdatedSuccessfully', NULL

	END

	ELSE IF(@flag='a')
	BEGIN
		SELECT  
			   U.UserName
			  ,U.Email
			  ,U.Id AS UserId
			  ,UP.FirstName+' '+ISNULL(UP.MiddleName,'')+' '+ISNULL(UP.LastName,'') AS Name
			  ,UP.Gender
			  ,UP.Address
			  ,UP.PhoneNumber
			  ,UP.Mobile
			  ,UP.DOB
	    FROM [dbo].AspNetUsers U(NOLOCK)
		LEFT JOIN UserProfile UP(NOLOCK) ON U.Id=UP.UserId
		WHERE  ISNULL(U.IsDeleted,0)<>1			
	END
	ELSE IF(@flag='s')
	BEGIN
		SELECT  
			   U.UserName
			  ,U.Email
			  ,U.Id AS UserId
			  ,UP.FirstName
			  ,UP.MiddleName
			  ,UP.LastName
			  ,UP.Gender
			  ,UP.Address
			  ,UP.PhoneNumber
			  ,UP.Mobile
			  ,UP.State
			  ,UP.District
			  ,UP.VDCMunc
			  ,UP.City
			  ,UP.WardNo
			  ,UP.DOB
			  ,UP.EmployeeId
			  ,AR.RoleId
		FROM [dbo].AspNetUsers U(NOLOCK)
		LEFT JOIN UserProfile UP(NOLOCK) ON U.Id=UP.UserId	
		LEFT JOIN AspNetUserRoles AR(NOLOCK) ON U.Id = AR.UserId
		WHERE  U.Id=@id	
	END
	
	 ELSE IF(@flag='fetch-userroles')
	  BEGIN 
		SELECT RoleId=r.Id
				,RoleName=r.Name
				,UserId=userRole.RoleId 
		FROM AspNetRoles r(NOLOCK)
		LEFT JOIN(
		SELECT RoleId FROM AspNetUserRoles ur(NOLOCK) WHERE ur.UserId=@id
		)userRole ON r.Id=userRole.RoleId
		WHERE ISNULL(r.IsDeleted,0)=0
	  END
	ELSE IF(@flag='user-info')
	BEGIN 
		SELECT TOP 1 FullName=ISNULL(up.FirstName,'')+' '+ISNULL(up.MiddleName,'')+' '+ISNULL(up.LastName,'')
				,CompanyId=(SELECT TOP 1 Id FROM CompanyInfo)
				,CompanyName=(SELECT TOP 1 Name FROM CompanyInfo)
				,CompanyCode='01'
				,Email=u.Email
				,Phone=COALESCE(up.Mobile,up.PhoneNumber,'')
				,SessionTimeOut=u.SessionTimeOut
				,DOB=up.DOB
				,Gender=up.Gender
				,(SELECT TOP 1 YearCode FROM FiscalYear WHERE ISNULL(IsActive,0)=1) AS Fiscal
		FROM AspNetUsers u(NOLOCK) 
		LEFT JOIN UserProfile up(NOLOCK) ON u.Id=up.UserId
		WHERE u.Id=@user AND ISNULL(u.IsDeleted,0)<>1
	END
END



select * from FiscalYear
GO
/****** Object:  StoredProcedure [dbo].[spWorkingPoints]    Script Date: 2020-11-30 11:46:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spWorkingPoints]
 @Id					INT				= Null
,@Name					VARCHAR(50)		= NULL
,@flag					VARCHAR(20)		= NULL
,@Code					VARCHAR(20)		= NULL
,@IsActive				BIT				= NULL

AS
BEGIN

IF(@flag='i')
BEGIN
IF EXISTS(SELECT  'X' FROM WorkingPoints(NOLOCK) WHERE  Name=@Name)
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	INSERT INTO [dbo].[WorkingPoints]
	(
		 [Name]		
		,[Code]			
		,[IsActive]
		,[IsDeleted]
	)
	VALUES
	(
		 @Name	
		,@Code
		,@IsActive	
		,0
	)
	EXEC spErrorHandler 0, 'AddedSuccessfully', null
END


ELSE IF(@flag='u')
BEGIN
	IF EXISTS(SELECT  'X' FROM WorkingPoints(NOLOCK) WHERE  Id <> @Id AND (Name=@Name))
		BEGIN
			EXEC spErrorHandler 2, 'AlreadyExists', @Name
			RETURN
		END

	UPDATE [dbo].[WorkingPoints]
	SET
		 [Name]				= @Name		
		,[Code]				= @Code
		,[IsActive]			= @IsActive
	 WHERE [id]=@Id
	 EXEC spErrorHandler 0, 'UpdatedSuccessfully', null
 END


ELSE IF(@flag='d')
BEGIN
	Update WorkingPoints 
	SET IsDeleted = 1
	Where Id = @Id
	EXEC spErrorHandler 0, 'DeletedSuccessfully', null
END


ELSE IF(@flag='a')
BEGIN
	SELECT 
		Id
		,[Name]	
		,[Code]						
		,[IsActive]
	FROM [dbo].[WorkingPoints] (NOLOCK)
	WHERE ISNULL(IsDeleted,0)<>1

END

ELSE IF(@flag='la')
BEGIN
	SELECT 
		  Id
		,[Name]					
		,[IsActive]

	FROM [dbo].[WorkingPoints] (NOLOCK)
	WHERE ISNULL(IsActive,1)=1 AND ISNULL(IsDeleted,0)<>1
END

ELSE IF(@flag='s')
BEGIN
	SELECT 
		 Id
		,[Name]		
		,[Code]											
		,[IsActive]
	FROM [dbo].[WorkingPoints] (NOLOCK)
	WHERE Id=@Id
	
END
END









GO
USE [master]
GO
ALTER DATABASE [Zipline] SET  READ_WRITE 
GO
