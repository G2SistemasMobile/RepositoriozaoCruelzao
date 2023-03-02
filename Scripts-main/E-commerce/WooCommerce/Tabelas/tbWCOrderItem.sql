CREATE TABLE [dbo].[WC_ORDER_ITEM](
	[id] [int] NULL,
	[order_id] [int] NULL,
	[name] [varchar](300) NULL,
	[price] [float] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NULL,
	[sku] [varchar](300) NULL,
	[subtotal] [varchar](300) NULL,
	[subtotal_tax] [varchar](300) NULL,
	[total] [varchar](300) NULL,
	[total_tax] [varchar](300) NULL
) ON [PRIMARY]