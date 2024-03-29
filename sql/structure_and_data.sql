SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dic_claim_types]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dic_claim_types](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dic_claim_types] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_claims]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_claims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Type] [int] NOT NULL,
	[GrossClaim] [money] NOT NULL,
	[Deductible] [money] NOT NULL,
	[Year] [int] NOT NULL,
 CONSTRAINT [PK_data_claims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadClaimTypes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LoadClaimTypes] 
	@Id int
AS
BEGIN
	SET NOCOUNT ON;
	
	select * from dic_claim_types where @Id is null or Id = @Id
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadClaims]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LoadClaims]
	@Id int
AS
BEGIN
	SET NOCOUNT ON;
	
	select * from data_claims where @Id is null or Id = @Id
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteClaim]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteClaim]
	@Id int
AS
BEGIN
	SET NOCOUNT ON;
	
	delete data_claims where Id = @Id
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddClaim]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[AddClaim]
	@Name nvarchar(50),
	@Type int,
	@GrossClaim money,
	@Deductible money,
	@Year int
AS
BEGIN
	SET NOCOUNT ON;
	
	insert into data_claims(Name, Type, GrossClaim, Deductible, Year)
	values (@Name, @Type, @GrossClaim, @Deductible, @Year)
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateClaim]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateClaim]
	@Id int,
	@Name nvarchar(50),
	@Type int,
	@GrossClaim money,
	@Deductible money,
	@Year int
AS
BEGIN
	SET NOCOUNT ON;
	
	update data_claims
	set
		Name = @Name,
		Type = @Type,
		GrossClaim = @GrossClaim,
		Deductible = @Deductible,
		Year = @Year
	where 
		Id = @Id
END
' 
END

INSERT INTO [dbo].[dic_claim_types] (name)
VALUES 	('Collision')
GO

INSERT INTO [dbo].[dic_claim_types] (name)
VALUES 	('Grounding')
GO

INSERT INTO [dbo].[dic_claim_types] (name)
VALUES 	('Bad Weather')
GO

INSERT INTO [dbo].[dic_claim_types] (name)
VALUES 	('Fire')
GO
