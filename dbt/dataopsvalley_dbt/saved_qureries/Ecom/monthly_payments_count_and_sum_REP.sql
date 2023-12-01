select sum(PaymentsCount), sum(PaymentsSum), DATE_TRUNC(date, MONTH)
from (
select PaymentsCount,
PaymentsSum,
cast(DateLastChanged as DATE FORMAT 'MM/DD/YYYY') as date
from `dgt-gcp-egov-test-govilbi-0.GovilBiRepDS.MRR_Ecom_v_ecom`)
group by DATE_TRUNC(date, MONTH)
order by 3 desc