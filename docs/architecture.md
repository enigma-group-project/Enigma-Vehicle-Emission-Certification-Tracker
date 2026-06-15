# Architecture — Enigma-Vehicle-Emission-Certification-Tracker

> Scenario: Emission certification and audit: accredited test centers issue tamper-evident emission certificates a regulator can trust without re-contacting the test center.

## Roles
- **Issuer** — Accredited Test Center (holds the issuer role; creates/updates/revokes EmissionCert records)
- **Owner** — Vehicle/Facility Owner (controls transfer of their own record)
- **Verifier** — Regulator/Auditor (read-only authenticity check)
- **Admin** — deploys, manages issuer roles, links the controller

## System diagram
```
            ┌──────────────────┐
regulator ─────▶│  IssuerRegistry  │◀──── isTestCenter()/regulator() reads
            └──────────────────┘
                     ▲ role check
  issuer ──create──▶ │
            ┌──────────────────┐  controller-only   ┌──────────────┐
            │  RecordRegistry  │◀──────────────────│  AuditTrail  │◀── owner/issuer
            └──────────────────┘  transfer/revoke   └──────────────┘
                     ▲ view
            ┌──────────────────┐
verifier ─▶│   Verification   │
            └──────────────────┘
```

## Workflow (per action)
1. **Register issuer** — regulator → `IssuerRegistry.registerTestCenter(Accredited Test Center)`
2. **Create EmissionCert** — issuer → `RecordRegistry.issueCertificate(id, hash, cid, owner, metaURI)` → emits `CertificateIssued`
3. **Verify** — verifier → `Verification.verifyCertificate(id, candidateHash)` → `(valid, status, owner, issuer)`
4. **Transfer** — owner → `AuditTrail.transferVehicle(id, newOwner)` → emits `VehicleTransferred`
5. **Revoke / update** — issuer/regulator → `AuditTrail.revoke|renewCertificate(...)`

## On-chain vs off-chain
| On-chain (lean, permanent) | Off-chain (large, private) |
|----------------------------|----------------------------|
| `keccak256(artifact)` hash | the EmissionCert file itself (IPFS) |
| IPFS CID + metadataURI     | the human-readable record.json |
| issuer/owner addresses     | any PII (never on-chain) |
| `issuedAt`, `status`, events | |

## Why blockchain here (and where a DB is fine)
- **Blockchain wins:** tamper-evidence, no single trusted server, public verifiability, issuer can revoke.
- **DB still better for:** search/discovery by name, private lookups, high-frequency mutable data.
> Fill this in with your scenario's concrete argument — it's worth 10 pts (Problem definition).
