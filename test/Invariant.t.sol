// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {IssuerRegistry} from "../contracts/IssuerRegistry.sol";
import {RecordRegistry} from "../contracts/RecordRegistry.sol";
import {AuditTrail} from "../contracts/AuditTrail.sol";
import {IAttestationRegistry} from "../contracts/interfaces/IAttestationRegistry.sol";

/// @notice Fuzz + invariant tests (EthTrust [M]/[Q]: property-based testing + state invariants).
contract InvariantTest is Test {
    IssuerRegistry issuers;
    RecordRegistry records;
    AuditTrail audit;
    address issuer = address(0x1551E5);

    function setUp() public {
        issuers = new IssuerRegistry();
        records = new RecordRegistry(address(issuers));
        audit = new AuditTrail(address(records));
        records.setController(address(audit));
        issuers.registerTestCenter(issuer);
    }

    /// @dev Authorization property: a non-Test-Center can NEVER issue, for any inputs.
    function testFuzz_OnlyTestCenterCanIssue(address caller, bytes32 id, bytes32 h, address owner_) public {
        vm.assume(caller != issuer && caller != address(0));
        vm.assume(!issuers.isTestCenter(caller));
        vm.prank(caller);
        vm.expectRevert(RecordRegistry.NotTestCenter.selector);
        records.issueCertificate(id, h, "cid", owner_, "meta");
    }

    /// @dev Accounting property: an issued certificate exists and is Active for any inputs.
    function testFuzz_IssueThenActive(bytes32 id, bytes32 h, address owner_) public {
        vm.prank(issuer);
        records.issueCertificate(id, h, "cid", owner_, "meta");
        assertTrue(records.exists(id));
        assertEq(uint256(records.getRecord(id).status), uint256(IAttestationRegistry.Status.Active));
    }

    /// @dev Invariant: controller wiring is immutable once set (set-once guard holds under fuzzing).
    function invariant_ControllerImmutable() public view {
        assertEq(records.controller(), address(audit));
    }
}
