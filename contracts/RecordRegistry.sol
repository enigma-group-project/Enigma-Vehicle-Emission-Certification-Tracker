// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IAttestationRegistry} from "./interfaces/IAttestationRegistry.sol";
import {IssuerRegistry} from "./IssuerRegistry.sol";

/// @title RecordRegistry — Slice 2 (CertificateIssued  + state)  [STUDENT TEMPLATE]
/// @notice Implement every TODO(member2). Spec: docs/record-module.md + test/RecordRegistry.t.sol.
contract RecordRegistry is IAttestationRegistry {
    IssuerRegistry public immutable issuers;
    address public controller;
    mapping(bytes32 => Attestation) internal records;
    bool private _locked;

    error NotTestCenter();
    error NotController();
    error NotRegulator();
    error AlreadyExists();
    error Missing();
    error Reentrancy();
    error ControllerSet();

    modifier nonReentrant() { if (_locked) revert Reentrancy(); _locked = true; _; _locked = false; }
    modifier onlyTestCenter() { if (!issuers.isTestCenter(msg.sender)) revert NotTestCenter(); _; }
    modifier onlyController() { if (msg.sender != controller) revert NotController(); _; }

    constructor(address issuerRegistry) { issuers = IssuerRegistry(issuerRegistry); }

    /// @notice One-time link to the AuditTrail controller (regulator only).
    function setController(address controller_) external {
        // TODO(member2): require msg.sender == issuers.regulator() (else NotRegulator), require controller unset
        //               (else ControllerSet), then controller = controller_;
        revert("TODO(member2): implement setController");
    }

    /// @notice Create a record. onlyTestCenter + nonReentrant. Reject duplicate id (AlreadyExists). Emit CertificateIssued.
    function issueCertificate(bytes32 id, bytes32 dataHash, string calldata cid, address owner_, string calldata metadataURI)
        external onlyTestCenter nonReentrant
    {
        // TODO(member2): if records[id].status != Status.None revert AlreadyExists();
        //               write the Attestation (status Active, issuedAt = block.timestamp); emit CertificateIssued.
        revert("TODO(member2): implement issueCertificate");
    }

    function controllerTransfer(bytes32 id, address newOwner) external onlyController {
        // TODO(member4 calls this via AuditTrail): update owner; emit OwnerTransferred.
        revert("TODO: implement controllerTransfer");
    }
    function controllerRevoke(bytes32 id, address by) external onlyController {
        // TODO: set status = Revoked; emit RecordRevoked(id, by).
        revert("TODO: implement controllerRevoke");
    }
    function controllerUpdate(bytes32 id, bytes32 newHash, string calldata newCid) external onlyController {
        // TODO: set new hash/cid, status = Superseded; emit RecordUpdated.
        revert("TODO: implement controllerUpdate");
    }

    function getRecord(bytes32 id) external view returns (Attestation memory) { return records[id]; }
    function exists(bytes32 id) external view returns (bool) { return records[id].status != Status.None; }
}
