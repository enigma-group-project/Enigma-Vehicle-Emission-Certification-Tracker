// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {IssuerRegistry} from "../contracts/IssuerRegistry.sol";
import {RecordRegistry} from "../contracts/RecordRegistry.sol";
import {Verification} from "../contracts/Verification.sol";
import {AuditTrail} from "../contracts/AuditTrail.sol";

/// @notice Deploys + wires the Enigma-Vehicle-Emission-Certification-Tracker spine. Scenario: Emission certification and audit: accredited test centers issue tamper-evident emission certificates a regulator can trust without re-contacting the test center.
contract Deploy is Script {
    function run() external {
        vm.startBroadcast();
        IssuerRegistry issuers = new IssuerRegistry();
        RecordRegistry records = new RecordRegistry(address(issuers));
        Verification verifier = new Verification(address(records));
        AuditTrail audit = new AuditTrail(address(records));
        records.setController(address(audit));
        vm.stopBroadcast();

        console2.log("IssuerRegistry:", address(issuers));
        console2.log("RecordRegistry:", address(records));
        console2.log("Verification :", address(verifier));
        console2.log("AuditTrail   :", address(audit));
    }
}
