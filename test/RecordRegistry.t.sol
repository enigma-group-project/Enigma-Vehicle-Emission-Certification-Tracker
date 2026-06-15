// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {IssuerRegistry} from "../contracts/IssuerRegistry.sol";
import {RecordRegistry} from "../contracts/RecordRegistry.sol";
import {IAttestationRegistry} from "../contracts/interfaces/IAttestationRegistry.sol";

/// @notice Slice 2 tests — Record Creation.
contract RecordRegistryTest is Test {
    IssuerRegistry issuers;
    RecordRegistry records;
    address issuer = address(0x1551E5);
    address owner  = address(0x0E1);
    bytes32 id     = keccak256("record-1");
    bytes32 dataHash = keccak256("artifact-bytes");

    function setUp() public {
        issuers = new IssuerRegistry();
        records = new RecordRegistry(address(issuers));
        issuers.registerTestCenter(issuer);
    }

    function test_IssuerCanCreate() public {
        vm.prank(issuer);
        records.issueCertificate(id, dataHash, "cid1", owner, "ipfs://meta");
        assertTrue(records.exists(id));
        IAttestationRegistry.Attestation memory a = records.getRecord(id);
        assertEq(a.owner, owner);
        assertEq(a.issuer, issuer);
        assertEq(uint256(a.status), uint256(IAttestationRegistry.Status.Active));
    }

    function test_RevertWhen_NonIssuerCreates() public {
        vm.expectRevert(RecordRegistry.NotTestCenter.selector);
        records.issueCertificate(id, dataHash, "cid1", owner, "ipfs://meta");
    }

    function test_RevertWhen_Duplicate() public {
        vm.startPrank(issuer);
        records.issueCertificate(id, dataHash, "cid1", owner, "ipfs://meta");
        vm.expectRevert(RecordRegistry.AlreadyExists.selector);
        records.issueCertificate(id, dataHash, "cid1", owner, "ipfs://meta");
        vm.stopPrank();
    }
    // TODO(slice-2): add an event-emission test (expectEmit CertificateIssued).
}
