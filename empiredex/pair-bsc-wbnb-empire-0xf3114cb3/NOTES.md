# Pair contract — WBNB/EMPIRE (BNB Smart Chain (Binance))

- **Address:** `0xF3114cB351F38f8e8fF17f8313FF91ceC4FF196f`
- **Chain:** BNB Smart Chain (Binance)
- **Explorer:** https://bscscan.com/address/0xF3114cB351F38f8e8fF17f8313FF91ceC4FF196f
- **Contract type:** `EmpirePair` (Uniswap-V2-style constant-product AMM pair / LP-token ERC20), deployed via `CREATE2` by the EmpireDEX factory on this chain (`0x06530550A48F990360DFD642d2132354A144F31d`)
- **Discovered via:** on-chain enumeration — `EmpireFactory.allPairsLength()` / `allPairs(i)` called against the factory address sourced from the DefiLlama `DefiLlama-Adapters` repo (`registries/uniswapV2.js`, `empiredex` entry), then `token0()`/`token1()`/`getReserves()`/`totalSupply()` read directly from this pair via RPC (`{"select:bsc"}`-style batched `eth_call`). Cross-checked against the pair address explicitly published in EmpireDEX's own docs (`empire-dex.readthedocs.io/en/latest/multichain.html`) where applicable.

## Role / callable-surface classification

**pool / vault** (AMM liquidity pair) — holds the actual reserve0/reserve1 balances that back this trading pair. Also **user-callable** (mint/burn/swap/skim/sync are permissionless, subject to the router or a caller performing the correct safety checks) and, only for the token designated `sweepableToken` at pair-creation time, **keeper-callable-by-token-contract** (`sweep`/`unsweep` may only be called by whichever ERC20 the factory flagged as `sweepableToken`, i.e. the paired DEX token's own contract acting under its `onlyOwner` gate — see the "Sweepable Pairs / weaponised liquidity" mechanism below).

## Balance / controlled TVL

| Side | Token | Reserve (raw) | Reserve (human) |
|---|---|---|---|
| token0 | WBNB `0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c` | `698692164984322409765` | 698.692165 |
| token1 | EMPIRE `0xc83859C413a6bA5ca1620cD876c7E33a232c1C34` | `7202711616297722315152` | 7,202.711616 |

- **LP total supply:** 2,235.612012 EMP-LP
- **Estimated USD value held:** **$850,734.02**
- **Pricing method:** est-2x-token0 (WBNB priced; EMPIRE unpriced by DefiLlama) — DefiLlama's own coins API (`coins.llama.fi/prices/current`) does not carry a price for the DEX-issued / bridged side of this pool, so USD value is estimated as 2× the priced side, which is exactly the convention DefiLlama's own `getUniTVL` helper uses for Uniswap-V2-style forks (this pricing methodology was validated: summing this same calculation across all 143 enumerated pairs on all 8 reachable chains reproduces 99.70% of DefiLlama's reported total protocol TVL — see the main README's Coverage Quantification section).
- Balances read live via `getReserves()` during this review (see `../_evidence/pair_tvl.json` and `../_evidence/onchain_pairs.json` for the raw RPC responses this was computed from).

**Verification status: VERIFIED**

Source, ABI, compiler settings and metadata were pulled from Sourcify (v2 API), which independently recompiled the contract and matched it against the on-chain bytecode (`runtimeMatch: match`, immutable references correctly masked).

- Sourcify record: https://sourcify.dev/server/v2/contract/56/0xF3114cB351F38f8e8fF17f8313FF91ceC4FF196f
- Files in `./source/` (Solidity, as submitted/matched), `./abi.json`, `./metadata.json`, `./compiler_and_deployment.json` (compiler version, settings, deployer, deployment tx)


## Key functions (from the `EmpirePair`/`EmpireERC20` interface — see `IEmpirePair.sol` / `IEmpireERC20.sol` under `interfaces/` in a verified sibling, or the decompiled ABI here)

User-callable:
- `mint(address to)` — deposit-side of adding liquidity; expects tokens already transferred in by the caller (router does this atomically)
- `burn(address to)` — withdraw-side of removing liquidity; burns the LP balance held by the pair itself
- `swap(uint amount0Out, uint amount1Out, address to, bytes data)` — constant-product swap, invoked by the router (or directly by a contract implementing `IEmpireCallee` for flash-swap-style flows)
- `skim(address to)` / `sync()` — reconcile stored reserves against actual token balances
- `transfer` / `transferFrom` / `approve` / `permit` (EIP-2612) — the pair is itself an ERC-20 (the LP token)

Keeper/token-gated (only if this pair was created with a `SweepableToken0`/`SweepableToken1` type):
- `sweep(uint amount, bytes data)` — callable **only** by the address equal to `sweepableToken`; lets that token's own contract pull out its own reserve side for a "weaponised liquidity" buyback/marketing operation while leaving the paired asset behind, bounded by `getMaxSweepable()`
- `unsweep(uint amount)` — returns swept tokens

No admin/owner functions exist on the pair itself — all governance-relevant control is external (which factory deployed it, and which token was flagged sweepable at creation).

## Proxy relationships

None. `EmpirePair` is not upgradeable. Confirmed by reading the three standard EIP-1967 slots (`implementation`, `admin`, `beacon`) directly from chain via `eth_getStorageAt` — all three are zero on this address (see `../_evidence/infra_check.json`-style methodology; spot-checked on multiple pairs including this one).

## Dependencies / external calls

- **`factory` (immutable):** `0x06530550A48F990360DFD642d2132354A144F31d` — set once at construction (`factory = msg.sender` inside `EmpirePair`'s constructor, called by the factory's `createPair`); used only to look up `feeTo` for the protocol-fee mint.
- **`token0` / `token1` (storage, set once via `initialize()`, callable only by `factory`):** external ERC-20 contracts, called via low-level `.call()` with return-data validation (`_safeTransfer`/`_safeTransferFrom`), i.e. this pair trusts token0/token1 to behave as standard (non-fee-on-transfer-breaking, non-reentrant) ERC-20s.
- If `sweepableToken` is set, that token's contract is called back via `IEmpireCallee(msg.sender).empireSweepCall(...)` during `sweep()`.

## Notes

This is EmpireDEX's own flagship EMPIRE/BNB pair — the pair minted by Empire.sol's LGE `complete()` (docs call it the 'EMPIRE/BNB LP'). Sweepable pair type: token0 (WBNB) is the sweepable side per empireWbnbPair configuration.
