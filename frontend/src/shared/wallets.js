// Role -> address mapping using the default Anvil accounts. Scenario: Emission certification and audit: accredited test centers issue tamper-evident emission certificates a regulator can trust without re-contacting the test center.
export const ROLES = {
  admin:    { label: "Admin",      addr: "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266" },
  issuer:   { label: "Accredited Test Center",   addr: "0x70997970C51812dc3A010C7d01b50e0d17dc79C8" },
  owner:    { label: "Vehicle/Facility Owner",    addr: "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC" },
  verifier: { label: "Regulator/Auditor", addr: "0x90F79bf6EB2c4f870365E785982E1f101E93b906" },
};
