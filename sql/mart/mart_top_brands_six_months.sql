-- Note we have not done current 6 months because of the lack of data.
-- Model for BI user to use....
-- Which brand has the most spend among users who were created within the past 6 months?
-- Which brand has the most transactions among users who were created within the past
-- 6 months?
with
    new_users as (
        select user_id
        from raw_fetch_excercise.stg.stg_users_flat
        where created_date >= dateadd(month, -6, '2021-03-01 00:00:00.000')
    ),
    new_user_receipts_and_items as (
        select r.receipt_id, r.totalspent, ri.brandcode
        from new_users u
        left join raw_fetch_excercise.stg.stg_receipts_flat r on r.userid = u.user_id
        left join
            raw_fetch_excercise.stg.stg_receipt_items_flat ri
            on r.receipt_id = ri.receipt_id
    ),
    brand_spend_and_transactions as (
        select
            b.name as brand_name,
            count(distinct ri.receipt_id) as transaction_count,
            sum(cast(ri.totalspent as number)) as total_spent
        from new_user_receipts_and_items as ri
        left join
            raw_fetch_excercise.stg.stg_brands_flat b on ri.brandcode = b.brand_code
        group by b.name
    )
select brand_name, transaction_count, total_spent
from brand_spend_and_transactions
