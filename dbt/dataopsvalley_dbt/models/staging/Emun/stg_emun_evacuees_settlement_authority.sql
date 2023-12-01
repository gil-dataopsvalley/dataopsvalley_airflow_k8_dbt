select
    EvacuatedSettlement,
    EvacuatedSettlementCode,
    ReceivingAuthority,
    CuncillCode,
    SettlementCode,
    cast(NumberOHotels as int64) as NumberOHotels,
    cast(REPLACE(EvacueesFromEvacuatioProgram,',', '') as int64) as EvacueesFromEvacuatioProgram,
    cast(REPLACE(EvacuateIndependently,',', '') as int64) as EvacuateIndependently,
    cast(REPLACE(TotalEvacuate,',', '') as int64) as TotalEvacuate
from {{ source('src_emun', 'MRR_Emun_EvacueesSettlementAuthority') }}