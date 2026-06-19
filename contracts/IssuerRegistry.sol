// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
/// @title IssuerRegistry — Slice 1 (Test-Center Registration)  [STUDENT TEMPLATE]
contract IssuerRegistry is Ownable {
    mapping(address => bool) public isTestCenter;
    event RegulatorTransferred(address indexed from, address indexed to);
    event TestCenterRegistered(address indexed testCenter, address indexed by);
    event TestCenterDeregistered(address indexed testCenter, address indexed by);
    error NotRegulator(); error ZeroAddress();
    modifier onlyRegulator() { if (msg.sender != owner()) revert NotRegulator(); _; }
    constructor() Ownable(msg.sender) { emit RegulatorTransferred(address(0), msg.sender); }
    function regulator() external view returns (address) { return owner(); }
    function registerTestCenter(address account) external onlyRegulator { revert("TODO(member1): implement registerTestCenter"); }
    function deregisterTestCenter(address account) external onlyRegulator { revert("TODO(member1): implement deregisterTestCenter"); }
    function transferRegulator(address newAdmin) external onlyRegulator { revert("TODO(member1): implement transferRegulator"); }
}
