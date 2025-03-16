-- 1. Inspect Receipt Item Schema (retrieve keys from a sample receipt item)
select object_keys(ri.value) as receipt_item_keys
from
    stg_receipt_items_flat,
    lateral flatten(
        input => (
            select variant_col:"rewardsReceiptItemList"
            from raw_fetch_excercise.receipts.receipts_tbl
            limit 1
        )
    ) ri
;
-- Another way to get the keys
-- ["barcode","description","finalPrice","itemPrice","needsFetchReview","partnerItemId","preventTargetGapPoints","quantityPurchased","userFlaggedBarcode","userFlaggedNewItem","userFlaggedPrice","userFlaggedQuantity"]
-- 2. Validate the BrandCode Join: Count total, matched, and unmatched receipt items
select
    count(*) as total_receipt_items,
    sum(case when b.brand_id is null then 1 else 0 end) as unmatched_receipt_items,
    sum(case when b.brand_id is not null then 1 else 0 end) as matched_receipt_items
from stg_receipt_items_flat ri
left join stg_brands_flat b on ri.brandcode = b.brand_code
;
-- TOTAL_RECEIPT_ITEMS	UNMATCHED_RECEIPT_ITEMS	MATCHED_RECEIPT_ITEMS
-- 6947	6312	635
-- 3. Check the Earliest Receipt Date (to assess historical data coverage)
select min(createdate) as earliest_receipt_date, max(createdate) as latest_receipt_date
from stg_receipts_flat
;
-- EARLIEST_RECEIPT_DATE	LATEST_RECEIPT_DATE
-- 2020-10-30 20:17:59.000	2021-03-01 23:17:34.772
-- 4. List Distinct Values in rewardsReceiptStatus (to verify expected statuses)
select distinct rewardsreceiptstatus
from stg_receipts_flat
;
-- accepted not to be found
-- REWARDSRECEIPTSTATUS
-- FINISHED
-- REJECTED
-- FLAGGED
-- PENDING
-- SUBMITTED
-- 5. Validate Key Consistency in Brands: Count occurrences of each brand_code
select brand_code, count(*) as occurrences
from stg_brands_flat
group by brand_code
order by occurrences desc
;
-- lots of TEST BRANDCODE @1599159969725 - test branc codes and 234 null and 35 empty
-- txt
-- 6. Check for Missing Critical Fields in Receipts (e.g., missing userId)
select count(*) as missing_user_id
from stg_receipts_flat
where userid is null or userid = ''
;
-- 0
-- 7. Examine Distribution of Purchased Item Count in Receipts
select purchaseditemcount, count(*) as frequency
from stg_receipts_flat
group by purchaseditemcount
order by frequency desc
;
-- 484 with item count null

