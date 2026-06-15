// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/// @title IssuerRegistry — Slice 1 (TestCenter Registration)  [STUDENT TEMPLATE]
/// @notice Implement every TODO(member1). Behavior is described in docs/issuer-module.md and
///         locked by test/IssuerRegistry.t.sol — run `forge test` until it is green.
contract IssuerRegistry {
    address public regulator;
    mapping(address => bool) public isTestCenter;

    event RegulatorTransferred(address indexed from, address indexed to);
    event TestCenterRegistered(address indexed issuer, address indexed by);
    event TestCenterDeregistered(address indexed issuer, address indexed by);

    error NotRegulator();
    error ZeroAddress();

    modifier onlyRegulator() {
        if (msg.sender != regulator) revert NotRegulator();
        _;
    }

    constructor() {
        regulator = msg.sender;
        emit RegulatorTransferred(address(0), msg.sender);
    }

    /// @notice Grant the issuer role. Admin-only; reject zero address; emit TestCenterRegistered.
    function registerTestCenter(address account) external onlyRegulator {
        // TODO(member1): if account == address(0) revert ZeroAddress();
        //               isTestCenter[account] = true; emit TestCenterRegistered(account, msg.sender);
        revert("TODO(member1): implement registerTestCenter");
    }

    /// @notice Revoke the issuer role. Admin-only; emit TestCenterDeregistered.
    function deregisterTestCenter(address account) external onlyRegulator {
        // TODO(member1): isTestCenter[account] = false; emit TestCenterDeregistered(account, msg.sender);
        revert("TODO(member1): implement deregisterTestCenter");
    }

    /// @notice Transfer the regulator key. Admin-only; reject zero address; emit RegulatorTransferred.
    function transferRegulator(address newAdmin) external onlyRegulator {
        // TODO(member1): validate newAdmin, emit RegulatorTransferred(regulator, newAdmin), then regulator = newAdmin;
        revert("TODO(member1): implement transferRegulator");
    }
}
