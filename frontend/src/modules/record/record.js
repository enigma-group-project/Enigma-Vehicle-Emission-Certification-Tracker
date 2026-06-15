import { connect, writeContracts, mountNetworkSelector, net, recordId, hashBytes } from "../../shared/app.js";
mountNetworkSelector("net");
const out = (m) => (document.getElementById("out").textContent = m);
const val = (id) => document.getElementById(id).value.trim();
let signer, wc;
document.getElementById("connect").onclick = async () => {
  try { ({ signer } = await connect()); wc = writeContracts(signer);
    document.getElementById("who").textContent = "Connected: " + (await signer.getAddress()) + " · " + net().label;
  } catch (e) { out(String(e.message || e)); }
};
document.getElementById("create").onclick = async () => {
  // TODO(member2): id = recordId(val("key")); dataHash = hashBytes(val("artifact"));
  //               await wc.records.issueCertificate(id, dataHash, val("cid"), val("owner"), val("meta"));
  out("TODO(member2): implement issueCertificate call");
};
