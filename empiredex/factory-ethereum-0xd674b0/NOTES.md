# Factory contract — Ethereum-mainnet deployment

- **Address:** `0xd674b01E778CF43D3E6544985F893355F46A74A5`
- **Chain:** Ethereum mainnet
- **Explorer:** https://etherscan.io/address/0xd674b01E778CF43D3E6544985F893355F46A74A5
- **Contract type:** `EmpireFactory` — same source as the "main" factory, but deployed as a separate instance/address on Ethereum specifically (Ethereum was not included in the CREATE2 vanity-address batch used for the other 7 chains).
- **Discovered via:** DefiLlama `DefiLlama-Adapters` repo, `registries/uniswapV2.js`, `empiredex.ethereum` entry. Cross-checked against `empire-dex.readthedocs.io/en/latest/multichain.html` ("Ethereum: Factory `0xd674b01E778CF43D3E6544985F893355F46A74A5`").

## Role / callable-surface classification

**admin/governance** — identical role to the "main" factory (see `../factory-main-0x065305/NOTES.md`): `createPair`/`createEmpirePair` are permissionless; `setFeeTo`/`setFeeToSetter` are gated to `feeToSetter`.

## Balance / controlled TVL

Own balance: **$0** (checked, see `../_evidence/infra_check.json`). Included on the same "controls" rationale as the main factory: it governs the fee switch for every Ethereum EmpireDEX pair, which collectively hold **$62,208** (below the $10k bar on their own for most individual pairs except `ROOTDEX/WETH`, $54,859 — see `../pair-ethereum-rootdex-weth-0x163b890f/`), i.e. the aggregate pooled value this contract administers exceeds $10k.

`feeToSetter` = `0x5ABBd94bb0561938130d83FdA22E672110e12528`, `feeTo` = `0x3F9B7da1d832199b2dD23670F2623193636f2e88` — **identical addresses to the main factory** (confirmed by direct `eth_call`), meaning the same admin key controls the fee switch on Ethereum and on the other 7 chains.

## Verification status: VERIFIED

Sourcify v2 record: https://sourcify.dev/server/v2/contract/1/0xd674b01E778CF43D3E6544985F893355F46A74A5 — `runtimeMatch: match`, `creationMatch: match`.

- `./source/` — matched Solidity source
- `./abi.json`, `./metadata.json`, `./compiler_and_deployment.json` — compiler `0.6.8+commit.0bbfe453`, constructor argument `_feeToSetter = 0x5ABBd94bb0561938130d83FdA22E672110e12528`

Note: this contract's bytecode is **not** byte-identical to the "main" factory (different `feeToSetter` at deploy time would matter if it were an immutable, but it isn't here — the two factories are in fact functionally identical modulo the CBOR metadata hash; both were verified independently rather than relying on a cross-chain match, since Ethereum access was directly available).

## Key functions / proxy relationships / dependencies

Identical to `../factory-main-0x065305/NOTES.md` — see that file. No proxy (EIP-1967 slots empty, confirmed via `eth_getStorageAt`).
