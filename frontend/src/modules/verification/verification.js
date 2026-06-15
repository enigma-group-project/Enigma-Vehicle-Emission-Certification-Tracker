import { readContracts, mountNetworkSelector, recordId, hashBytes } from "../../shared/app.js";
mountNetworkSelector("net");
const out = (m) => (document.getElementById("out").textContent = m);
const val = (id) => document.getElementById(id).value.trim();
const STATUS = ["None", "Active", "Revoked", "Superseded"];
document.getElementById("verify").onclick = async () => {
  // TODO(member3): const [valid,status,owner,issuer] = await readContracts().verification.verifyCertificate(recordId(val("key")), hashBytes(val("artifact")));
  //               out((valid?"VALID":"NOT VALID") + ... STATUS[Number(status)] ...);
  out("TODO(member3): implement verifyCertificate call");
};
