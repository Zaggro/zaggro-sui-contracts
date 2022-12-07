module zaggro::pool_factory {
  use zaggro::pool;
  use sui::coin::Coin;
  use sui::sui::SUI;
  use sui::transfer;
  use sui::tx_context::{Self, TxContext};

  struct ZAGGRO_POOL has drop {}
  
  fun init(_: &mut TxContext) {}

  entry public fun create_pool<T>(
    token: Coin<T>,
    sui: Coin<SUI>,
    fee_percent: u64,
    ctx: &mut TxContext
  ) {
    let lsp = pool::create_pool(ZAGGRO_POOL {}, token, sui, fee_percent, ctx);
    transfer::transfer(lsp, tx_context::sender(ctx))
  }

   #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(ctx)
    }
}