#[test_only]

module zaggro::pool_factory_tests {
    use std::debug;

    use sui::sui::SUI;
    use sui::coin::{mint_for_testing as mint};
    use sui::test_scenario::{Self as test, Scenario, next_tx, ctx};
    
    use zaggro::pool_factory::{Self, ZAGGRO_POOL};
    use zaggro::zaggro_coin::ZAGGRO_COIN; 
    use zaggro::pool::{ Self, Pool };
  
    
    const SUI_AMT: u64 = 1000000000;
    const ZAGGRO_AMT: u64 = 1000000;

    // Tests section
    #[test] fun test_init_pool() {
        let scenario = scenario();
        test_init_pool_(&mut scenario);
        test::end(scenario);
    }

    fun test_init_pool_(test: &mut Scenario) { 
       let (owner, _) = people();
       next_tx(test, owner);
       {
          pool_factory::init_for_testing(ctx(test));
       };

       next_tx(test, owner);
       {
          pool_factory::create_pool<ZAGGRO_COIN>(
              mint<ZAGGRO_COIN>(ZAGGRO_AMT, ctx(test)),
              mint<SUI>(SUI_AMT, ctx(test)),
              3,
              ctx(test)
          );
       };

       next_tx(test, owner);
       {
            let pool = test::take_shared<Pool<ZAGGRO_POOL, ZAGGRO_COIN>>(test);
            let pool_mut = &mut pool;
            let (amt_sui, amt_tok, lsp_supply) = pool::get_amounts(pool_mut);

            debug::print(pool_mut);

            assert!(lsp_supply == 31622000, 0);
            assert!(amt_sui == SUI_AMT, 0);
            assert!(amt_tok == ZAGGRO_AMT, 0);

            test::return_shared(pool)
       }
    }



    // utilities
    fun scenario(): Scenario { test::begin(@0x1) }
    fun people(): (address, address) { (@0xBEEF, @0x1337) }
}