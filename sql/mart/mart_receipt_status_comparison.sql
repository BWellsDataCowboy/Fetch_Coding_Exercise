-- Note we have used FINISHED here instead of Accepted as there is no Accepted value
-- found in the data
-- Model for BI user to use....
-- When considering average spend from receipts with rewardsReceiptStatus of Accepted
-- or Rejected, which is greater?
-- When considering total number of items purchased from receipts with
-- rewardsReceiptStatus of Accepted or Rejected, which is greater?
select
    rewardsreceiptstatus,
    avg(cast(totalspent as number)) as avg_total_spent,
    sum(purchaseditemcount) as total_items_purchased
from raw_fetch_excercise.stg.stg_receipts_flat
where rewardsreceiptstatus in ('FINISHED', 'REJECTED')
group by rewardsreceiptstatus
