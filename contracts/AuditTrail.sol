// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IAttestationRegistry} from "./interfaces/IAttestationRegistry.sol";
import {RecordRegistry} from "./RecordRegistry.sol";

/// @title AuditTrail — Slice 4 (Transfer / Revocation / Audit)  [STUDENT TEMPLATE]
/// @notice Implement every TODO(member4). Spec: docs/audit-module.md + test/AuditTrail.t.sol.
contract AuditTrail {
    RecordRegistry public immutable registry;

    event VehicleTransferred(bytes32 indexed id, address indexed from, address indexed to, uint64 at);
    event CertificateRevoked(bytes32 indexed id, address indexed by, string reason, uint64 at);
    event CertificateRenewed(bytes32 indexed id, bytes32 newHash, string newCid, uint64 at);
    event InspectionLogged(bytes32 indexed id, address indexed by, string note, uint64 at);

    error NotOwner();
    error NotTestCenterOrRegulator();
    error Missing();

    constructor(address recordRegistry) { registry = RecordRegistry(recordRegistry); }

    /// @notice Current owner transfers the record to a new owner.
    function transferVehicle(bytes32 id, address newOwner) external {
        // TODO(member4): read record; require it exists (else Missing) and msg.sender == owner (else NotOwner);
        //               registry.controllerTransfer(id, newOwner); emit VehicleTransferred.
        revert("TODO(member4): implement transferVehicle");
    }
    /// @notice Issuer or regulator revokes the record.
    function revokeCertificate(bytes32 id, string calldata reason) external {
        // TODO(member4): require exists; require msg.sender == issuer || registry.issuers().regulator();
        //               registry.controllerRevoke(id, msg.sender); emit Revoked.
        revert("TODO(member4): implement revoke");
    }
    /// @notice Issuer supersedes the record with a new hash/CID.
    function renewCertificate(bytes32 id, bytes32 newHash, string calldata newCid) external {
        // TODO(member4): same authz as revoke; registry.controllerUpdate(...); emit Updated.
        revert("TODO(member4): implement update");
    }
    /// @notice Anyone can drop a checkpoint into the audit log.
    function logInspection(bytes32 id, string calldata note) external {
        // TODO(member4): emit InspectionLogged(id, msg.sender, note, uint64(block.timestamp));
        revert("TODO(member4): implement logInspection");
    }
}
