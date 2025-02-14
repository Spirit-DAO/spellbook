{{
    config(
        tags = ['prod_exclude'],
        schema = 'kaia_swap_v3_kaia',
        alias = 'base_trades',
        materialized = 'incremental',
        file_format = 'delta',
        incremental_strategy = 'merge',
        unique_key = ['tx_hash', 'evt_index'],
        incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_time')]
    )
}}

{{
    uniswap_compatible_v2_trades(
        blockchain = 'kaia',
        project = 'kaia_swap',
        version = '3',
        Pair_evt_Swap = source('kaia_swap_v3_kaia', 'KaiaSwapPool_evt_Swap'),
        Factory_evt_PairCreated = source('kaia_swap_v3_kaia', 'KaiaSwapFactory_evt_NewPool')
    )
}}