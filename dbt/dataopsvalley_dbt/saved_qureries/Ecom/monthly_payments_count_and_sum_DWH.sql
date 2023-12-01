SELECT
  DATE_TRUNC(DateLastChanged, MONTH) AS Month,
  SUM(PaymentsCount) AS TotalPaymentsCount,
  SUM(PaymentsSum) AS TotalPaymentsSum
FROM `dgt-gcp-egov-test-govilbi-0.GovilBiDwhDS.DWH_FACT_Ecom_Payment`
GROUP BY Month
ORDER BY 1 desc
