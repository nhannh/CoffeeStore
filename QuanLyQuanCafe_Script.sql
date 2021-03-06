USE [master]
GO
/****** Object:  Database [QuanLyQuanCafe]    Script Date: 12/23/2017 10:14:52 AM ******/
CREATE DATABASE [QuanLyQuanCafe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyQuanCafe', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.HUUNHAN\MSSQL\DATA\QuanLyQuanCafe.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyQuanCafe_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.HUUNHAN\MSSQL\DATA\QuanLyQuanCafe_log.ldf' , SIZE = 4736KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLyQuanCafe] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyQuanCafe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCafe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyQuanCafe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyQuanCafe', N'ON'
GO
USE [QuanLyQuanCafe]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign](@inputVar NVARCHAR(MAX) )
RETURNS NVARCHAR(MAX)
AS
BEGIN    
    IF (@inputVar IS NULL OR @inputVar = '')  RETURN ''
   
    DECLARE @RT NVARCHAR(MAX)
    DECLARE @SIGN_CHARS NCHAR(256)
    DECLARE @UNSIGN_CHARS NCHAR (256)
 
    SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' + NCHAR(272) + NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyyAADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
 
    DECLARE @COUNTER int
    DECLARE @COUNTER1 int
   
    SET @COUNTER = 1
    WHILE (@COUNTER <= LEN(@inputVar))
    BEGIN  
        SET @COUNTER1 = 1
        WHILE (@COUNTER1 <= LEN(@SIGN_CHARS) + 1)
        BEGIN
            IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@inputVar,@COUNTER ,1))
            BEGIN          
                IF @COUNTER = 1
                    SET @inputVar = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)-1)      
                ELSE
                    SET @inputVar = SUBSTRING(@inputVar, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)- @COUNTER)
                BREAK
            END
            SET @COUNTER1 = @COUNTER1 +1
        END
        SET @COUNTER = @COUNTER +1
    END
    SET @inputVar = replace(@inputVar,' ','-')
    RETURN @inputVar
