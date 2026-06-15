# Slice 3 — Verification (`Verification.sol`)

> Owner: member3 · Branch: `feature/verification-module` · Scenario: Emission certification and audit: accredited test centers issue tamper-evident emission certificates a regulator can trust without re-contacting the test center.

## What it does
The zero-gas read path a Regulator/Auditor uses to confirm a EmissionCert is authentic, active, and who owns it.

## Functions
- `verifyCertificate(id, candidateHash)` → `(valid, status, owner, issuer)`
- `verifyCertificateHash` · `statusOf` · `ownerOf`

## Demo script
1. Issue a EmissionCert (Slice 2).
2. Re-hash the same artifact in the Verification page → ✅ VALID.
3. Revoke it (Slice 4) → re-verify → status `Revoked`, valid=false.

## Tests (`test/Verification.t.sol`)
- hash match · wrong hash fails · verifyCertificate active.

## TODO checklist
- [ ] `TODO(slice-3)` assert valid=false after revoke
- [ ] in-browser IPFS fetch + re-hash
