# Study Guide & Reflective Outline — Vehicle-Emission-Certification

> The reflective framework from **Ethereum-Token-v2026.pdf**, folded into this prototype. Use it to
> connect what you build (each slice) to the course concepts and the authoritative references.

## Concepts demonstrated → lesson mapping
| This prototype | Concept (course) | Source PDF |
|----------------|------------------|-----------|
| `IssuerRegistry` = OZ `Ownable` + role | Access-control design (Ownable/AccessControl, role separation) | Ethereum-Token §Access-Control; smartContractDev |
| `ReentrancyGuard` + CEI on mutations | Reentrancy & external-call safety (The DAO) | SmartContractSecurity; Solidity Security Considerations |
| `Pausable` issuance | Emergency stop / operational safety | Ethereum-Token §Secure Token Engineering |
| hash + IPFS CID on-chain | Data representation, integrity, privacy (no PII on-chain) | SemesterProject-v3; Ethereum-Token |
| events on every state change | Events & transaction logs, app integration | Ethereum-Token §Events |
| fuzz + invariant tests | Testing token/contract properties | Ethereum-Token §Testing; Foundry docs |
| Sepolia deploy + Etherscan verify | Deployment & verification | Foundations; Foundry docs |

## Approach (stage your work)
1. **Design & implement** — pick the model, build from reviewed OZ components, define roles/state/rules.
2. **Harden & verify** — enforce access control, preserve invariants, protect external calls, test edges + fuzz + invariants.
3. **Assess & report** — apply EthTrust [S]/[M]/[Q] (`SECURITY_ASSURANCE.md`), run Slither + human review, write the report.

## Further study (build a minimal example + tests for each)
ERC-20 storage anatomy · ERC-20 with OpenZeppelin · allowance security (permit/ERC-2612) · events & logs ·
ERC-721 ownership & metadata (IPFS) · ERC-1155 multi-token · access-control design · testing token contracts ·
token security properties · ABI & app integration · web3 clients (ethers.js) · deployment & verification.

## Further reading (consult current official docs; record versions)
- **Standards:** Ethereum.org token standards · EIPs (ERC-20/721/1155) · Solidity docs · OpenZeppelin Contracts + Access Control.
- **Security:** EEA EthTrust v3 + Checklist · OWASP SCSVS / SCSTG / SCWE · Solidity Security Considerations · Slither · Foundry fuzz/invariant.
- **Course PDFs (in `resources/applied-blockchain-technology/lab2/`):** Ethereum-Token-v2026 · SmartContractSecurity-Faculty · smartContractDev-Faculty-new · Foundations-v2026 · Consensus-v2026 · ref-bitcoin-SatoshiNakamoto.

> **AI-assist caveat (from the lesson):** generated code must be checked against the relevant ERC/EIP, the current Solidity docs, the installed OpenZeppelin version, compiler warnings/known bugs, unit+fuzz+invariant tests, and an independent security review.
