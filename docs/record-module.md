# Slice 2 — Record Creation (`RecordRegistry.sol`)

> Owner: member2 · Branch: `feature/record-module` · Scenario: Emission certification and audit: accredited test centers issue tamper-evident emission certificates a regulator can trust without re-contacting the test center.

## What it does
Issues a EmissionCert and stores the on-chain proof (hash + CID + owner + status). The only
contract that mutates state; mutations after creation go through the controller (Slice 4).

## Functions
- `issueCertificate(id, dataHash, cid, owner, metadataURI)` — `onlyTestCenter`, `nonReentrant`.
- `getRecord(id)` / `exists(id)` — views from `IAttestationRegistry`.
- `setController(address)` — regulator links the AuditTrail once.

## Data representation
See `schemas/record.schema.json` (off-chain) and `schemas/attestation-onchain.schema.json` (on-chain).

## Tests (`test/RecordRegistry.t.sol`)
- issuer can create · non-issuer reverts · duplicate reverts.

## TODO checklist
- [ ] `TODO(slice-2)` event-emission test
- [ ] frontend: validate record.json against the schema before issuing
