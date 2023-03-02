CREATE TABLE [dbo].[MG_ORDER_ITEM](
	[amount_refunded] [float] NULL,
	[base_amount_refunded] [float] NULL,
	[base_discount_amount] [float] NULL,
	[base_discount_invoiced] [float] NULL,
	[base_discount_tax_compensation_amount] [float] NULL,
	[base_original_price] [float] NULL,
	[base_price] [float] NULL,
	[base_price_incl_tax] [float] NULL,
	[base_row_invoiced] [float] NULL,
	[base_row_total] [float] NULL,
	[base_row_total_incl_tax] [float] NULL,
	[base_tax_amount] [float] NULL,
	[base_tax_invoiced] [float] NULL,
	[created_at] [varchar](300) NULL,
	[discount_amount] [float] NULL,
	[discount_invoiced] [float] NULL,
	[discount_percent] [float] NULL,
	[discount_tax_compensation_amount] [float] NULL,
	[free_shipping] [int] NULL,
	[is_qty_decimal] [int] NULL,
	[is_virtual] [int] NULL,
	[item_id] [int] NULL,
	[name] [varchar](300) NULL,
	[no_discount] [int] NULL,
	[order_id] [int] NULL,
	[original_price] [float] NULL,
	[price] [float] NULL,
	[price_incl_tax] [float] NULL,
	[product_id] [int] NULL,
	[product_type] [varchar](300) NULL,
	[qty_canceled] [int] NULL,
	[qty_invoiced] [int] NULL,
	[qty_ordered] [int] NULL,
	[qty_refunded] [int] NULL,
	[qty_shipped] [int] NULL,
	[quote_item_id] [int] NULL,
	[row_invoiced] [float] NULL,
	[row_total] [float] NULL,
	[row_total_incl_tax] [float] NULL,
	[row_weight] [float] NULL,
	[sku] [varchar](300) NULL,
	[store_id] [int] NULL,
	[tax_amount] [float] NULL,
	[tax_invoiced] [float] NULL,
	[tax_percent] [float] NULL,
	[updated_at] [varchar](300) NULL,
	[weight] [float] NULL
) ON [PRIMARY]
GO