# Factory contract — "main" deployment (BSC / Fantom / Avalanche / Polygon / xDai / Cronos / Kava)

- **Address:** `0x06530550A48F990360DFD642d2132354A144F31d` (identical address on all 7 chains listed above, via CREATE2 vanity deployment)
- **Contract type:** `EmpireFactory` (Uniswap-V2-style pair registry/deployer)
- **Discovered via:** DefiLlama `DefiLlama-Adapters` GitHub repo, `registries/uniswapV2.js`, `empiredex` entry (`avax`/`bsc`/`cronos`/`fantom`/`kava`/`polygon`/`xdai` all list this exact address as `factory`). Cross-checked against `empire-dex.readthedocs.io/en/latest/multichain.html`, which independently publishes the same address for BSC/Fantom/Avalanche/xDai/Cronos.

## Role / callable-surface classification

**admin/governance** (registry + fee-switch admin). `createPair`/`createEmpirePair` are user-callable (permissionless pair listing), but `setFeeTo`/`setFeeToSetter` are gated to a single admin address (`feeToSetter`) that currently governs the protocol fee switch for **every pair this factory has ever created or will create**.

## Included / dropped per chain — this is a "controls", not a "holds", inclusion

This contract's own native/token balance is **$0 on every chain** (see `../_evidence/infra_check.json`). It is included in this inventory not because it custodies funds directly, but because `feeToSetter` unilaterally controls `feeTo` — the address that receives a 1/6-of-sqrt(k)-growth LP-token mint on every `mint()`/`burn()` across every pair it has deployed, on every chain. That is a genuine admin **control** relationship over the pooled value documented below, which is why it is classified and included per this review's "holds or controls" instruction rather than dropped as a $0-balance contract.

Because the *value controlled* is chain-specific (this factory only administers pairs on the chain it's deployed on), each chain instance is evaluated independently against the $10k bar, using each chain's total EmpireDEX pool TVL as computed in `../_evidence/pair_tvl.json`:

| Chain | Total pooled TVL this factory instance administers | Included? |
|---|---:|---|
| BSC | $1,919,435 | **Included** (this write-up) |
| Cronos | $251,215 | **Included** (this write-up) |
| Avalanche | $17,214 | **Included** (this write-up) |
| xDai | $46,234 | **Included** (this write-up) |
| Fantom | $7,756 | Dropped — controls < $10k on this chain |
| Polygon | $4,699 | Dropped — controls < $10k on this chain |
| Kava | $36 | Dropped — controls < $10k on this chain |

All seven are the exact same deployed bytecode and address; the Fantom/Polygon/Kava instances are documented here for completeness but not given separate write-ups.

## feeTo / feeToSetter (live on-chain read, BSC and Ethereum both checked)

- `feeToSetter` = `0x5ABBd94bb0561938130d83FdA22E672110e12528` (this is the same address as `empireTeam` hard-coded into the `Empire`/`FDEX`/`ADEX`/... token contracts, and is also the constructor argument this factory was deployed with — see `compiler_and_deployment.json`)
- `feeTo` = `0x3F9B7da1d832199b2dD23670F2623193636f2e88` (this is the same address as `REWARD_TREASURY` hard-coded into the token contracts)

**The protocol fee switch is ON**, not the Uniswap-V2 default-off state — every `mint`/`burn` across every pair this factory (and the Ethereum factory below, which shares the same `feeToSetter`/`feeTo` pair) governs mints a 1/6-of-growth LP-token skim to `feeTo`. Both `feeToSetter` and `feeTo` are externally-owned accounts (EOAs) per `eth_getCode`, not contracts — they are out of scope for this contract inventory (which covers deployed contracts) but are the two addresses with the greatest practical influence over fee flows and are noted here for completeness.

## Verification status: VERIFIED

Sourcify v2 record (BSC instance, representative — Sourcify does not index Fantom/Polygon/Kava for this address, but see the byte-identical proof below): https://sourcify.dev/server/v2/contract/56/0x06530550A48F990360DFD642d2132354A144F31d — `runtimeMatch: match`, `creationMatch: match`.

- `./source/` — full matched Solidity source (`EmpireFactory.sol` + its dependencies)
- `./abi.json`, `./metadata.json`, `./compiler_and_deployment.json` — compiler `0.6.8+commit.0bbfe453`, constructor argument `_feeToSetter = 0x5ABBd94bb0561938130d83FdA22E672110e12528` (decoded from Sourcify's `creationBytecode.transformationValues.constructorArguments`)

### BYTE-IDENTICAL proof across the other 6 chains

`EmpireFactory` has no `immutable` state (only the constructor argument `feeToSetter`, stored in regular storage, and every deployment used the identical value above), so its **runtime bytecode is byte-for-byte identical on every chain it is deployed to** — there is nothing chain-specific baked into the code. This was confirmed directly, not assumed:

```
sha256(eth_getCode(bsc,     0x0653...)) = 458637f12015a8da8cff750e06852a600b5965d8e94f7d33e132d59c7939662f
sha256(eth_getCode(fantom,  0x0653...)) = 458637f12015a8da8cff750e06852a600b5965d8e94f7d33e132d59c7939662f
sha256(eth_getCode(avax,    0x0653...)) = 458637f12015a8da8cff750e06852a600b5965d8e94f7d33e132d59c7939662f
sha256(eth_getCode(polygon, 0x0653...)) = 458637f12015a8da8cff750e06852a600b5965d8e94f7d33e132d59c7939662f
sha256(eth_getCode(xdai,    0x0653...)) = 458637f12015a8da8cff750e06852a600b5965d8e94f7d33e132d59c7939662f
sha256(eth_getCode(cronos,  0x0653...)) = 458637f12015a8da8cff750e06852a600b5965d8e94f7d33e132d59c7939662f
sha256(eth_getCode(kava,    0x0653...)) = 458637f12015a8da8cff750e06852a600b5965d8e94f7d33e132d59c7939662f
```
(full raw hashes in `../_evidence/bytecode_hashes.json`). All seven hashes are identical to each other, and the BSC deployment is Sourcify-verified as `EmpireFactory` above — so every non-BSC instance is **BYTE-IDENTICAL-TO-bsc:0x06530550A48F990360DFD642d2132354A144F31d**, proven by the sha256 equality shown above, not merely asserted.

## Key functions

Admin (`feeToSetter`-gated):
- `setFeeTo(address)` — redirect the protocol fee skim
- `setFeeToSetter(address)` — transfer admin control (single-step, no timelock, no 2-step handoff)

User-callable (permissionless):
- `createPair(address tokenA, address tokenB)` — standard pair creation
- `createEmpirePair(address tokenA, address tokenB, PairType pairType, uint unlockTime)` — EmpireDEX's extended creation, supporting `LiquidityLocked` / `SweepableToken0` / `SweepableToken1` pair types
- `allPairsLength()` / `allPairs(uint)` / `getPair(address,address)` — public registry reads (used by this review to enumerate all 143 pairs)

## Proxy relationships

None — not upgradeable. EIP-1967 implementation/admin/beacon slots read as zero directly from chain.

## Dependencies / external calls

None outward from the factory itself beyond deploying `EmpirePair` via `CREATE2` and calling `initialize()` on the freshly deployed pair.
