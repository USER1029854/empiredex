# Router contract — Ethereum-mainnet deployment

- **Address:** `0xe7A504316BebbE540496E29798187c9ECAD6ef4F`
- **Chain:** Ethereum mainnet
- **Explorer:** https://etherscan.io/address/0xe7A504316BebbE540496E29798187c9ECAD6ef4F
- **Contract type:** `EmpireRouter` — same source as the "main" router, deployed as its own instance on Ethereum.
- **Discovered via:** `empire-dex.readthedocs.io/en/latest/multichain.html` ("Ethereum: Router `0xe7A504316BebbE540496E29798187c9ECAD6ef4F`").

## Role / callable-surface classification

**user-callable** — identical role to the "main" router (see `../router-main-0xdadaae/NOTES.md`).

## Balance / controlled TVL

Own balance: $0 (checked). Included on the same "controls" rationale, serving Ethereum's $62,208 aggregate EmpireDEX pool TVL (dominated by `ROOTDEX/WETH`, $54,859 — see `../pair-ethereum-rootdex-weth-0x163b890f/`).

## Verification status: VERIFIED

Sourcify v2 record: https://sourcify.dev/server/v2/contract/1/0xe7A504316BebbE540496E29798187c9ECAD6ef4F — `runtimeMatch: match`, `creationMatch: match`.

- `./source/`, `./abi.json`, `./metadata.json`, `./compiler_and_deployment.json`
- Decoded constructor args: `factory=0xd674b01E778CF43D3E6544985F893355F46A74A5`, `WETH=0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2` (canonical WETH9), `escrow=0x9fF555DDEbD500C0F1fa7C898dCbdb7CCa6809FC`

This confirms Ethereum uses the **second** Escrow contract variant (`0x9fF555DD...`, shared with Cronos per the docs) rather than the `0x38F736...` instance used by BSC/Fantom/Avalanche/Polygon/xDai.

## Key functions / proxy relationships / dependencies

Identical to `../router-main-0xdadaae/NOTES.md` — see that file, including the Escrow-integrated `addLiquidityLocked`/`addLiquidityETHLocked` functions. No proxy (EIP-1967 slots empty).
