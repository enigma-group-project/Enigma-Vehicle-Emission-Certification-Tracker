# Security Assurance — Enigma-Vehicle-Emission-Certification-Tracker

> Aligned to **Ethereum-Token-v2026.pdf** (EthTrust levels, vulnerability matrix, OWASP) and
> `SmartContractSecurity-Faculty.pdf`. Mapped to *this* contract's actual functions.

## 1. EthTrust Security Assurance Levels (EEA, v3)
Cumulative levels — each builds on the prior.

| Level | What it requires | Status here |
|-------|------------------|-------------|
| **[S] Static** | No known-vulnerable patterns; compiler clean; pinned `solc 0.8.20`; no `selfdestruct`/`delegatecall` to untrusted code; explicit visibility; checked arithmetic (0.8 default). | ✅ `forge build` clean; Slither job in CI (`slither.config.json`). |
| **[M] Mechanical** | Reentrancy protection on state-changers; access control enforced; CEI ordering; no unchecked external-call return; events on state change. | ✅ OZ `ReentrancyGuard` on `issueCertificate` + AuditTrail mutators; OZ `Ownable` (Regulator) + Test-Center role; CEI; events on every mutation. |
| **[Q] Qualitative** | Documented threat model; property/invariant + fuzz tests; independent review; upgrade/pause policy reasoned. | �ñ `test/Invariant.t.sol` (fuzz + invariant); `Pausable` documented below; threat model §3; independent review = course grading. |

## 2. Approach (Design → Harden → Assess) — from the lesson
- **Design & implement:** chose a registry/attestation model (not a token); built from reviewed OZ components (`Ownable`, `ReentrancyGuard`, `Pausable`); defined roles (Regulator, Test-Center, Owner), state (`Status`), and transfer/revoke/renew rules.
- **Harden & verify:** enforce access control (themed `onlyRegulator`/`onlyTestCenter`/`onlyController`); preserve state invariants; protect external interactions (CEI + guard); test edge cases + fuzz + invariants.
- **Assess & report:** apply EthTrust [S]/[M]/[Q]; run automated (Slither) + human review; produce this report + the evaluation table in `README.md`.

## 3. Vulnerability Diagnostic & Mitigation Matrix
| Threat (OWASP SCWE / Solidity) | Where it could appear | Mitigation in this contract |
|---|---|---|
| Reentrancy (SC05) | `issueCertificate`, AuditTrail mutators | OZ `ReentrancyGuard` + CEI (effects before any external call) |
| Broken access control (SC01) | issue / setController / revoke / pause | `onlyTestCenter` / `onlyRegulator` / `onlyController`; OZ `Ownable` for Regulator |
| Unauthorized state change | `controller*` mutators | `onlyController`; controller is set once (`ControllerSet`) by the Regulator |
| Fake issuer | `issueCertificate` | gated by `IssuerRegistry.isTestCenter` (Regulator-granted) |
| Replay / duplicate record | `issueCertificate` | `AlreadyExists` check on the record id |
| Denial via stuck state | issuance | `Pausable` lets the Regulator halt issuance during an incident, then `unpause` |
| Front-running | `revokeCertificate` | issuer/Regulator-only; gas price does not change correctness |
| Integer overflow (SC?) | timestamps/counters | Solidity 0.8 checked arithmetic |
| PII on-chain | record data | only `keccak256(file)` + IPFS CID stored; never raw PII |

## 4. Minting & Burning (token prototypes)
N/A for this registry (no token supply). For the **token-based** prototype
(`Enigma-Decentralized-Student-Marketplace`), supply control = OZ ERC-20 + owner-gated `mint`;
no burn. See its `SECURITY_ASSURANCE.md`.

## 5. Tooling
- **Static:** Slither (`slither.config.json`, CI job — advisory).
- **Dynamic:** Foundry fuzz + invariant (`test/Invariant.t.sol`); `forge test --gas-report`.
- **References:** EEA EthTrust v3 + Checklist; OWASP SCSVS / SCSTG / SCWE; Solidity Security Considerations; OpenZeppelin docs. (Full list in `docs/study-guide.md`.)
