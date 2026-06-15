# Enigma-Vehicle-Emission-Certification-Tracker

> 🧩 **STUDENT TEMPLATE.** Every `TODO(memberN)` in `contracts/` and `frontend/src/modules/` is yours to implement. The tests in `test/` are the spec — run `forge test` until green. The Auto-Grade Action scores each push. See [STUDENT_GUIDE](../../STUDENT_GUIDE.md).

> Team Enigma (Group E) · CS-GY 9215 Applied Blockchain · **Scenario:** Emission certification and audit: accredited test centers issue tamper-evident emission certificates a regulator can trust without re-contacting the test center.
> One of six fully-functional reference solutions sharing the four-slice attestation architecture (domain-specific functions per scenario) — see [`../../PROJECT_BRIEF.md`](../../PROJECT_BRIEF.md).
> **Status:** All four slices built to the gold dual-network standard (Anvil + Sepolia). This is the reference prototype to clone for the other five.

## Roles
| Role | Who | Permissions |
|------|-----|-------------|
| Issuer | Accredited Test Center | create / update / revoke EmissionCert |
| Owner | Vehicle/Facility Owner | transfer their own EmissionCert |
| Verifier | Regulator/Auditor | read-only verification |
| Admin | deployer | manage issuer roles, link controller |

## Quickstart
```bash
forge build                                       # green on a fresh clone (no deps needed)
forge install foundry-rs/forge-std    # needed only for the tests
forge test -vvvv                                  # run all four slice test suites
forge test --gas-report                           # numbers for your evaluation table

anvil &                                            # local chain
forge script script/Deploy.s.sol --rpc-url http://127.0.0.1:8545 --broadcast
# paste printed addresses into frontend/src/shared/config.js (anvil block)
# paste ABIs (out/*.sol/*.json -> "abi") into frontend/src/shared/abi.js
# then open frontend/src/index.html and pick "Local Anvil"
```

## Hosted demo on GitHub Pages (Sepolia)
```bash
# one-time: deploy to Sepolia, then bake addresses into config.js (sepolia block)
forge script script/Deploy.s.sol --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
```
1. Paste the Sepolia addresses into `frontend/src/shared/config.js` and set `DEFAULT_NETWORK = "sepolia"`.
2. Repo **Settings → Pages → Deploy from branch → `main` / `frontend/src`** (or push `frontend/src` to a `gh-pages` branch).
3. The published page reads contract state over a public Sepolia RPC (no wallet needed) and uses the visitor's MetaMask for write actions. Reads are free; writes need Sepolia test ETH from a faucet.

## Vertical slices (one member each)
1. **Issuer Registration** — `contracts/IssuerRegistry.sol` · `docs/issuer-module.md`
2. **Record Creation** — `contracts/RecordRegistry.sol` · `docs/record-module.md`
3. **Verification** — `contracts/Verification.sol` · `docs/verification-module.md`
4. **Transfer/Revoke/Audit** — `contracts/AuditTrail.sol` · `docs/audit-module.md`

## Evaluation table (fill with real numbers)
| Operation | Gas | Latency | Privacy | Trust assumption |
|-----------|----:|--------:|---------|------------------|
| createRecord | ~_____ | ~__s | hash only on-chain | issuer key compromise |
| transferOwner | ~_____ | ~__s | owner address visible | owner key |
| revoke | ~_____ | ~__s | reason string on-chain | issuer/admin |
| fullVerify | 0 (view) | <1s | CID + hash visible | IPFS pinning |

## Contribution statement
| Member | Slice owned | Branch | Evidence |
|--------|-------------|--------|----------|
| member1 | Test-Center Registration (`IssuerRegistry`) | `feature/member1-issuer-registration` | _screenshot / test output_ |
| member2 | Certificate Creation (`RecordRegistry`) | `feature/member2-record-creation` | _…_ |
| member3 | Verification (`Verification`) | `feature/member3-verification` | _…_ |
| member4 | Transfer/Revoke/Audit (`AuditTrail`) | `feature/member4-transfer-audit` | _…_ |

> Member labels are generic on purpose — map them to real students (and GitHub handles in `.github/CODEOWNERS`) when you assign the slices.

## Branching
Branch off `develop`; PR into `develop` (never `main`). Each PR = 1 contract + 1 frontend + 1 test + 1 doc change. See PROJECT_BRIEF §8.
