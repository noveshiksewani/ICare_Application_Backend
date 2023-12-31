USE [master]
GO
/****** Object:  Database [health]    Script Date: 29-May-21 5:41:31 PM ******/
CREATE DATABASE [health]
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [health].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [health] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [health] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [health] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [health] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [health] SET ARITHABORT OFF 
GO
ALTER DATABASE [health] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [health] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [health] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [health] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [health] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [health] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [health] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [health] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [health] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [health] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [health] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [health] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [health] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [health] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [health] SET  MULTI_USER 
GO
ALTER DATABASE [health] SET DB_CHAINING OFF 
GO
ALTER DATABASE [health] SET ENCRYPTION ON
GO
ALTER DATABASE [health] SET QUERY_STORE = ON
GO
ALTER DATABASE [health] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 7), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 10, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [health]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 29-May-21 5:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 29-May-21 5:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Address]    Script Date: 29-May-21 5:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[addressId] [int] IDENTITY(1,1) NOT NULL,
	[houseNo] [varchar](20) NOT NULL,
	[street] [varchar](100) NOT NULL,
	[city] [varchar](20) NOT NULL,
	[pincode] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[addressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Comments]    Script Date: 29-May-21 5:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[commentId] [int] NOT NULL,
	[comment] [nvarchar](max) NULL,
	[userId] [int] NULL,
	[postId] [int] NULL,
	[timestamp] [timestamp] NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[commentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Donation]    Script Date: 29-May-21 5:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donation](
	[dontationId] [int] IDENTITY(1,1) NOT NULL,
	[donationType] [varchar](50) NOT NULL,
	[donationTypeId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[userType] [varchar](10) NOT NULL,
	[timeStamp] [timestamp] NULL,
 CONSTRAINT [Donation_pk] PRIMARY KEY NONCLUSTERED 
(
	[dontationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Food]    Script Date: 29-May-21 5:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[foodId] [int] IDENTITY(500,1) NOT NULL,
	[description] [varchar](max) NOT NULL,
	[selectedUserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[foodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Money]    Script Date: 29-May-21 5:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Money](
	[moneyId] [int] IDENTITY(400,1) NOT NULL,
	[amount] [decimal](18, 2) NOT NULL,
	[userId] [int] NULL,
	[selectedUserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[moneyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Oxygen]    Script Date: 29-May-21 5:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Oxygen](
	[oxygenId] [int] IDENTITY(1,1) NOT NULL,
	[provider] [varchar](20) NOT NULL,
	[quantity] [int] NOT NULL,
	[selectedUserId] [int] NULL,
 CONSTRAINT [PK_Oxygen] PRIMARY KEY CLUSTERED 
(
	[oxygenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Plasma]    Script Date: 29-May-21 5:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plasma](
	[plasmaId] [int] IDENTITY(300,1) NOT NULL,
	[bloodType] [varchar](20) NOT NULL,
	[selectedUserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[plasmaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Post]    Script Date: 29-May-21 5:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[postId] [int] IDENTITY(700,1) NOT NULL,
	[imageUrl] [varchar](max) NOT NULL,
	[description] [varchar](max) NOT NULL,
	[userId] [int] NULL,
	[commentId] [int] NULL,
	[timestamp] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[postId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Privilages]    Script Date: 29-May-21 5:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Privilages](
	[minitreeId] [int] IDENTITY(601,1) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[userId] [int] NULL,
 CONSTRAINT [PK_Privilages] PRIMARY KEY CLUSTERED 
(
	[minitreeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[QuarantinePlace]    Script Date: 29-May-21 5:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuarantinePlace](
	[placeId] [int] IDENTITY(901,1) NOT NULL,
	[addressId] [int] NOT NULL,
	[roomNo] [int] NOT NULL,
	[description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_QuarantinePlace] PRIMARY KEY CLUSTERED 
(
	[placeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[SelectedUser]    Script Date: 29-May-21 5:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SelectedUser](
	[selectedUserId] [int] IDENTITY(1,1) NOT NULL,
	[selectedUser] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[selectedUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 29-May-21 5:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON),
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[User]    Script Date: 29-May-21 5:41:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[userId] [int] IDENTITY(200,1) NOT NULL,
	[userName] [varchar](20) NOT NULL,
	[email] [varchar](20) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[role] [char](10) NOT NULL,
	[addressId] [int] NOT NULL,
	[phone] [bigint] NOT NULL,
	[gender] [char](10) NOT NULL,
	[name] [varchar](60) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [User_email_uindex]    Script Date: 29-May-21 5:41:33 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [User_email_uindex] ON [dbo].[User]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [User_phone_uindex]    Script Date: 29-May-21 5:41:33 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [User_phone_uindex] ON [dbo].[User]
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [User_userName_uindex]    Script Date: 29-May-21 5:41:33 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [User_userName_uindex] ON [dbo].[User]
(
	[userName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [Comments_post_postId_fk] FOREIGN KEY([postId])
REFERENCES [dbo].[Post] ([postId])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [Comments_post_postId_fk]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [Comments_User_userId_fk] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [Comments_User_userId_fk]
GO
ALTER TABLE [dbo].[Donation]  WITH CHECK ADD  CONSTRAINT [Donation_User_userId_fk] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Donation] CHECK CONSTRAINT [Donation_User_userId_fk]
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD  CONSTRAINT [food_SelectedUser_selectedUserId_fk] FOREIGN KEY([selectedUserId])
REFERENCES [dbo].[SelectedUser] ([selectedUserId])
GO
ALTER TABLE [dbo].[Food] CHECK CONSTRAINT [food_SelectedUser_selectedUserId_fk]
GO
ALTER TABLE [dbo].[Money]  WITH CHECK ADD  CONSTRAINT [money_SelectedUser_selectedUserId_fk] FOREIGN KEY([selectedUserId])
REFERENCES [dbo].[SelectedUser] ([selectedUserId])
GO
ALTER TABLE [dbo].[Money] CHECK CONSTRAINT [money_SelectedUser_selectedUserId_fk]
GO
ALTER TABLE [dbo].[Money]  WITH CHECK ADD  CONSTRAINT [Money_User_userId_fk] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Money] CHECK CONSTRAINT [Money_User_userId_fk]
GO
ALTER TABLE [dbo].[Oxygen]  WITH CHECK ADD  CONSTRAINT [Oxygen_SelectedUser_selectedUserId_fk] FOREIGN KEY([selectedUserId])
REFERENCES [dbo].[SelectedUser] ([selectedUserId])
GO
ALTER TABLE [dbo].[Oxygen] CHECK CONSTRAINT [Oxygen_SelectedUser_selectedUserId_fk]
GO
ALTER TABLE [dbo].[Plasma]  WITH CHECK ADD  CONSTRAINT [Plasma_SelectedUser_selectedUserId_fk] FOREIGN KEY([selectedUserId])
REFERENCES [dbo].[SelectedUser] ([selectedUserId])
GO
ALTER TABLE [dbo].[Plasma] CHECK CONSTRAINT [Plasma_SelectedUser_selectedUserId_fk]
GO
ALTER TABLE [dbo].[Privilages]  WITH CHECK ADD  CONSTRAINT [Privilages_User_userId_fk] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Privilages] CHECK CONSTRAINT [Privilages_User_userId_fk]
GO
ALTER TABLE [dbo].[QuarantinePlace]  WITH CHECK ADD  CONSTRAINT [QuarantinePlace_Address_addressId_fk] FOREIGN KEY([addressId])
REFERENCES [dbo].[Address] ([addressId])
GO
ALTER TABLE [dbo].[QuarantinePlace] CHECK CONSTRAINT [QuarantinePlace_Address_addressId_fk]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [User_Address_addressId_fk] FOREIGN KEY([addressId])
REFERENCES [dbo].[Address] ([addressId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [User_Address_addressId_fk]
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 29-May-21 5:41:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 29-May-21 5:41:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 29-May-21 5:41:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 29-May-21 5:41:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 29-May-21 5:41:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 29-May-21 5:41:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 29-May-21 5:41:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
USE [master]
GO
ALTER DATABASE [health] SET  READ_WRITE 
GO
