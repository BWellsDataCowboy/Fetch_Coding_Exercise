select
    variant_col:"_id"."$oid"::string as receipt_id,
    variant_col:"bonusPointsEarned"::number as bonuspointsearned,
    variant_col:"bonusPointsEarnedReason"::string as bonuspointsearnedreason,
    to_timestamp(variant_col:"createDate"."$date"::number / 1000) as createdate,
    to_timestamp(variant_col:"dateScanned"."$date"::number / 1000) as datescanned,
    to_timestamp(variant_col:"finishedDate"."$date"::number / 1000) as finisheddate,
    to_timestamp(variant_col:"modifyDate"."$date"::number / 1000) as modifydate,
    to_timestamp(
        variant_col:"pointsAwardedDate"."$date"::number / 1000
    ) as pointsawardeddate,
    variant_col:"pointsEarned"::string as pointsearned,
    to_timestamp(variant_col:"purchaseDate"."$date"::number / 1000) as purchasedate,
    variant_col:"purchasedItemCount"::number as purchaseditemcount,
    variant_col:"rewardsReceiptStatus"::string as rewardsreceiptstatus,
    variant_col:"totalSpent"::string as totalspent,
    variant_col:"userId"::string as userid
from raw_fetch_excercise.receipts.receipts_tbl
;
