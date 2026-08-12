# EmpireDEX — Security Audit: Unprivileged Value-Extraction Analysis

Scope: on-chain code only, in this contract set. Criterion: can a **low-capital or
unprivileged** attacker extract protocol-scale value or seize control — attacker gain
relative to attacker cost, not protocol loss alone. Admin/owner power, key compromise,
signer leakage, insider, phishing, and off-chain infrastructure are **out of scope**.

Tooling: Foundry 1.5.1 (fork tests against real BSC/Cronos deployments). PoC:
[`EmpireAudit.t.sol`](./EmpireAudit.t.sol); raw run log: [`poc_results.txt`](./poc_results.txt).

---

## Verdict

**Zero qualifying findings on the visible code; protocol-wide verdict INCONCLUSIVE.**

Every value-custody and authority path I could see is sound against an unprivileged
attacker. The AMM core is standard Uniswap-V2 (7/7 fork tests against the real BSC
deployments confirm the invariants hold), and the novel value-moving machinery
(sweep / weaponised-liquidity, permanent LP lock, LGE, `feeToSetter`, `upgradePair`,
`extractFutureRewards`) is uniformly **owner/token-gated** — admin/centralization
power, explicitly out of scope. The one genuine unprivileged code defect (escrow
lock-time griefing) yields the attacker **no gain** and fails the disproportionality gate.

**~97.99% of protocol TVL was enumerated upstream; this verdict covers that visible
remainder.** The gap forces INCONCLUSIVE for the protocol as a whole: the **Empire
native L1 chain (chain ID 3693) is entirely unseen** (RPC + explorer both unreachable
during collection), and it hosts the protocol's own token plus same-address
factory/router/escrow. I proved the deployed Empire-family code **diverges from the
public GitHub source** (the Cronos CRODEX token exposes `upgradePair`, absent from the
repo), so I cannot assume the unseen L1 contracts match anything analyzed. A bug there
is invisible to this pipeline.

Structural observation dominating the risk picture (not an exploit): **the "biggest
funded contracts" are near-empty shells.** On both flagship BSC pairs and the Cronos
WCRO/CRODEX pair, the owner has already swept out ~99.9% of the valuable paired asset
(real WBNB in the $1.02M WBNB/ROOT pair = 0.000000066 WBNB; real WCRO in the $61k pair
= 635 of 661,535 virtual). The reported TVL is *virtual reserve*; the real paired asset
left via the designed admin sweep, and LPs are permanently locked (`burn` reverts).
Centralization / valuation risk — not an unprivileged exploit.

---

## FUNDED + INCONCLUSIVE

No funded (≥$10k) contract came back fully INCONCLUSIVE. Two need explicit caveats:

| Contract | Chain | Value | Status | Note |
|---|---|---|---|---|
| CRODEX token `0xc83859…` | Cronos | ~$61k *controlled* (99% of WCRO/CRODEX LP) | **Analyzed, REDUCED CERTAINTY** | Decompiled-only. Authority gating legible (`upgradePair`/admin = `"Ownable: caller is not the owner"`; `claim` = contribution-gated) → **no unprivileged path** — but exact arithmetic not verifiable from noisy decompilation, and it carries a non-standard `upgradePair` absent from the GitHub reference. Not folded into a clean zero. |
| "WEMPIRE" token + L1 factory/router | **Empire L1 (3693)** | **Unquantified** (DefiLlama $0, deemed unreliable) | **INCONCLUSIVE — unreachable** | Never collected; decompile-by-hand from an L1 archive node and re-run. Not evidenced ≥$10k, so not asserted funded — but not confirmed empty. |

The Cronos/Avax/xDai **pairs** (decompiled) are **not** reduced-certainty for pair *logic*:
they are `type(EmpirePair).creationCode` deployed by the byte-identical, BSC-verified
factory, so their AMM logic is source-equivalent to the verified `EmpirePair` (analyzed
and fork-tested on BSC siblings). Tokens inside them are modeled as adversarial counterparties.

---

## Findings

**None clear the gate (disproportionality × reachability × scope).** Two real issues are
documented but explicitly do **not** qualify:

### N-1 (NOT a finding — griefing, no attacker gain): `EmpireEscrow.lockLiquidity` first-caller fixes the release time
- **Root cause:** `lockLiquidity(token,user,amount,duration)` is permissionless and
  `if (escrow.release == 0) escrow.release = block.timestamp.add(duration);`. The *first*
  caller for a `(token,user)` key sets the unlock time; later locks ignore `duration`.
- **Attack flow:** attacker acquires 1 wei of a pair's LP, front-runs a victim's
  `addLiquidityLocked` with `lockLiquidity(pairLP, victim, 1, largeDuration)`, pinning
  `locks[pairLP][victim].release` far in the future; the victim's later-locked LP inherits it.
- **Why it fails the gate:** `releaseLiquidity` keys off `locks[token][msg.sender]`, so the
  attacker can **never withdraw the victim's LP** — only delay it. Attacker gain = 0 (burns
  1 wei + gas). Fails **Disproportionality**. Requires victim to transact into the feature
  afterward; escrow holds <$10k. → Coverage dismissal; reported as a correctness defect.

### N-2 (NOT a finding — admin power, out of scope): owner can sweep the paired asset and permanently lock LPs
- `sweep`/`unsweep` (`EmpirePair.sweep` → `IEmpireCallee(token).empireSweepCall` → owner)
  lets the **token owner** extract the paired asset down to a floor, while sweepable pairs
  set `liquidityLocked = type(uint256).max` so LP `burn` never succeeds. Observed fully
  exercised on-chain (99.9% swept). Owner-gated (`Empire.sweep` is `onlyOwner`;
  `EmpirePair.sweep` requires `msg.sender == sweeperToken`). **Reachability gate fails**
  for an unprivileged attacker. Severe **centralization / TVL-overstatement** risk for LPs,
  flagged for the team, but out of scope for the unprivileged-attacker criterion.

