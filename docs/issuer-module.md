# Slice 1 — Issuer Registration (`IssuerRegistry.sol`)

> Owner: member1 · Branch: `feature/issuer-module` · Scenario: Emission certification and audit: accredited test centers issue tamper-evident emission certificates a regulator can trust without re-contacting the test center.

## What it does
The single source of truth for **who may issue a EmissionCert** and who the regulator is.

## Functions
- `registerTestCenter(address)` — regulator grants the issuer role to a Accredited Test Center.
- `deregisterTestCenter(address)` — regulator revokes it.
- `transferRegulator(address)` — hand the regulator key to a multisig.
- `isTestCenter(address)` / `regulator()` — reads used by the other three slices.

## Tests (`test/IssuerRegistry.t.sol`)
- regulator is the deployer · register+revoke · non-regulator reverts · zero-address reverts.

## TODO checklist
- [ ] `TODO(slice-1)` two-step regulator handover
- [ ] event-driven issuer list in the frontend
- [ ] Extension: swap to OpenZeppelin `AccessControl`, note gas delta

## Demo evidence
Screenshot: registering a Accredited Test Center and the `TestCenterRegistered` event in the trace.
