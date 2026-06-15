import { connect, writeContracts, readContracts, mountNetworkSelector, net } from "../../shared/app.js";
mountNetworkSelector("net");
const out = (m) => (document.getElementById("out").textContent = m);
const val = (id) => document.getElementById(id).value.trim();
let signer, wc;
document.getElementById("connect").onclick = async () => {
  try { ({ signer } = await connect()); wc = writeContracts(signer);
    document.getElementById("who").textContent = "Connected: " + (await signer.getAddress()) + " · " + net().label;
  } catch (e) { out(String(e.message || e)); }
};
document.getElementById("register").onclick = async () => {
  // TODO(member1): const tx = await wc.issuers.registerTestCenter(val("issuerAddr")); await tx.wait(); out("registered");
  out("TODO(member1): implement registerTestCenter call");
};
document.getElementById("revoke").onclick = async () => {
  // TODO(member1): call wc.issuers.deregisterTestCenter(val("issuerAddr")) and await it
  out("TODO(member1): implement deregisterTestCenter call");
};
document.getElementById("check").onclick = async () => {
  // TODO(member1): const ok = await readContracts().issuers.isTestCenter(val("checkAddr")); out(ok ? "registered" : "not");
  out("TODO(member1): implement isTestCenter read");
};