END
GO
/****** Object:  Table [dbo].[Account]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](1000) NOT NULL DEFAULT ((0)),
	[Type] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bill]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NULL DEFAULT (getdate()),
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL DEFAULT ((0)),
	[totalPrice] [float] NULL,
	[discount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Food]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'nhan', N'NhanNguyen', N'1', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'quang', N'QuangVo', N'0', 0)
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (7, CAST(N'2017-05-10' AS Date), CAST(N'2017-11-12' AS Date), 2, 1, 50000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (8, CAST(N'2017-10-05' AS Date), CAST(N'2017-11-11' AS Date), 3, 1, 221000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (9, CAST(N'2017-05-10' AS Date), CAST(N'2017-05-10' AS Date), 4, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (14, CAST(N'2017-10-11' AS Date), NULL, 4, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (16, CAST(N'2017-10-11' AS Date), NULL, 6, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (17, CAST(N'2017-10-11' AS Date), CAST(N'2017-11-11' AS Date), 5, 1, 35000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (18, CAST(N'2017-10-31' AS Date), CAST(N'2017-11-11' AS Date), 4, 1, 10000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1021, CAST(N'2017-11-11' AS Date), CAST(N'2017-12-15' AS Date), 3, 1, 120000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1026, CAST(N'2017-11-12' AS Date), NULL, 2, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1027, CAST(N'2017-11-12' AS Date), CAST(N'2017-11-12' AS Date), 8, 1, 24300, 10)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1028, CAST(N'2017-11-12' AS Date), CAST(N'2017-11-12' AS Date), 6, 1, 55000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1029, CAST(N'2017-11-12' AS Date), CAST(N'2017-11-14' AS Date), 4, 1, 195000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1030, CAST(N'2017-11-12' AS Date), CAST(N'2017-11-14' AS Date), 6, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1031, CAST(N'2017-11-12' AS Date), CAST(N'2017-11-12' AS Date), 8, 1, 58000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1032, CAST(N'2017-11-12' AS Date), CAST(N'2017-11-12' AS Date), 5, 1, 10800, 10)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1033, CAST(N'2017-11-12' AS Date), CAST(N'2017-12-15' AS Date), 5, 1, 180000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1034, CAST(N'2017-11-14' AS Date), CAST(N'2017-11-14' AS Date), 6, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1035, CAST(N'2017-11-14' AS Date), CAST(N'2017-11-14' AS Date), 6, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1036, CAST(N'2017-11-14' AS Date), CAST(N'2017-12-13' AS Date), 6, 1, 183000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1037, CAST(N'2017-11-14' AS Date), CAST(N'2017-12-13' AS Date), 8, 1, 24000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1038, CAST(N'2017-11-25' AS Date), CAST(N'2017-12-13' AS Date), 4, 1, 66000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1039, CAST(N'2017-12-13' AS Date), CAST(N'2017-12-13' AS Date), 11, 1, 241000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1040, CAST(N'2017-12-13' AS Date), CAST(N'2017-12-13' AS Date), 10, 1, 94500, 10)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1041, CAST(N'2017-12-13' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 48000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1042, CAST(N'2017-12-13' AS Date), CAST(N'2017-12-13' AS Date), 4, 1, 48000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1043, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 150000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1044, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 175000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1045, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 175000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1046, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 175000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1047, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 200000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1048, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 25000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1049, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 125000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1050, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 150000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1051, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 175000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1052, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 25000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1053, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 75000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1054, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 25000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1055, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 25000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1056, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 25000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1057, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 75000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1058, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 25000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1059, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 60000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1060, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 84000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1061, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 108000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1062, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 108000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1063, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 60000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1064, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 8, 1, 76000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1065, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 10, 1, 105000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1066, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 11, 1, 120000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1067, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 120000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1068, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 105000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1069, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 75000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1070, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 6, 1, 75000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1071, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 4, 1, 75000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1072, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 4, 1, 60000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1073, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 4, 1, 60000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1074, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 4, 1, 105000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1075, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 4, 1, 60000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1076, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 4, 1, 75000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1077, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 4, 1, 75000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1078, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 4, 1, 15000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1079, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 4, 1, 105000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1080, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 4, 1, 105000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1081, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 3, 1, 120000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1082, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 3, 1, 255000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1083, CAST(N'2017-12-15' AS Date), CAST(N'2017-12-15' AS Date), 8, 1, 90000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (1084, CAST(N'2017-12-23' AS Date), NULL, 4, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Bill] OFF
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (3, 7, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (5, 8, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (6, 8, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (7, 8, 17, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (8, 9, 8, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (9, 9, 9, 24)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (10, 14, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (12, 16, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1023, 1027, 8, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1024, 1027, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1025, 1028, 17, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1026, 1028, 19, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1027, 1084, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1028, 1084, 16, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1029, 1084, 13, 6)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1030, 1036, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1031, 1036, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1032, 1036, 17, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1033, 1031, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1034, 1032, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1035, 1031, 9, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1036, 1029, 8, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1037, 1029, 17, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1038, 1029, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1046, 1038, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1047, 1038, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1048, 1039, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1049, 1039, 8, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1050, 1039, 17, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1051, 1039, 12, 6)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1052, 1040, 12, 6)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1053, 1040, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1054, 1041, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1055, 1037, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1056, 1042, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1057, 1043, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1058, 1044, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1059, 1045, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1060, 1046, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1061, 1047, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1062, 1048, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1063, 1049, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1064, 1050, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1065, 1051, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1066, 1052, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1067, 1053, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1068, 1054, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1069, 1055, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1070, 1056, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1071, 1057, 15, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1072, 1058, 15, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1073, 1059, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1074, 1060, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1075, 1061, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1076, 1062, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1077, 1063, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1078, 1064, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1079, 1064, 17, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1080, 1065, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1081, 1066, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1082, 1033, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1083, 1067, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1084, 1068, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1085, 1069, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1086, 1070, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1087, 1071, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1088, 1072, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1089, 1073, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1090, 1074, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1091, 1075, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1092, 1076, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1093, 1077, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1094, 1078, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1095, 1079, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1096, 1080, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1097, 1021, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1098, 1081, 14, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1099, 1082, 13, 6)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1100, 1083, 13, 6)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (6, N'Cà Phê Sữa', 1, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (7, N'CocaCola', 1, 10000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (8, N'Cam ép', 1, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (9, N'Chanh dây', 1, 10000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (10, N'Trà Sữa', 1, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (11, N'Bánh Su', 2, 5000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (12, N'Bánh Chanh', 2, 10000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (13, N'Chesecake', 2, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (14, N'Tôm nướng', 3, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (15, N'Mực Nướng', 3, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (16, N'Cá Viên Chiên', 3, 8000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (17, N'Hạt dưa', 4, 5000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (18, N'Đậu phộng muối', 4, 5000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (19, N'Hạt Macca', 4, 50000)
SET IDENTITY_INSERT [dbo].[Food] OFF
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Nước')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Bánh')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (3, N'Hải Sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (4, N'Nông Sản')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn 1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn 3', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (11, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (14, N'Bàn 10', N'Trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
AS
BEGIN
	select t.name, b.totalPrice, DateCheckIn, DateCheckOut, discount
	from dbo.Bill as b, dbo.TableFood as t
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1
	AND t.id = b.idTable
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateAndPage]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListBillByDateAndPage]
@checkIn date, @checkOut date, @page int
AS
BEGIN
	Declare @pageRows int = 10
	Declare @selectRows int =  @pageRows 
	Declare @exceptRows int	= (@page - 1) * @pageRows 

	;with BillShow as (select b.id ,t.name, b.totalPrice, DateCheckIn, DateCheckOut, discount
	from dbo.Bill as b, dbo.TableFood as t
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1
	AND t.id = b.idTable)

	select top (@selectRows) * from BillShow where id not in (select top (@exceptRows) id from BillShow)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetNumBillByDate]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetNumBillByDate]
@checkIn date, @checkOut date
AS
BEGIN
	select count(*)
	from dbo.Bill as b, dbo.TableFood as t
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1
	AND t.id = b.idTable
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_GetTableList]

AS
BEGIN
	
	SELECT * from TableFood 
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[USP_InsertBill]
@idTable Int
AS	
BEGIN
	insert Bill
	(
		DateCheckIn,
		DateCheckOut,
		idTable,
		status,
		totalPrice
	)
	values (
		GETDATE() ,  --DateCheckIn  -date
		Null,   --DateCheckOut -date
		@idTable,   -- idTable - int
		0,    -- status
		0
	)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE  [dbo].[USP_InsertBillInfo]
@idBill Int,@idFood Int,@count int
AS	
BEGIN
	declare @isExitsBillInfo int
	declare @foodCount int = 1

	select @isExitsBillInfo = id,@foodCount = count 
	From BillInfo where idBill= @idBill  And idFood = @idFood
	if(@isExitsBillInfo > 0)
	begin
		declare @newCount int =@foodCount + @count
		if(@newCount > 0)
		update BillInfo set count = @foodCount + @count where idFood =@idFood
		else
		Delete BillInfo where idBill =@idBill AND idFood = @idFood
	end
	else 
	begin
		insert BillInfo
	(
		idBill,idFood,count
	)
	values (
		@idBill ,  
		@idFood,   
		@count
	)
	end
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_Login] 
	@userName nvarchar(100),
	@passWord nvarchar(100)
AS
BEGIN

	SELECT * from Account Where UserName = @userName and  PassWord =@passWord
END

GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_SwitchTable]
@idTable1 int, @idTable2 int
AS BEGIN
	declare @idFirstBill int
	declare @idSecondBill int

	declare @isFirstTablEmty int = 1
	declare @isSecondTablEmty int = 1

	select @idSecondBill = id from dbo.Bill where idTable = @idTable2 and status =0
	select @idFirstBill = id from dbo.Bill where idTable = @idTable1 and status =0
	
	if (@idFirstBill is null)
	BEGIN

		INSERT dbo.Bill		
		( DateCheckIn,
			DateCheckOut,
			idTable,
			status
		)
		values (
			GETDATE() ,  --DateCheckIn  -date
			Null,   --DateCheckOut -date
			@idTable1,   -- idTable - int
			0 -- status - int
			)
		select @idFirstBill = MAX(id) from dbo.Bill where idTable = @idTable1 and status =0
	END
	 
	 select @isFirstTablEmty = count(*) from BillInfo where idBill= @idFirstBill
	
	if (@idSecondBill is null)
	BEGIN
		INSERT dbo.Bill
		
		( DateCheckIn,
		DateCheckOut,
		idTable,
		status
		)
		values (
		GETDATE() ,  --DateCheckIn  -date
		Null,   --DateCheckOut -date
		@idTable2,   -- idTable - int
		0 -- status - int
		)
		select @idSecondBill = MAX(id) from dbo.Bill where idTable = @idTable2 and status =0
		 
	END
	 
	select @isSecondTablEmty =count(*) from BillInfo where idBill = @idSecondBill

	select id into IDBillInfoTable from dbo.BillInfo where idBill = @idSecondBill

	update dbo.BillInfo set idBill = @idSecondBill where idBill = @idFirstBill

	update dbo.BillInfo set idBill = @idFirstBill where id in (select * from IDBillInfoTable)
	DROP TABLE IDBillInfoTable
	if(@isFirstTablEmty = 0)
		update TableFood set status = N'Trống' where id = @idTable2
	if(@isSecondTablEmty = 0)
		update TableFood set status = N'Trống' where id = @idTable1
END

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 12/23/2017 10:14:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateAccount]
@userName nvarchar(100), @displayName nvarchar(100),
@password nvarchar(100), @newPassword nvarchar(100)
AS
BEGIN

	Declare @isRightPass int
	select @isRightPass = count (*) from dbo.Account where UserName = @userName and PassWord = @password
	if(@isRightPass =1)
	BEGIN
		if(@newPassword = null or @newPassword = ' ')
		BEGIN
			UPDATE dbo.Account set DisplayName = @displayName where UserName = @userName
		END
		else
		UPDATE dbo.Account set DisplayName = @displayName, PassWord = @newPassword where UserName = @userName
	END

END

GO
USE [master]
GO
ALTER DATABASE [QuanLyQuanCafe] SET  READ_WRITE 
GO
