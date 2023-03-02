CREATE TABLE [dbo].[TR_ORDER_ITEMS](
	[productId] [varchar](100) NULL,
	[quantity] [varchar](100) NULL,
	[orderId] [varchar](100) NULL,
	[itemName] [varchar](300) NULL,
	[originalName] [varchar](300) NULL,
	[ean] [varchar](100) NULL,
	[price] [varchar](100) NULL,
	[costPrice] [varchar](100) NULL,
	[originalPrice] [varchar](100) NULL,
	[itemWeight] [varchar](100) NULL,
	[brand] [varchar](300) NULL,
	[model] [varchar](300) NULL,
	[reference] [varchar](300) NULL,
	[itemLength] [varchar](100) NULL,
	[itemWidth] [varchar](100) NULL,
	[itemHeight] [varchar](100) NULL,
	[additionalInformation] [varchar](300) NULL,
	[warranty] [varchar](100) NULL,
	[ncm] [varchar](100) NULL
) ON [PRIMARY]
GO

