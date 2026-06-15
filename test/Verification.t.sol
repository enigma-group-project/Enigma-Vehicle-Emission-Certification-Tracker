// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {IssuerRegistry} from "../contracts/IssuerRegistry.sol";
import {RecordRegistry} from "../contracts/RecordRegistry.sol";
import {Verification} from "../contracts/Verification.sol";
import {IAttestationRegistry} from "../contracts/interfaces/IAttestationRegistry.sol";

/// @notice Slice 3 tests — Verification.
contract VerificationTest is Test {
    IssuerRegistry issuers;
    RecordRegistry records;
    Verification verifier;
    address issuer = address(0x1551E5);
    address owner  = address(0x0E1);
    bytes32 id     = keccak256("record-1");
    bytes32 dataHash = keccak256("artifact-bytes");

    function setUp() public {
        issuers = new IssuerRegistry();
        records = new RecordRegistry(address(issuers));
        verifier = new Verification(address(records));
        issuers.registerTestCenter(issuer);
        vm.prank(issuer);
        records.issueCertificate(id, dataHash, "cid1", owner, "ipfs://meta");
    }

    function test_VerifyHashMatch() public view {
        assertTrue(verifier.verifyCertificateHash(id, dataHash));
    }

    function test_WrongHashFails() public view {
        assertFalse(verifier.verifyCertificateHash(id, keccak256("wrong")));
    }

    function test_FullVerifyActive() public view {
        (bool valid, IAttestationRegistry.Status status, address o, address i) = verifier.verifyCertificate(id, dataHash);
        assertTrue(valid);
        assertEq(uint256(status), uint256(IAttestationRegistry.Status.Active));
        assertEq(o, owner);
        assertEq(i, issuer);
    }
    // TODO(slice-3): assert verifyCertificate returns valid=false after a revoke.
}
