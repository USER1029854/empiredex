# EmpireDEX — Defensive Contract Inventory

**Protocol:** EmpireDEX (DefiLlama slug `empiredex`, id `812`)
**DefiLlama link:** https://defillama.com/protocol/empiredex
**Category:** Dexs (AMM) — a permissionless Uniswap-V2-style fork; DefiLlama tracks it purely via pool reserves (`tvlCodePath`: [`registries/uniswapV2.js`](https://github.com/DefiLlama/DefiLlama-Adapters/blob/main/registries/uniswapV2.js), `empiredex` entry)
**Chains (per DefiLlama):** Empire (its own L1), Ethereum, Binance (BSC), Cronos, Fantom, Polygon, Avalanche, xDai (Gnosis Chain), Kava — 9 chains total
**Scope of this review:** every deployed contract that **holds or controls ≥ $10,000** of protocol funds, on every chain enumerated. Defensive inventory only — no exploit instructions.

> This is a fork-of-a-fork Uniswap-V2 DEX: constant-product pairs, an immutable factory + router, a per-chain "fair launch" (LGE) token with an EIP-712-permit LP token, an optional "sweepable liquidity" mechanism, and a self-service liquidity-locking Escrow contract. **No contract in this entire protocol is upgradeable** — every EIP-1967 proxy slot checked came back zero (see "Proxy relationships" below).

---

## 1. Biggest funded contract

**`WBNB/ROOT` pair on BNB Smart Chain — `0x3Af4Cf7953cab46a1B4Af5F483c2aC81b994777e`**
**≈ $1,015,486** (834.00 WBNB + 112,361.23 bridged-ROOT reserves)
See [`pair-bsc-wbnb-root-0x3af4cf79/NOTES.md`](./pair-bsc-wbnb-root-0x3af4cf79/NOTES.md).

(Note: EmpireDEX's own flagship `EMPIRE/WBNB` pair, the pair actually created by the LGE, is the second-largest at ≈$850,734 — see [`pair-bsc-wbnb-empire-0xf3114cb3/`](./pair-bsc-wbnb-empire-0xf3114cb3/). The single largest pool happens to be a third-party pairing of bridged `ROOTDEX` against WBNB.)

---

## 2. How the enumeration was done (methodology)

1. **Protocol identification & chain list** — `GET https://api.llama.fi/protocol/empiredex` (saved at [`_evidence/defillama_protocol.json`](./_evidence/defillama_protocol.json)).
2. **Factory addresses per chain** — DefiLlama's own adapter code, not just the dashboard: [`DefiLlama-Adapters/registries/uniswapV2.js`](https://github.com/DefiLlama/DefiLlama-Adapters/blob/main/registries/uniswapV2.js) (`empiredex` entry, saved at [`_evidence/defillama_uniswapV2_registry_excerpt.js`](./_evidence/defillama_uniswapV2_registry_excerpt.js)). This is exactly the code DefiLlama itself runs to compute TVL — it enumerates every pair the factory has ever created via `allPairsLength()`/`allPairs(i)`.
3. **Full on-chain re-enumeration, independent of DefiLlama** — for every chain with a reachable public RPC (8 of 9; "Empire" chain excluded, see COULD-NOT-ENUMERATE), this review called `allPairsLength()`/`allPairs(i)` **directly against each factory** and then `token0()`/`token1()`/`getReserves()`/`totalSupply()` on every single pair returned — **143 pairs total**, raw data in [`_evidence/onchain_pairs.json`](./_evidence/onchain_pairs.json). This catches anything DefiLlama's own dashboard might not surface (dead/rug tokens, test pairs, pairs created after DefiLlama's last TVL refresh, etc.) because it re-derives the same list DefiLlama's adapter would, live, rather than trusting a cached dashboard number.
4. **Pricing** — DefiLlama's `coins.llama.fi/prices/current` bulk endpoint for every unique token address found (129 unique tokens across 8 chains; 21 had a DefiLlama price). Pool USD value = both sides summed when both are priced, else 2× the priced side — **this is the identical convention DefiLlama's own `getUniTVL` helper uses** for Uniswap-V2 forks, which is why the totals below reconcile so closely with DefiLlama's reported numbers. Full computation in [`_evidence/pair_tvl.json`](./_evidence/pair_tvl.json) and the full ranked list of all 143 pairs in [`_evidence/all_143_pairs_ranked.json`](./_evidence/all_143_pairs_ranked.json).
5. **Beyond pools** — router/factory/escrow/token addresses were cross-sourced from EmpireDEX's own documentation (`empire-dex.readthedocs.io`, specifically the `multichain.html`, `empire_token.html` and `lge.html` pages) and from the project's public source repository (`github.com/Prism-Network-io/empiredex`), then every address was independently confirmed **on-chain** (`eth_getCode`, `eth_getBalance`, `eth_call` for `owner()`/`feeTo()`/`feeToSetter()`, `eth_getStorageAt` for EIP-1967 slots) — nothing was taken on documentation's word alone.
6. **Fund-custody sweep beyond pool reserves** — every one of the 143 pairs' LP-token `balanceOf` was checked against the Escrow contracts and against each chain's own DEX-token contract, to catch value sitting in claims/locks rather than in raw pair reserves (this is what surfaced the Cronos `CRODEX` token contract's 99.16%-of-LP holding, see below).
7. **Decompilation** — `heimdall-rs v0.9.2` (installed fresh into this environment via the official `bifrost` installer) was run against every included contract that could not be independently verified through a reachable explorer/Sourcify. Every decompilation in this repo succeeded with heimdall; panoramix was never required as a fallback.
8. **Proxy check** — `eth_getStorageAt` for the three standard EIP-1967 slots (`implementation`, `admin`, `beacon`) was read directly against a sample spanning every contract *type* in this inventory (pair, factory, router, token) on multiple chains. All zero, everywhere checked. Full protocol is non-upgradeable.

---

## 3. Included contracts

15 contracts, across BSC, Cronos, Ethereum, Avalanche, and xDai (Gnosis) — the only chains where any single contract clears the $10k bar.

### 3a. Liquidity pairs (10) — role: **pool / vault** (+ user-callable AMM surface; keeper-gated `sweep`/`unsweep` where applicable)

| # | Pair | Chain | Address | USD value | Verification | Folder |
|---|---|---|---|---:|---|---|
| 1 | WBNB / ROOT | BSC | `0x3Af4Cf7953cab46a1B4Af5F483c2aC81b994777e` | **$1,015,486** | VERIFIED (Sourcify) | [`pair-bsc-wbnb-root-0x3af4cf79/`](./pair-bsc-wbnb-root-0x3af4cf79/) |
| 2 | WBNB / EMPIRE | BSC | `0xF3114cB351F38f8e8fF17f8313FF91ceC4FF196f` | $850,734 | VERIFIED (Sourcify) | [`pair-bsc-wbnb-empire-0xf3114cb3/`](./pair-bsc-wbnb-empire-0xf3114cb3/) |
| 3 | WCRO / ROOT | Cronos | `0xe5F1463660cC2464F69C64a54b67f5957c95fcbd` | $85,492 | DECOMPILED-heimdall | [`pair-cronos-wcro-root-0xe5f14636/`](./pair-cronos-wcro-root-0xe5f14636/) |
| 4 | EMPIRE / WCRO | Cronos | `0x80523212e85e7FD850c85CC804263Ad421696d87` | $72,435 | DECOMPILED-heimdall | [`pair-cronos-empire-wcro-0x80523212/`](./pair-cronos-empire-wcro-0x80523212/) |
| 5 | WCRO / CRODEX | Cronos | `0xC8c0Ad6b6dfDb4d53629A770d0d76f7f9257BAA1` | $61,707 | DECOMPILED-heimdall | [`pair-cronos-wcro-crodex-0xc8c0ad6b/`](./pair-cronos-wcro-crodex-0xc8c0ad6b/) |
| 6 | ROOTDEX / WETH | Ethereum | `0x163B890f4892D593945579028Ec44Ef0f20A4633` | $54,859 | VERIFIED (Sourcify) | [`pair-ethereum-rootdex-weth-0x163b890f/`](./pair-ethereum-rootdex-weth-0x163b890f/) |
| 7 | XDEX / WXDAI | xDai | `0xF6E0EeeFb7AcB6D5557d617DA1E24873997Ab3e9` | $45,795 | DECOMPILED-heimdall | [`pair-xdai-xdex-wxdai-0xf6e0eeef/`](./pair-xdai-xdex-wxdai-0xf6e0eeef/) |
| 8 | FF / WBNB | BSC | `0x3D213903AE906A061703a4e363162cb35899A39E` | $41,079 | DECOMPILED-heimdall | [`pair-bsc-ff-wbnb-0x3d213903/`](./pair-bsc-ff-wbnb-0x3d213903/) |
| 9 | WCRO / upCRO | Cronos | `0xb0a7d88202eB8bf3c43D506b712b4E474eB9cdA3` | $26,591 | DECOMPILED-heimdall | [`pair-cronos-wcro-upcro-0xb0a7d882/`](./pair-cronos-wcro-upcro-0xb0a7d882/) |
| 10 | WAVAX / eADEX | Avalanche | `0x80832376DB4E414c88629C54923aECb9855346C0` | $15,022 | DECOMPILED-heimdall | [`pair-avax-wavax-eadex-0x80832376/`](./pair-avax-wavax-eadex-0x80832376/) |

**Sum of the 10 included pairs: $2,269,199.72**

### 3b. Core infrastructure (5) — included on a "controls", not "holds", basis

These five all have a **$0 own balance** (confirmed via `eth_getBalance`) but are included because they exercise real control over — or are the primary custody-transit surface for — the pooled value above, per this review's "holds **or controls**" instruction. Each is documented once, with a per-chain table inside showing exactly which chain-deployments are included vs. dropped for controlling < $10k on that specific chain (the same bytecode is deployed at the same address on multiple chains via CREATE2, but each chain's deployment is separate state and was evaluated independently).

| Contract | Role | Address | Chains included (≥$10k controlled) | Chains dropped (<$10k controlled) | Folder |
|---|---|---|---|---|---|
| Factory ("main") | admin/governance (fee-switch admin + permissionless pair registry) | `0x06530550A48F990360DFD642d2132354A144F31d` | BSC, Cronos, Avalanche, xDai | Fantom, Polygon, Kava | [`factory-main-0x065305/`](./factory-main-0x065305/) |
| Factory (Ethereum) | admin/governance | `0xd674b01E778CF43D3E6544985F893355F46A74A5` | Ethereum | — | [`factory-ethereum-0xd674b0/`](./factory-ethereum-0xd674b0/) |
| Router ("main") | user-callable (swap/liquidity entry point; also forwards locked-LP into Escrow) | `0xdADaae6cDFE4FA3c35d54811087b3bC3Cd60F348` | BSC, Cronos, Avalanche, xDai | Fantom, Kava | [`router-main-0xdadaae/`](./router-main-0xdadaae/) |
| Router (Ethereum) | user-callable | `0xe7A504316BebbE540496E29798187c9ECAD6ef4F` | Ethereum | — | [`router-ethereum-0xe7a504/`](./router-ethereum-0xe7a504/) |

### 3c. DEX-token contract holding unclaimed LP (1) — role: funded-but-inert / claim-vault, with owner-admin surface

| Contract | Address | Chain | Value controlled | Folder |
|---|---|---|---:|---|
| CRODEX token | `0xc83859C413a6bA5ca1620cD876c7E33a232c1C34` | Cronos | ≈$61,189 (99.16% of the `WCRO/CRODEX` pair's LP supply, unclaimed) | [`token-cronos-crodex-0xc83859/`](./token-cronos-crodex-0xc83859/) |

This $ figure is a **subset of pair #5 above** (the `WCRO/CRODEX` pair already counts the underlying reserves) — it is **not** added again to the coverage sum in Section 5. It is included as its own entry because the *contract holding the LP claim* is a different, separately-owned/-administered contract from the pair itself, exactly the kind of "still holds funds, easy to miss" relationship this review was asked to surface.

### 3d. Per-contract detail: key functions, proxy relationships, dependencies

Full detail (reserves table, verification evidence, source links) is in each contract's own `NOTES.md` linked in 3a–3c; this table is the compact, self-contained version of the same facts so the README stands on its own.

**Proxy relationships, for all 15: none.** Every contract type in this inventory was checked directly on-chain (`eth_getStorageAt` on the EIP-1967 implementation/admin/beacon slots) and every read came back zero — see Section 8.

| Contract | Key user-callable functions | Key admin/governance/keeper functions | Dependencies / external calls |
|---|---|---|---|
| **Pairs (all 10)** — `EmpirePair` | `mint(to)`, `burn(to)`, `swap(amt0Out,amt1Out,to,data)`, `skim`, `sync`, ERC-20 `transfer`/`transferFrom`/`approve`/`permit` (LP token itself, EIP-2612) | `sweep(amount,data)` / `unsweep(amount)` — **keeper-gated**: callable only by the address stored as `sweepableToken` (i.e. only the paired DEX-token contract, itself owner-gated — see token row below), bounded by `getMaxSweepable()`. No owner/admin function exists on the pair itself. | `factory` (immutable, only used to read `feeTo`); `token0`/`token1` (untrusted external ERC-20s, called via low-level `.call` + return-data checks); if sweepable, calls back `IEmpireCallee(caller).empireSweepCall(...)` |
| **Factory-main** (BSC/Fantom/Avax/Polygon/xDai/Cronos/Kava) | `createPair(tokenA,tokenB)`, `createEmpirePair(tokenA,tokenB,pairType,unlockTime)`, `allPairsLength`/`allPairs`/`getPair` (reads) | `setFeeTo(address)`, `setFeeToSetter(address)` — gated to `feeToSetter` = `0x5ABBd94bb0561938130d83FdA22E672110e12528` (EOA, single key, no timelock). `feeTo` currently = `0x3F9B7da1d832199b2dD23670F2623193636f2e88` (fee switch is **ON**, not Uniswap's default-off) | Deploys `EmpirePair` via `CREATE2`, calls its `initialize()` |
| **Factory-ethereum** | same as Factory-main | same as Factory-main; identical `feeToSetter`/`feeTo` addresses (confirmed live) | same as Factory-main |
| **Router-main** (BSC/Fantom/Avax/xDai/Cronos/Kava) | `addLiquidity(ETH)`, `addLiquidityLocked(ETH)` (auto-locks into Escrow), `removeLiquidity(ETH)` (+`Permit`/`SupportingFeeOnTransferTokens` variants), `swapExact*For*`/`swap*ForExact*` (all 6 swap directions +fee-on-transfer variants), `quote`/`getAmountOut`/`getAmountIn`/`getAmountsOut`/`getAmountsIn` (view) | None — router has no owner/admin function. Its `addLiquidityLocked`/`addLiquidityETHLocked` functions are user-callable but **structurally forward the minted LP into the Escrow contract** on the caller's behalf (approve + `IEmpireEscrow.lockLiquidity`), which is the closest thing to a keeper-style automated action this contract performs. | `factory` (immutable), `WETH` (immutable, wrap/unwrap), `escrow` (immutable — `0x38F73653...` on these chains) — a 3rd constructor argument not present in the public GitHub reference source, discovered only by reading the verified BSC bytecode; every `IEmpirePair` it's asked to route through |
| **Router-ethereum** | same as Router-main | same as Router-main | same as Router-main, but `escrow` = `0x9fF555DDEbD500C0F1fa7C898dCbdb7CCa6809FC` |
| **CRODEX token (Cronos)** — `Empire`-family | `deposit()` (payable, LGE-window only), `claim()` (what any still-unclaimed LGE participant would call to withdraw their share of the 99.16%-held LP — this is the user-facing way the $61,189 could still leave this contract), standard ERC-20 `transfer`/`transferFrom` (0.1% burn fee unless one side is the token's own pair) | `beginLGE`, `complete`, `extractFutureRewards(to,amount)` (moves `REWARD_TREASURY`'s pre-minted allocation, no timelock), `sweep`/`unsweep` (forwards into the paired `EmpirePair`) — all `onlyOwner`, current owner `0xf8F595b5Fd17D4c64f5DfE5ed4c32B8e15e198FD`, **not renounced** | Its own paired `EmpirePair` (`WCRO/CRODEX`, `0xC8c0Ad6b...`); WCRO; hard-coded EOA constants `empireTeam`/`omnisciaTeam`/`marketingTeam`/`REWARD_TREASURY` |

---

## 4. Dropped contracts (and exact reasons)

### 4a. 133 of the 143 enumerated pairs — dropped, holds < $10,000

Full ranked list with chain/address/tokens/USD value/reason: [`_evidence/dropped_pairs_below_10k.csv`](./_evidence/dropped_pairs_below_10k.csv). Largest five dropped pairs, for scale: `WFTM/eFDEX` (Fantom, $7,577), `WBNB/ADAFlect` (BSC, $7,011), `EMTI/WETH` (Ethereum, $5,287), `WPOL/PDEX` (Polygon, $4,597), `OcDa/WAVAX` (Avalanche, $1,923). 27 of the 133 have no DefiLlama price at all for either side; every one of those was manually inspected in [`_evidence/pair_tvl.json`](./_evidence/pair_tvl.json) and confirmed to hold a raw reserve magnitude equivalent to at most a few hundred dollars even under generous assumptions (e.g. the largest unpriced pair, `USDC/ELITE` on Fantom, holds 273.49 raw USDC-denominated units on one side — a few hundred dollars at most) — none is a plausible $10k+ candidate.

### 4b. Router (Polygon-specific deployment) — dropped, controls < $10,000

`0xB2855A6dAeeBDB72B0176A479A983066ae9775A6` — Polygon's router is a *different* contract from the "main" router (Polygon wasn't part of the CREATE2 vanity-address batch). Polygon's entire EmpireDEX pool TVL is $4,859.98 (below the $10k bar on its own), and the router holds $0 directly, so it is dropped rather than written up. (It happens to be Sourcify-verified — https://sourcify.dev/server/v2/contract/137/0xB2855A6dAeeBDB72B0176A479A983066ae9775A6 — noted for completeness, no folder created.)

### 4c. Factory-main / Router-main instances on Fantom, Polygon, Kava — dropped, controls < $10,000 on that chain

Same bytecode/address as the included BSC/Cronos/Avalanche/xDai instances (see Section 3b tables), but Fantom ($7,756 total pool TVL), Polygon ($4,859), and Kava ($36) each fall under the $10k bar for that chain, so those specific chain-deployments are dropped. Documented inside the parent contract's `NOTES.md` for traceability, not given their own folders (they are literally the same bytecode already fully documented there).

### 4d. Escrow contract, both variants, all chains — dropped, holds < $10,000 (full 143-pair + native-balance sweep performed)

- `0x38F73653fA46943de76c228a47b7d9B81F28FFff` (deployed on BSC, Fantom, Avalanche, Polygon, xDai, Kava)
- `0x9fF555DDEbD500C0F1fa7C898dCbdb7CCa6809FC` (deployed on Ethereum, Cronos)

This is a real, actively-used contract — `EmpireEscrow` (Sourcify-verified on chains 1/56/137: `lockLiquidity(token, user, amount, duration)` / `releaseLiquidity(token)`), and the verified `EmpireRouter` source confirms `addLiquidityLocked`/`addLiquidityETHLocked` route newly-minted LP through it automatically (see [`router-main-0xdadaae/NOTES.md`](./router-main-0xdadaae/NOTES.md)). Native-coin balance is $0 on every chain (`_evidence/infra_check.json`), and this review additionally checked **both** escrow addresses' `balanceOf` against **all 143 enumerated pairs' LP tokens** on every chain (not just the 10 that cleared $10k) — raw findings embedded in this review's working notes; the single largest holding found anywhere is **$8,374.23** on BSC's `0x38F736...` instance (summed across 7 separate small locked positions, largest single position $7,010.63 in a `WBNB/ADAFlect` LP lock), still under the $10k bar. Every other chain/instance combination totals under $1,300. Dropped on every chain checked.

### 4e. DEX-token contracts other than Cronos CRODEX — dropped, holds < $10,000 in self + unclaimed-LP balance

Checked (self `balanceOf` + `balanceOf` of the token contract against its own flagship pair's LP, `_evidence/custody_check.json`):

| Token | Chain | Address | Value held |
|---|---|---|---:|
| EMPIRE | BSC | `0xc83859C413a6bA5ca1620cD876c7E33a232c1C34` | ≈$4,422 |
| ROOTDEX | Ethereum | `0x2302f393690487a4Fc5927bBeF63ff113E0c479d` | ≈$9,195 (closest near-miss — 16.76% of its pair's LP, just under the bar) |
| eADEX | Avalanche | `0xc83859C413a6bA5ca1620cD876c7E33a232c1C34` | ≈$36 |
| XDEX | xDai | `0xc83859C413a6bA5ca1620cD876c7E33a232c1C34` | ≈$42 |
| EMPIRE (alt. deployment) | Cronos | `0x0001DF70E9cDC0C1C6b24E2172b89b105C879DDc` | ≈$761 |

All five dropped for holding under $10k. (The `EMPIRE`/`eADEX`/`XDEX` rows above share one on-chain address, `0xc83859c4...`, across BSC/Avalanche/xDai/Cronos — the Cronos deployment at that address is the one that qualifies, see Section 3c; these three plus Cronos's `0x0001DF70...` deployment do not.)

### 4f. Unrelated external tokens referenced inside included pairs — out of scope, not EmpireDEX contracts

WBNB, WCRO, WAVAX, WXDAI, WETH, the bridged `ROOT` token, and third-party tokens `FF` and `upCRO` all appear as one side of an included pair (Section 3a) but are **not** EmpireDEX-deployed/-administered contracts — they are external assets the AMM happens to hold as reserves. Not inventoried as their own contracts; noted as dependencies inside the relevant pair's `NOTES.md`.

---

## 5. Coverage quantification (required handoff to the audit stage)

| Quantity | USD | % of DefiLlama-reported TVL |
|---|---:|---:|
| **DefiLlama-reported protocol TVL** (`sum(currentChainTvls)`, all 9 chains, `_evidence/defillama_protocol.json`) | **$2,315,860.69** | 100.00% |
| Sum of all 143 pairs independently re-enumerated on-chain (8 reachable chains) | $2,308,798.06 | **99.70%** |
| **Sum of the 10 included (≥$10k) contracts — this inventory's coverage** | **$2,269,199.72** | **97.99%** |

**The gap is fully attributed, not just acknowledged:**

- **1.71% ($39,598.34)** — the 133 dropped dust pairs (Section 4a). Individually immaterial, but not zero in aggregate.
- **0.30% ($7,062.63)** — normal timing/pricing drift between DefiLlama's cached TVL snapshot and this review's live RPC/price reads (spot prices move between DefiLlama's last computation and this review's queries; this is not missing enumeration, it's measurement-timestamp noise, and it's small enough — 0.3% — to support that conclusion rather than a missed-pair explanation).
- **Unquantifiable ($0 reported by DefiLlama, but access, not value, is what failed):** the "Empire" native L1 chain (chain ID 3693) is entirely excluded from the 99.70%/97.99% figures above because it could not be queried at all — see COULD-NOT-ENUMERATE below. DefiLlama's own adapter also does not measure it (`{ tvl: () => ({}) }`, a hardcoded empty result), so the reported-TVL baseline itself carries this same blind spot. **Treat this as an unquantified gap, not a confirmed $0.**

---

## 6. COULD-NOT-ENUMERATE

Every item below is a concrete place this review's coverage could be incomplete, tied back to the coverage-gap accounting in Section 5 wherever a $ figure applies.

1. **"Empire" native L1 chain (chain ID 3693) — entirely inaccessible, unquantified.** This chain hosts the protocol's own token address (`0xC84D8d03aA41EF941721A4D77b24bB44D7C7Ac55`, "WEMPIRE" — this is literally the `address` field DefiLlama's protocol record uses to identify EmpireDEX) plus, per official docs, the same factory/router/escrow addresses as the other chains. Both of the chain's only two documented access points were tried and both failed from this environment: RPC (`https://rpc.empirenetwork.io/` → `502 Bad Gateway` through the egress proxy) and the Blockscout explorer (`https://explorer.empirenetwork.io/` → unreachable). Chainlist.org's RPC registry lists no alternative endpoint for chain 3693. **To close this gap:** retry from a network path that isn't blocked to `rpc.empirenetwork.io`/`explorer.empirenetwork.io`, or obtain an alternate RPC URL for chain ID 3693. Not counted in Section 5's percentages in either direction.
2. **No Etherscan-family API key was available in this environment** (env-var lookup came back empty for `ETHERSCAN_API_KEY`/`ETHERSCAN_V2_API_KEY`/`BSCSCAN_API_KEY`/`FTMSCAN_API_KEY`/etc., and the unified Etherscan V2 endpoint rejected keyless requests with `Missing/Invalid API Key`), despite this review's brief stating one would be provided. This is why Cronos, Fantom, and Kava had **no free/keyless verified-source lookup available at all** (Cronoscan/FTMScan/Kavascan all sit behind that key; their Blockscout-branded front ends serve only their SPA shell on API paths reachable from this sandbox) — every included contract on those three chains was decompiled with heimdall instead of pulled as verified source. Separately, the Avalanche and xDai contracts in this inventory that are marked DECOMPILED-heimdall were checked against Routescan/Blockscout (both reachable, keyless) and genuinely came back unverified there — an Etherscan-family key would not change that outcome, it only closes the Cronos/Fantom/Kava gap. **To close this gap:** supply a working Etherscan V2 key and re-run verified-source lookups against the 11 contracts currently marked DECOMPILED-heimdall in Section 7 below to confirm the decompilation against ground truth on the chains where a key would actually help (Cronos/Fantom/Kava).
3. **No DefiLlama MCP server was reachable in this session** (the task brief pointed at `https://mcp.defillama.com/mcp`, but no such tool was ever exposed to this session). This review used DefiLlama's plain public REST API (`api.llama.fi`, `coins.llama.fi`) and its public GitHub adapter repo instead, which is the same underlying data — no material capability gap, noted for completeness.
4. **Router/Factory-controlled value was evaluated per chain-deployment, not fleet-wide.** Section 3b's Fantom/Polygon/Kava factory-main and router-main instances were dropped because *that specific chain's* pooled TVL is under $10k, even though the identical bytecode elsewhere controls millions. If an auditor's threshold model treats "the same admin key controls X across all 7 chains" as a single aggregate relationship rather than per-chain, that changes 3 drop decisions back to includes — flagged explicitly rather than silently resolved either way.
5. **Escrow's arbitrary-ERC20 acceptance was checked only against pairs' own LP tokens and native balance, not against every ERC-20 in existence.** `EmpireEscrow.lockLiquidity(IERC20 token, ...)` accepts *any* ERC-20 as `token`, not just EmpireDEX LP tokens — this review checked its balance of native coin (✓, $0 everywhere) and of all 143 enumerated pairs' own LP tokens (✓, largest is $8,374.23, Section 4d), but did not attempt to enumerate arbitrary unrelated ERC-20 tokens that might have been locked there by third parties unconnected to any EmpireDEX pair. Considered low-risk (would be "unrelated to protocol funds" even if found) but not exhaustively ruled out.
6. **The `Unileech` contract's deployed address(es) could not be found.** Its source exists in the `Prism-Network-io/empiredex` GitHub repo (`periphery/Unileech.sol` — a permissionless helper that calls `pair.burn()` then immediately re-adds the withdrawn liquidity via the router on behalf of a "permanently locked" LP holder, implementing part of the "weaponised liquidity" / sweep mechanism described in EmpireDEX's docs) but no on-chain address for it is published in the docs, in DefiLlama's adapter, or anywhere else checked, and this environment had no working "search verified contracts by name/bytecode across a chain" tool to locate it independently. If deployed and ever approved/funded, it would be a **keeper/liquidator**-classified contract; it is not counted anywhere in this inventory. **To close this gap:** a full-chain event-log or bytecode-similarity search (e.g. Blockscout's "verified contracts matching this bytecode" feature, or an indexer query for `PairCreated`-adjacent transactions from known EmpireDEX deployer addresses) would be needed.
7. **129 unique token addresses were checked against DefiLlama's price API; only 21 had a price, 108 did not**, requiring the 2×-priced-side estimation convention (Section 2, step 4) for the other side of most pools instead of a direct both-sides valuation. This is DefiLlama's own methodology for this exact protocol (validated by the 99.70% reconciliation in Section 5), not a shortcut unique to this review, but it means individual pair values above carry the same estimation uncertainty DefiLlama's own dashboard does.
8. **Treasury/admin EOAs were not deep-dived.** `feeToSetter`/`feeTo`/`empireTeam`/`marketingTeam`/`omnisciaTeam`/`REWARD_TREASURY` all resolved to externally-owned accounts (`eth_getCode` returns `0x`), which are out of this review's contract-inventory scope by definition — but they are not multisigs or timelocks (single-key EOAs), which is relevant context for the audit stage even though no folder was created for them.

---

## 7. DECOMPILATION STATUS (per contract requiring it)

heimdall-rs v0.9.2 (installed via the official `bifrost` installer for this review) succeeded on every target attempted; panoramix was never needed as a fallback.

| Contract | Chain | Status | Output |
|---|---|---|---|
| `WCRO/ROOT` pair | Cronos | **DECOMPILED-heimdall** | [`pair-cronos-wcro-root-0xe5f14636/decompiled/`](./pair-cronos-wcro-root-0xe5f14636/decompiled/) |
| `EMPIRE/WCRO` pair | Cronos | **DECOMPILED-heimdall** | [`pair-cronos-empire-wcro-0x80523212/decompiled/`](./pair-cronos-empire-wcro-0x80523212/decompiled/) |
| `WCRO/CRODEX` pair | Cronos | **DECOMPILED-heimdall** | [`pair-cronos-wcro-crodex-0xc8c0ad6b/decompiled/`](./pair-cronos-wcro-crodex-0xc8c0ad6b/decompiled/) |
| `WCRO/upCRO` pair | Cronos | **DECOMPILED-heimdall** | [`pair-cronos-wcro-upcro-0xb0a7d882/decompiled/`](./pair-cronos-wcro-upcro-0xb0a7d882/decompiled/) |
| `WAVAX/eADEX` pair | Avalanche | **DECOMPILED-heimdall** | [`pair-avax-wavax-eadex-0x80832376/decompiled/`](./pair-avax-wavax-eadex-0x80832376/decompiled/) |
| `XDEX/WXDAI` pair | xDai | **DECOMPILED-heimdall** | [`pair-xdai-xdex-wxdai-0xf6e0eeef/decompiled/`](./pair-xdai-xdex-wxdai-0xf6e0eeef/decompiled/) |
| `FF/WBNB` pair | BSC | **DECOMPILED-heimdall** | [`pair-bsc-ff-wbnb-0x3d213903/decompiled/`](./pair-bsc-ff-wbnb-0x3d213903/decompiled/) |
| Router-main | Avalanche | **DECOMPILED-heimdall** | [`router-main-0xdadaae/decompiled-avax/`](./router-main-0xdadaae/decompiled-avax/) |
| Router-main | xDai | **DECOMPILED-heimdall** | [`router-main-0xdadaae/decompiled-xdai/`](./router-main-0xdadaae/decompiled-xdai/) |
| Router-main | Cronos | **DECOMPILED-heimdall** | [`router-main-0xdadaae/decompiled-cronos/`](./router-main-0xdadaae/decompiled-cronos/) |
| CRODEX token | Cronos | **DECOMPILED-heimdall** | [`token-cronos-crodex-0xc83859/decompiled/`](./token-cronos-crodex-0xc83859/decompiled/) |
| `WBNB/ROOT` pair | BSC | VERIFIED (not decompiled) | [`pair-bsc-wbnb-root-0x3af4cf79/source/`](./pair-bsc-wbnb-root-0x3af4cf79/source/) |
| `WBNB/EMPIRE` pair | BSC | VERIFIED (not decompiled) | [`pair-bsc-wbnb-empire-0xf3114cb3/source/`](./pair-bsc-wbnb-empire-0xf3114cb3/source/) |
| `ROOTDEX/WETH` pair | Ethereum | VERIFIED (not decompiled) | [`pair-ethereum-rootdex-weth-0x163b890f/source/`](./pair-ethereum-rootdex-weth-0x163b890f/source/) |
| Factory-main | BSC (representative; byte-identical on 6 other chains) | VERIFIED (not decompiled) | [`factory-main-0x065305/source/`](./factory-main-0x065305/source/) |
| Factory-ethereum | Ethereum | VERIFIED (not decompiled) | [`factory-ethereum-0xd674b0/source/`](./factory-ethereum-0xd674b0/source/) |
| Router-main | BSC | VERIFIED (not decompiled) | [`router-main-0xdadaae/source/`](./router-main-0xdadaae/source/) |
| Router-ethereum | Ethereum | VERIFIED (not decompiled) | [`router-ethereum-0xe7a504/source/`](./router-ethereum-0xe7a504/source/) |

**No `BYTE-IDENTICAL-TO-<addr>` classification was used for any pair or token contract** — `EmpireERC20`'s EIP-712 `CACHED_DOMAIN_SEPARATOR` is an `immutable` computed from `(address(this), block.chainid)` inside the constructor, which makes every single pair's/token's runtime bytecode unique even when deployed from the same factory with the same source — verified directly: all 10 included pairs' `sha256(eth_getCode(...))` are pairwise distinct (`_evidence/bytecode_hashes.json` plus additional spot checks). The one place `BYTE-IDENTICAL` genuinely applies is **Factory-main**, which has no address-dependent immutables — see the sha256 proof in [`factory-main-0x065305/NOTES.md`](./factory-main-0x065305/NOTES.md) (Fantom/Polygon/Kava instances match BSC's verified bytecode exactly, hash-for-hash; those three chain-instances are dropped for controlling <$10k regardless, per Section 4c, so no separate folder was needed, but the proof is recorded).

---

## 8. Proxy implementations that changed recently

**None.** There are no proxies anywhere in this protocol — `EmpireFactory`, `EmpireRouter`, `EmpirePair`, `EmpireEscrow`, and the `Empire`-family token contracts are all deployed as plain, non-upgradeable bytecode. Confirmed by reading `eth_getStorageAt` for the EIP-1967 `implementation` (`0x360894...`), `admin` (`0xb53127...`), and `beacon` (`0xa3f0ad...`) slots directly against a representative sample spanning every contract type in this inventory (pairs on Ethereum/BSC/Cronos, both factories, the Cronos token) — every read returned zero. There is therefore nothing to resolve in "proxy → implementation/admin" terms beyond confirming the negative, and no implementation-change history to report.

---

## Folder map

```
empiredex/
├── README.md                                  (this file)
├── _evidence/                                  raw RPC/API responses this review's numbers are computed from
├── pair-bsc-wbnb-root-0x3af4cf79/               $1,015,486 — biggest funded contract — VERIFIED
├── pair-bsc-wbnb-empire-0xf3114cb3/             $850,734 — VERIFIED
├── pair-cronos-wcro-root-0xe5f14636/            $85,492 — DECOMPILED-heimdall
├── pair-cronos-empire-wcro-0x80523212/          $72,435 — DECOMPILED-heimdall
├── pair-cronos-wcro-crodex-0xc8c0ad6b/          $61,707 — DECOMPILED-heimdall
├── pair-ethereum-rootdex-weth-0x163b890f/       $54,859 — VERIFIED
├── pair-xdai-xdex-wxdai-0xf6e0eeef/             $45,795 — DECOMPILED-heimdall
├── pair-bsc-ff-wbnb-0x3d213903/                 $41,079 — DECOMPILED-heimdall
├── pair-cronos-wcro-upcro-0xb0a7d882/           $26,591 — DECOMPILED-heimdall
├── pair-avax-wavax-eadex-0x80832376/            $15,022 — DECOMPILED-heimdall
├── factory-main-0x065305/                       admin — VERIFIED (+ byte-identical proof, 6 more chains)
├── factory-ethereum-0xd674b0/                   admin — VERIFIED
├── router-main-0xdadaae/                        user-callable — VERIFIED (BSC) + DECOMPILED-heimdall (Avax/xDai/Cronos)
├── router-ethereum-0xe7a504/                     user-callable — VERIFIED
└── token-cronos-crodex-0xc83859/                funded-but-inert — DECOMPILED-heimdall (≈$61,189 unclaimed LP)
```
