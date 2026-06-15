// Network config for the Enigma demo frontend.
// DEV  = local Anvil (forge script Deploy ... --rpc-url http://127.0.0.1:8545)
// DEMO = Sepolia testnet (hosted on GitHub Pages; deploy once, paste addresses below)
//
// After each deployment, paste the four printed addresses into the matching block.
export const NETWORKS = {
  anvil: {
    label: "Local Anvil (dev)",
    chainId: 31337,
    rpcUrl: "http://127.0.0.1:8545",
    explorer: "",
    addresses: {
      IssuerRegistry: "0x0000000000000000000000000000000000000000",
      RecordRegistry: "0x0000000000000000000000000000000000000000",
      Verification:   "0x0000000000000000000000000000000000000000",
      AuditTrail:     "0x0000000000000000000000000000000000000000",
    },
  },
  sepolia: {
    label: "Sepolia (hosted demo)",
    chainId: 11155111,
    rpcUrl: "https://ethereum-sepolia-rpc.publicnode.com",
    explorer: "https://sepolia.etherscan.io",
    addresses: {
      IssuerRegistry: "0x0000000000000000000000000000000000000000",
      RecordRegistry: "0x0000000000000000000000000000000000000000",
      Verification:   "0x0000000000000000000000000000000000000000",
      AuditTrail:     "0x0000000000000000000000000000000000000000",
    },
  },
};

// Which network the page uses when the visitor hasn't chosen one.
// GitHub Pages → set to "sepolia"; local dev → "anvil".
export const DEFAULT_NETWORK = "anvil";
