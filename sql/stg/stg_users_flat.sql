select
    variant_col:"_id"."$oid"::string as user_id,
    variant_col:"state"::string as state,
    to_timestamp(variant_col:"createdDate"."$date"::number / 1000) as created_date,
    to_timestamp(variant_col:"lastLogin"."$date"::number / 1000) as last_login,
    variant_col:"role"::string as role,
    variant_col:"active"::boolean as active
from raw_fetch_excercise.users.users_tbl
;
