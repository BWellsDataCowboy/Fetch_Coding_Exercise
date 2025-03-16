select
    variant_col:"_id"."$oid"::string as brand_id,
    variant_col:"barcode"::string as barcode,
    variant_col:"category"::string as category,
    variant_col:"categoryCode"::string as category_code,
    variant_col:"cpg"."$id"."$oid"::string as cpg_id,
    variant_col:"cpg"."$ref"::string as cpg_ref,
    variant_col:"name"::string as name,
    variant_col:"topBrand"::boolean as top_brand,
    variant_col:"brandCode"::string as brand_code
from raw_fetch_excercise.brands.brands_tbl
;
