CREATE VIEW [dbo].[V_WC_CATEGORIES] AS
	SELECT DISTINCT
		categoryid, 
		category
	FROM V_WC_PRODUCTS