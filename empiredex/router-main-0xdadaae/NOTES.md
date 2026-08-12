# Router contract — "main" deployment (BSC / Fantom / Avalanche / xDai / Cronos / Kava)

- **Address:** `0xdADaae6cDFE4FA3c35d54811087b3bC3Cd60F348` (identical address on all 6 chains listed above, via CREATE2 vanity deployment)
- **Contract type:** `EmpireRouter` (Uniswap-V2-style periphery swap/liquidity router)
- **Discovered via:** `empire-dex.readthedocs.io/en/latest/multichain.html` (published router address per chain), cross-checked by decoding the constructor arguments of the verified BSC deployment (see below), which confirms this router's immutable `factory` pointer equals the exact factory address (`0x0653...`) already discovered from the DefiLlama adapter.

## Role / callable-surface classification

**user-callable** — the primary sanctioned entry point for swaps and liquidity add/remove across essentially all EmpireDEX trading volume on the chains it serves. It is *not* privileged over the pairs it calls (any contract could call `IEmpirePair.swap/mint/burn` directly), but it is the de-facto custody-transit point for nearly every user interaction: it receives `transferFrom`'d tokens, wraps/unwraps the native coin via `WETH.deposit/withdraw`, and — importantly, see below — **automatically forwards newly-minted LP into the Escrow contract** for the "locked liquidity" feature.

## Included / dropped per chain

Router itself never holds a persistent balance (native/token balance is $0 on every chain checked, `../_evidence/infra_check.json`) — it is included on a "controls" basis: it is the routing/custody-transit layer for the aggregate pooled TVL on each chain.

| Chain | Aggregate EmpireDEX pool TVL this router serves | Included? |
|---|---:|---|
| BSC | $1,919,435 | **Included** (this write-up) |
| Cronos | $251,215 | **Included** (this write-up) |
| Avalanche | $17,214 | **Included** (this write-up) |
| xDai | $46,234 | **Included** (this write-up) |
| Fantom | $7,756 | Dropped — controls < $10k on this chain |
| Kava | $36 | Dropped — controls < $10k on this chain |

Polygon uses a **different** router contract (`0xB2855A6dAeeBDB72B0176A479A983066ae9775A6`) — see "Dropped contracts" in the main README (Polygon's total pooled TVL is $4,859, below the $10k bar, so that router is dropped entirely, not just deprioritized).

## Verification status by chain — IMPORTANT: bytecode is NOT identical across chains

Unlike the factory, `EmpireRouter` bakes two `immutable` addresses into its runtime bytecode at construction time: `factory` (the same `0x0653...` value on every one of these 6 chains) **and `WETH`** (the chain's own wrapped-native-coin address, which necessarily differs — WBNB ≠ WFTM ≠ WAVAX ≠ WXDAI ≠ WCRO ≠ WKAVA). A third immutable, `escrow` (see below), is also chain-specific. This was confirmed directly: `sha256(eth_getCode(...))` for this address differs on every single chain (full hashes in `../_evidence/bytecode_hashes.json`) — so **no** byte-identical-sibling shortcut is available here; each chain's copy needed its own verification lookup.

| Chain | Status | Evidence |
|---|---|---|
| BSC | **VERIFIED** | Sourcify v2: https://sourcify.dev/server/v2/contract/56/0xdADaae6cDFE4FA3c35d54811087b3bC3Cd60F348 (`runtimeMatch: match`). Source in `./source/`. |
| Avalanche | **DECOMPILED-heimdall** | Not verified on Routescan (the only free Avalanche explorer API reachable: `api.routescan.io` returned "Contract source code not verified"). Decompiled with heimdall v0.9.2 → `./decompiled-avax/decompiled.sol` + `abi.json`. |
| xDai | **DECOMPILED-heimdall** | `gnosis.blockscout.com` reachable but `is_verified: null`. Decompiled with heimdall v0.9.2 → `./decompiled-xdai/decompiled.sol` + `abi.json`. |
| Cronos | **DECOMPILED-heimdall** | No free/keyless Cronos explorer API was reachable from this environment (Cronoscan requires an API key we do not have; the Cronos Blockscout front end at explorer.cronos.com serves only its SPA shell on API paths from this network). Decompiled with heimdall v0.9.2 → `./decompiled-cronos/decompiled.sol` + `abi.json`. |

The BSC-verified source (compiler `0.6.8+commit.0bbfe453`) confirms the deployed router takes **three** constructor arguments — `(address _factory, address _WETH, address _escrow)` — not the two-argument version found in the `Prism-Network-io/empiredex` public GitHub repo. Decoded constructor args for the BSC instance (`compiler_and_deployment.json`): `factory=0x06530550A48F990360DFD642d2132354A144F31d`, `WETH=0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c` (WBNB), `escrow=0x38F73653fA46943de76c228a47b7d9B81F28FFff`.

## The Escrow integration (why this matters for fund custody)

The verified source (`./source/contracts/periphery/EmpireRouter.sol`) shows `addLiquidityLocked`/`addLiquidityETHLocked` mint LP to the router itself, `approve` it to `escrow`, then call `IEmpireEscrow(escrow).lockLiquidity(pair, to, liquidity, lockDuration)` — this is the on-chain implementation of the "Time-Locked Initial Liquidity" feature described in EmpireDEX's docs. The Escrow contract (`0x38F73653fA46943de76c228a47b7d9B81F28FFff` on this router's chains) was investigated separately and **dropped** from this inventory for holding < $10k on every chain — see the main README's "Dropped contracts" section for the full sweep.

## Key functions

All user-callable, no admin gate on the router itself:
- `addLiquidity` / `addLiquidityETH` / `addLiquidityLocked` / `addLiquidityETHLocked` (the last two route through Escrow, see above)
- `removeLiquidity` / `removeLiquidityETH` (+ `WithPermit` / `SupportingFeeOnTransferTokens` variants)
- `swapExactTokensForTokens` / `swapTokensForExactTokens` / `swapExactETHForTokens` / `swapTokensForExactETH` / `swapExactTokensForETH` / `swapETHForExactTokens` (+ `SupportingFeeOnTransferTokens` variants)
- View helpers: `quote`, `getAmountOut`, `getAmountIn`, `getAmountsOut`, `getAmountsIn`

## Proxy relationships

None — not upgradeable. EIP-1967 slots empty (checked on the BSC instance).

## Dependencies / external calls

- `factory` (immutable) — `IEmpireFactory.getPair/createPair/createEmpirePair`
- `WETH` (immutable) — wrap/unwrap native coin
- `escrow` (immutable) — `IEmpireEscrow.lockLiquidity` for the locked-liquidity flow
- Every `IEmpirePair` it routes through — `mint`/`burn`/`swap`, trusting the factory-created pair's accounting
