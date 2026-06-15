// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {IssuerRegistry} from "../contracts/IssuerRegistry.sol";
import {RecordRegistry} from "../contracts/RecordRegistry.sol";
import {AuditTrail} from "../contracts/AuditTrail.sol";
import {IAttestationRegistry} from "../contracts/interfaces/IAttestationRegistry.sol";

/// @notice Slice 4 tests — Transfer / Revocation / Audit.
contract AuditTrailTest is Test {
    IssuerRegistry issuers;
    RecordRegistry records;
    AuditTrail audit;
    address issuer  = address(0x1551E5);
    address owner   = address(0x0E1);
    address buyer   = address(0xB0B);
    bytes32 id      = keccak256("record-1");
    bytes32 dataHash = keccak256("artifact-bytes");

    function setUp() public {
        issuers = new IssuerRegistry();
        records = new RecordRegistry(address(issuers));
        audit   = new AuditTrail(address(records));
        records.setController(address(audit));
        issuers.registerTestCenter(issuer);
        vm.prank(issuer);
        records.issueCertificate(id, dataHash, "cid1", owner, "ipfs://meta");
    }

    function test_OwnerCanTransfer() public {
        vm.prank(owner);
        audit.transferVehicle(id, buyer);
        assertEq(records.getRecord(id).owner, buyer);
    }

    function test_RevertWhen_NonOwnerTransfers() public {
        vm.expectRevert(AuditTrail.NotOwner.selector);
        audit.transferVehicle(id, buyer);
    }

    function test_IssuerCanRevoke() public {
        vm.prank(issuer);
        audit.revokeCertificate(id, "fraud detected");
        assertEq(uint256(records.getRecord(id).status), uint256(IAttestationRegistry.Status.Revoked));
    }

    function test_AdminCanRevoke() public {
        audit.revokeCertificate(id, "regulator override"); // test contract is regulator
        assertEq(uint256(records.getRecord(id).status), uint256(IAttestationRegistry.Status.Revoked));
    }
    // TODO(slice-4): add front-running / replay reasoning to the threat model.
}