---

## Proof (executed — falsification of every unprivileged candidate)

Forked BSC mainnet (~block 115.59M) against the real flagship pair `0x3Af4Cf79…`
(WBNB/ROOT) in its live near-max-swept state. All 7 tests **PASS**:

| Candidate attacked | Test | Result |
|---|---|---|
| Unprivileged `sweep()` | `test_UnprivilegedSweepReverts` | reverts `Empire: INCORRECT_CALLER` |
| Unprivileged `unsweep()` | `test_UnprivilegedUnsweepReverts` | reverts `Empire: INCORRECT_CALLER` |
| Free token-out swap | `test_FreeSwapOutReverts` | reverts (K/input) |
| Drain the 834 *virtual* WBNB | `test_CannotDrainVirtualWBNB` | reverts; real WBNB = 66,319,811,044 wei |
| Burn locked (sweepable) LP | `test_BurnLockedPairReverts` | reverts `Empire: LIQUIDITY_LOCKED` (lock = max-uint) |
| `skim` the swept/virtual balance | `test_SkimYieldsOnlyDust` | 0 WBNB / 0 ROOT leaked |
| Capitalized WBNB→ROOT→WBNB round-trip | `test_RoundTripNoFreeValue` | pool reverts rather than release virtual WBNB → attacker never ahead |

---

## Coverage

**Tiers**
- **DEEP** — `EmpirePair` (verified; governs all 10 pairs incl. source-equivalent
  Cronos/Avax/xDai deploys; fork-tested). `EmpireFactory` (verified; authority =
  `feeToSetter`). `EmpireRouter` (verified BSC/ETH; Cronos/Avax/xDai decompiled, same
  selector surface + `escrow`/`factory`/`WETH` immutables, no extra privileged fn).
  `EmpireEscrow` (Sourcify-verified). `Empire`/CRODEX LGE token (decompiled + GitHub
  reference; authority model confirmed gated).
- **SURVEY** — `Unileech` (GitHub source; permissionless burn-and-re-add helper, holds no
  funds, address undeployed/unknown; griefs only pending in-pair LP, victim-error-dependent,
  out of scope). Bridged/third-party tokens ROOT/FF/upCRO/CRODEX-as-counterparty (not
  protocol code; modeled adversarial).

**Dismissals**
- Reentrancy via `empireCall`/`empireSweepCall` — mitigated: all mutating pair fns carry
  `lock`; callbacks are the attacker's own token in the attacker's own pair.
- Fee-on-transfer / balance-vs-reserve desync — mitigated: `EmpirePair` reconciles via
  `_balanceOfSelf`/`_update`; the `Empire` token's 0.1% burn **exempts** all pair-side
  transfers (`to==pair || from==pair`), so no reserve desync.
- First-depositor / MINIMUM_LIQUIDITY inflation — unreachable on existing seeded pairs
  (historical); a fresh attacker-created pair risks only the attacker's own capital.
- Sweep-accounting arbitrage — root cause is the admin sweep + requires an external venue
  at a different price; real paired asset ≈ 0 anyway. Out of scope (admin + MEV/market-state).
- `mint`/`burn` rounding — dust, favors pool; not protocol-scale.
- Escrow lock-time griefing (N-1) — real defect, **no attacker gain**; dismissed on disproportionality.
- `feeToSetter`/`setFeeTo`, owner `sweep`/`extractFutureRewards`/`upgradePair`/`beginLGE`/
  `complete` — admin-gated (require-checks verified/decompiled). Out of scope.
- CRODEX `claim()` theft — mitigated: contribution-gated to `msg.sender`; zero-contribution
  attacker reverts (decompiled-confirmed).

**DEGRADED (mandatory disclosure):** the **Empire L1 chain (3693)** contracts were never
collected and could not be analyzed at all — below SURVEY. Exact arithmetic of the
**CRODEX token** (`extractFutureRewards`/`complete` share math) is not fully recoverable
from decompilation — gating confirmed, precise math not.

---

## Assumptions & limitations

- **Contingent on the unseen L1 chain:** conclusions apply only to the 8 EVM chains
  collected. L1 token/factory/router are assumed neither honest nor identical to siblings —
  proven divergence exists (`upgradePair`). Primary reason for protocol-wide INCONCLUSIVE.
- **Contingent on decompilation fidelity (Cronos):** the CRODEX "no unprivileged path"
  verdict rests on legible access-control strings in noisy heimdall output; a hidden ungated
  state-write would flip it. A verified-source lookup (Etherscan-V2 key, absent this session)
  would close it.
- **External counterparties treated adversarial:** ROOT/FF/upCRO are non-protocol tokens; a
  rug counterparty harms only its own isolated pair, not protocol-wide solvency.
- **Source-level soundness ≠ protocol safety.** The dominant real risk is not a code bug —
  it is the **owner keys** that already swept ~$2M-equivalent of paired assets out of the
  pools by design. Key/authority centralization is outside source analysis and not covered
  by this clean-on-code verdict.

---

## Calibration

No finding reaches the disproportionality bar (unprivileged gain ≈ 0 across all survivors)
→ no ranked findings. Confidence in *visible*-code soundness is **high**, backed by
execution (7/7 passing fork tests against live contracts). Confidence in *protocol-wide*
soundness is **low by construction** — capped by the ~2% enumeration gap and the entirely
unseen L1 chain. A well-defended zero on the visible surface, not inflated to a
protocol-wide clean bill.
