-- Note we have not done current 6 months because of the lack of data.
-- Model for BI user to use....
-- What are the top 5 brands by receipts scanned for most recent month?
-- How does the ranking of the top 5 brands by receipts scanned for the recent month
-- compare to the ranking for the previous month?
with
    monthly_data as (
        select
            b.name as brand_name,
            date_trunc('month', r.createdate) as month_start,
            count(distinct r.receipt_id) as receipt_count
        from stg_receipts_flat r
        join stg_receipt_items_flat ri on r.receipt_id = ri.receipt_id
        join stg_brands_flat b on ri.brandcode = b.brand_code
        where
            date_trunc('month', r.createdate) <= '2021-04-01 00:00:00.000'
            and date_trunc('month', r.createdate) >= '2021-01-01 00:00:00.000'
        group by b.name, date_trunc('month', r.createdate)
    ),
    ranked as (
        select
            brand_name,
            month_start,
            receipt_count,
            rank() over (
                partition by month_start order by receipt_count desc
            ) as rank_in_month
        from monthly_data
    )
select *
from ranked
order by month_start desc, rank_in_month
;
