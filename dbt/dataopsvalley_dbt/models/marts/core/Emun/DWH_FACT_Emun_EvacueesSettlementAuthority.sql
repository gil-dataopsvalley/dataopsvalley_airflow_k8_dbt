select
    EvacuatedSettlement,
    EvacuatedSettlementCode,
    ReceivingAuthority,
    CuncillCode,
    SettlementCode,
    NumberOHotels,
    EvacueesFromEvacuatioProgram,
    EvacuateIndependently,
    TotalEvacuate
from {{ ref('stg_emun_evacuees_settlement_authority') }}