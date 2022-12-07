# zaggro-sui-contracts

## Install SUI

https://docs.sui.io/build/install

Rust and Cargo
$curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

SUI (devnet)
$cargo install --locked --git https://github.com/MystenLabs/sui.git --branch devnet sui

<br>

## Build package

$sui move build

<br>

## Run tests

$sui move test

<br>

## Publish package

$sui client publish <OPTIONS> --gas-budget <GAS_BUDGET> <PATH_TO_PACKAGE>

$sui client publish --abi --gas-budget 30000 ./coin

## Coin functions

### Mint and transfer

$sui client call --type-args "<COIN TYPE>" \
 --args <TreasuryCap ADDRESS> <AMOUNT TO MINT> <ADDRESS TO TRANSFER> \
 --package 0x0000000000000000000000000000000000000002 \
 --module coin \
 --function mint_and_transfer \
--gas-budget 30000

$sui client call --type-args "0x6eed4da267a5cabc6f649bc74d0bce3f0973e72f::zaggro_coin::ZAGGRO_COIN" \
 --args 0x05079335344b726289e4d42abcb1a5484fb8bc75 100000000000000 0xac1aaf2acafa2f356b18058987a1bcb290f68c60 \
 --package 0x0000000000000000000000000000000000000002 \
 --module coin \
 --function mint_and_transfer \
--gas-budget 30000

### Split coin

$sui client split-coin --coin-id 0x9ea4871f38ad4d0f302654a49e8e8f1c42196b84 --gas-budget 1000 --amounts 500000 500000
$sui client split-coin --coin-id 0x9ea4871f38ad4d0f302654a49e8e8f1c42196b84 --gas-budget 1000 --count 3

## Transfer objects

$sui client transfer --to 0xfa84ba0a1024de1bae91d500392b7e3cf12186bf --object-id 0xce318153069e66a89e2a6881c674632608cee403 --gas-budget 1000
