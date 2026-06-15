import { connect, writeContracts, mountNetworkSelector, net, recordId } from "../../shared/app.js";
mountNetworkSelector("net");
const out = (m) => (document.getElementById("out").textContent = m);
const val = (id) => document.getElementById(id).value.trim();
let signer, wc;
document.getElementById("connect").onclick = async () => {
  try { ({ signer } = await connect()); wc = writeContracts(signer);
    document.getElementById("who").textContent = "Connected: " + (await signer.getAddress()) + " · " + net().label;
  } catch (e) { out(String(e.message || e)); }
};
document.getElementById("transfer").onclick = async () => {
  // TODO(member4): await wc.audit.transferVehicle(recordId(val("key")), val("newOwner"))
  out("TODO(member4): implement transferVehicle call");
};
document.getElementById("revoke").onclick = async () => {
  // TODO(member4): await wc.audit.revokeCertificate(recordId(val("key")), val("reason"))
  out("TODO(member4): implement revoke call");
};
document.getElementById("checkpoint").onclick = async () => {
  // TODO(member4): await wc.audit.logInspection(recordId(val("key")), val("note"))
  out("TODO(member4): implement logInspection call");
};
