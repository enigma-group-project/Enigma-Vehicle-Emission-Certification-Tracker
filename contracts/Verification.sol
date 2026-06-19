// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import {IAttestationRegistry} from "./interfaces/IAttestationRegistry.sol";
/// @title Verification — Slice 3 (view-only)  [STUDENT TEMPLATE]
contract Verification {
    IAttestationRegistry public immutable registry;
    constructor(address recordRegistry) { registry = IAttestationRegistry(recordRegistry); }
    function statusOf(bytes32 id) external view returns (IAttestationRegistry.Status) { return IAttestationRegistry.Status.None; /* TODO(member3) */ }
    function ownerOf(bytes32 id) external view returns (address) { return address(0); /* TODO(member3) */ }
    function verifyCertificateHash(bytes32 id, bytes32 candidateHash) public view returns (bool) { return false; /* TODO(member3) */ }
    function verifyCertificate(bytes32 id, bytes32 candidateHash) external view returns (bool valid, IAttestationRegistry.Status status, address owner, address issuer) {
        return (false, IAttestationRegistry.Status.None, address(0), address(0)); /* TODO(member3) */
    }
}
