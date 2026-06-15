# Slice 4 — Transfer / Revocation / Audit (`AuditTrail.sol`)

> Owner: member4 · Branch: `feature/audit-module` · Scenario: Emission certification and audit: accredited test centers issue tamper-evident emission certificates a regulator can trust without re-contacting the test center.

## What it does
The RecordRegistry **controller**: enforces who may transfer/revoke/update, then emits the
audit events that power the history page.

## Functions
- `transferVehicle(id, newOwner)` — current Vehicle/Facility Owner only.
- `revokeCertificate(id, reason)` / `renewCertificate(id, hash, cid)` — issuer/regulator only.
- `logInspection(id, note)` — anyone (demo history).

## Threat model (Security track — 5 pts)
| Threat | Mitigation in this design |
|--------|---------------------------|
| Fake issuer | role gated by `IssuerRegistry` |
| Unauthorized transfer | `msg.sender == owner` check |
| Reentrancy on state change | `nonReentrant` in RecordRegistry |
| Replay (duplicate id) | `AlreadyExists` check |
| Front-running revoke | _TODO(slice-4): analyze — issuer-only, gas price doesn't change correctness_ |

## Tests (`test/AuditTrail.t.sol`)
- owner transfers · non-owner reverts · issuer revokes · regulator revokes.

## TODO checklist
- [ ] `TODO(slice-4)` event-driven history in the frontend
- [ ] finish the front-running / replay write-up
