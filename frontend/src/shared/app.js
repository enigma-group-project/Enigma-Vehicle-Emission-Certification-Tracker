// Shared ethers.js wiring for the Enigma attestation spine — dual-network (Anvil + Sepolia).
// Reads go through a public JSON-RPC (no wallet needed); writes go through MetaMask.
import { ethers } from "https://cdn.jsdelivr.net/npm/ethers@6.13.0/dist/ethers.min.js";
import { ABIS } from "./abi.js";
import { NETWORKS, DEFAULT_NETWORK } from "./config.js";

const KEY = "enigma.network";
export function activeNetworkKey() { return localStorage.getItem(KEY) || DEFAULT_NETWORK; }
export function setActiveNetwork(k) { localStorage.setItem(KEY, k); }
export function net() { return NETWORKS[activeNetworkKey()]; }

// Read-only provider (free; works on GitHub Pages without a wallet).
export function readProvider() { return new ethers.JsonRpcProvider(net().rpcUrl); }

// Write provider (MetaMask). Throws a friendly message if no wallet is present.
export async function connect() {
  if (!window.ethereum) throw new Error("No wallet found. Reads work without one; writes need MetaMask pointed at " + net().label + ".");
  const provider = new ethers.BrowserProvider(window.ethereum);
  await provider.send("eth_requestAccounts", []);
  const signer = await provider.getSigner();
  return { provider, signer };
}

function build(runner) {
  const a = net().addresses;
  return {
    issuers:      new ethers.Contract(a.IssuerRegistry, ABIS.IssuerRegistry, runner),
    records:      new ethers.Contract(a.RecordRegistry, ABIS.RecordRegistry, runner),
    verification: new ethers.Contract(a.Verification,   ABIS.Verification,   runner),
    audit:        new ethers.Contract(a.AuditTrail,     ABIS.AuditTrail,     runner),
  };
}
export function readContracts()        { return build(readProvider()); }
export function writeContracts(signer) { return build(signer); }

export function recordId(naturalKey) { return ethers.keccak256(ethers.toUtf8Bytes(naturalKey)); }
export function hashBytes(text)      { return ethers.keccak256(ethers.toUtf8Bytes(text)); }

// Drop-in <select> that lets the visitor switch Anvil <-> Sepolia. Reloads on change.
export function mountNetworkSelector(elId) {
  const el = document.getElementById(elId);
  if (!el) return;
  el.innerHTML = Object.entries(NETWORKS)
    .map(([k, v]) => `<option value="${k}">${v.label}</option>`).join("");
  el.value = activeNetworkKey();
  el.onchange = () => { setActiveNetwork(el.value); location.reload(); };
}

