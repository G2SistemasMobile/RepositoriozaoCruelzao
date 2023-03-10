CREATE TABLE [dbo].[SH_PEDIDO](
	[SHIPPING_ESTIMATE_ID] [varchar](60) NULL,
	[INTEREST] [float] NULL,
	[CALCULATION_TYPE] [varchar](60) NULL,
	[SHIPPING_METHOD_ID] [varchar](60) NULL,
	[SHIPPING_METHOD] [varchar](60) NULL,
	[DELIVERY_CONTRACT_TYPE] [varchar](60) NULL,
	[CODE] [varchar](60) NOT NULL,
	[PLACED_AT] [datetime] NULL,
	[TOTAL_ORDERED] [float] NULL,
	[APPROVED_DATE] [datetime] NULL,
	[SHIPPED_DATE] [datetime] NULL,
	[DISCOUNT] [float] NULL,
	[CHANNEL] [varchar](60) NULL,
	[IMPORTED_AT] [datetime] NULL,
	[ESTIMATED_DELIVERY] [datetime] NULL,
	[UPDATED_AT] [datetime] NULL,
	[EXPORTED_AT] [datetime] NULL,
	[ESTIMATED_DELIVERY_SHIFT] [datetime] NULL,
	[SELLER_SHIPPING_COST] [float] NULL,
	[TARGET_ORDER] [varchar](60) NULL,
	[EXPEDITION_LIMIT_DATE] [datetime] NULL,
	[LINKED_ORDER] [varchar](60) NULL,
	[SYNC_STATUS] [varchar](60) NULL,
	[DELIVERED_DATE] [datetime] NULL,
	[SHIPPING_CARRIER] [varchar](60) NULL,
	[SHIPPING_COST] [float] NULL,
	[BILLING_STREET] [varchar](60) NULL,
	[BILLING_SECONDARY_PHONE] [varchar](60) NULL,
	[BILLING_REGION] [varchar](20) NULL,
	[BILLING_REFERENCE] [varchar](80) NULL,
	[BILLING_POSTCODE] [varchar](60) NULL,
	[BILLING_PHONE] [varchar](40) NULL,
	[BILLING_NUMBER] [varchar](20) NULL,
	[BILLING_NEIGHBORHOOD] [varchar](60) NULL,
	[BILLING_FULL_NAME] [varchar](80) NULL,
	[BILLING_DETAIL] [varchar](80) NULL,
	[BILLING_COUNTRY] [varchar](10) NULL,
	[BILLING_COMPLEMENT] [varchar](60) NULL,
	[BILLING_CITY] [varchar](60) NULL,
	[SS_NAME] [varchar](60) NULL,
	[REMOTE_ID] [varchar](60) NULL,
	[REMOTE_CODE] [varchar](60) NULL,
	[CUSTOMER_VAT_NUMBER] [varchar](40) NULL,
	[CUSTOMER_PHONE] [varchar](40) NULL,
	[CUSTOMER_PHONE2] [varchar](40) NULL,
	[CUSTOMER_PHONE3] [varchar](40) NULL,
	[CUSTOMER_NAME] [varchar](80) NULL,
	[CUSTOMER_GENDER] [varchar](30) NULL,
	[CUSTOMER_EMAIL] [varchar](60) NULL,
	[CUSTOMER_DATE_OF_BIRTH] [datetime] NULL,
	[STATUS_TYPE] [varchar](60) NULL,
	[STATUS_LABEL] [varchar](60) NULL,
	[STATUS_CODE] [varchar](60) NULL,
	[SHIPPING_STREET] [varchar](60) NULL,
	[SHIPPING_SECONDARY_PHONE] [varchar](60) NULL,
	[SHIPPING_REGION] [varchar](20) NULL,
	[SHIPPING_REFERENCE] [varchar](60) NULL,
	[SHIPPING_POSTCODE] [varchar](20) NULL,
	[SHIPPING_PHONE] [varchar](30) NULL,
	[SHIPPING_NUMBER] [varchar](20) NULL,
	[SHIPPING_NEIGHBORHOOD] [varchar](60) NULL,
	[SHIPPING_FULL_NAME] [varchar](80) NULL,
	[SHIPPING_DETAIL] [varchar](80) NULL,
	[SHIPPING_COUNTRY] [varchar](20) NULL,
	[SHIPPING_COMPLEMENT] [varchar](40) NULL,
	[SHIPPING_CITY] [varchar](60) NULL,
	[INVOICE_KEY] [varchar](60) NULL,
	[INVOICE_VOLUME_QTY] [int] NULL,
	[SHIPMENT_CODE] [varchar](60) NULL,
	[SHIPMENT_DELIVERED_CARRIER_DATE] [datetime] NULL,
	[SHIPMENT_TRACK_CODE] [varchar](60) NULL,
	[SHIPMENT_TRACK_CARRIER] [varchar](40) NULL,
	[SHIPMENT_TRACK_METHOD] [varchar](40) NULL,
	[SHIPMENT_TRACK_URL] [varchar](60) NULL,
	[SHIPMENT_EXCEPTION_OBSERVATION] [varchar](100) NULL,
	[SHIPMENT_EXCEPTION_OCCURRENCE_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

