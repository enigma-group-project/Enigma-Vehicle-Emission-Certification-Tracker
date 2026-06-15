// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/// @title IAttestationRegistry — shared type surface for the Enigma attestation spine.
/// @notice Scenario: Emission certification and audit: accredited test centers issue tamper-evident emission certificates a regulator can trust without re-contacting the test center. (record = EmissionCert).
/// @dev Every slice imports this so all four members share one vocabulary.
interface IAttestationRegistry {
    enum Status { None, Active, Revoked, Superseded }

    struct Attestation {
        bytes32 dataHash;    // keccak256 of the off-chain EmissionCert artifact
        string  cid;         // IPFS CID of the artifact
        address issuer;      // who issued it (Accredited Test Center)
        address owner;       // current owner (Vehicle/Facility Owner)
        uint64  issuedAt;    // block timestamp at creation
        Status  status;      // lifecycle flag
        string  metadataURI; // ipfs:// pointer to record.json
    }

    event CertificateIssued(bytes32 indexed id, address indexed issuer, address indexed owner, bytes32 dataHash, string cid);
    event OwnerTransferred(bytes32 indexed id, address indexed from, address indexed to);
    event RecordRevoked(bytes32 indexed id, address indexed by);
    event RecordUpdated(bytes32 indexed id, bytes32 newHash, string newCid);

    function getRecord(bytes32 id) external view returns (Attestation memory);
    function exists(bytes32 id) external view returns (bool);
}
