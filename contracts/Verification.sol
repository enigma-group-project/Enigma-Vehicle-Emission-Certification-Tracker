// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IAttestationRegistry} from "./interfaces/IAttestationRegistry.sol";

/// @title Verification — Slice 3 (view-only)  [STUDENT TEMPLATE]
/// @notice Implement every TODO(member3). Spec: docs/verification-module.md + test/Verification.t.sol.
contract Verification {
    IAttestationRegistry public immutable registry;
    constructor(address recordRegistry) { registry = IAttestationRegistry(recordRegistry); }

    function statusOf(bytes32 id) external view returns (IAttestationRegistry.Status) {
        // TODO(member3): return registry.getRecord(id).status;
        return IAttestationRegistry.Status.None;
    }
    function ownerOf(bytes32 id) external view returns (address) {
        // TODO(member3): return registry.getRecord(id).owner;
        return address(0);
    }
    function verifyCertificateHash(bytes32 id, bytes32 candidateHash) public view returns (bool) {
        // TODO(member3): return registry.getRecord(id).dataHash == candidateHash;
        return false;
    }
    /// @notice One-call verification for the frontend.
    function verifyCertificate(bytes32 id, bytes32 candidateHash)
        external view returns (bool valid, IAttestationRegistry.Status status, address owner, address issuer)
    {
        // TODO(member3): read the Attestation; valid = hash matches AND status == Active; return the tuple.
        return (false, IAttestationRegistry.Status.None, address(0), address(0));
    }
}
