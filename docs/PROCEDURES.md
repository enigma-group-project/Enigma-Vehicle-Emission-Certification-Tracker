# 🧪 Build · Validate · Troubleshoot · Test — Enigma-Vehicle-Emission-Certification-Tracker

> **enigma-group-project** · student template (implement the TODOs)
> Repo: <https://github.com/enigma-group-project/Enigma-Vehicle-Emission-Certification-Tracker> · GUI: <https://enigma-group-project.github.io/Enigma-Vehicle-Emission-Certification-Tracker/> · Tracker: <https://enigma-group-project.github.io/Enigma-Vehicle-Emission-Certification-Tracker/tracker/>

This repo has four vertical slices (one per member). The contract **files** are generic
(`IssuerRegistry / RecordRegistry / Verification / AuditTrail`); the **functions** are domain-specific:

| # | Slice | Contract | Test this slice | Frontend page | Key functions |
|---|-------|----------|-----------------|---------------|---------------|
| 1 | Registration | `contracts/IssuerRegistry.sol` | `forge test --match-contract IssuerRegistryTest` | `frontend/src/modules/issuer/` | `registerTestCenter / deregisterTestCenter / transferRegulator` |
| 2 | Certificate issuance | `contracts/RecordRegistry.sol` | `forge test --match-contract RecordRegistryTest` | `frontend/src/modules/record/` | `issueCertificate` |
| 3 | Verification | `contracts/Verification.sol` | `forge test --match-contract VerificationTest` | `frontend/src/modules/verification/` | `verifyCertificate / verifyCertificateHash` |
| 4 | Transfer / revoke / audit | `contracts/AuditTrail.sol` | `forge test --match-contract AuditTrailTest` | `frontend/src/modules/audit/` | `transferVehicle / revokeCertificate / renewCertificate / logInspection` |

---

## A. Local — compile, validate, troubleshoot, test the GUI

### A0. One-time toolchain (macOS)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  # if no brew
brew install git gh jq node
curl -L https://foundry.paradigm.xyz | bash && source ~/.zshenv 2>/dev/null; foundryup
forge --version        # ✅ prints a forge version
```

### A1. Get the code
```bash
git clone https://github.com/enigma-group-project/Enigma-Vehicle-Emission-Certification-Tracker.git
cd Enigma-Vehicle-Emission-Certification-Tracker
forge install foundry-rs/forge-std       # test dependency
```

### A2. Compile
```bash
forge build            # ✅ "Compiler run successful!"
forge build --sizes    # per-contract bytecode sizes
```

### A3. Validate (tests)
`forge test -vvv` → tests **fail by design** until you implement the `TODO(memberN)` markers. Implement a slice, then `forge test --match-contract <Slice>Test` until green.
```bash
forge test -vvv                                   # all slices
forge test --match-contract IssuerRegistryTest    # one slice (repeat per slice, see table)
forge test --gas-report                           # gas numbers for the evaluation table
```

### A4. Troubleshoot
| Symptom | Cause | Fix |
|---|---|---|
| `forge: command not found` | Foundry not installed/loaded | `curl -L https://foundry.paradigm.xyz \| bash` then `foundryup`; reopen shell |
| `Source "forge-std/Test.sol" not found` | dep missing on fresh clone | `forge install foundry-rs/forge-std` |
| `unexpected argument '--no-commit'` | old flag, removed in forge 1.7+ | run `forge install foundry-rs/forge-std` (no `--no-commit`) |
| `Source file requires different compiler version` | wrong solc | `foundry.toml` pins `0.8.20`; run `foundryup` (the IDE Solidity plugin may warn — Foundry is authoritative) |
| test reverts `TODO(memberN): implement …` | slice not implemented yet | implement that function in its `contracts/*.sol` |
| `Connection refused` on deploy | Anvil not running | start `anvil` in a second terminal |
| MetaMask “wrong network” | chain mismatch | Anvil = chainId **31337** (`http://127.0.0.1:8545`); Sepolia = **11155111** |
| GUI buttons do nothing / read empty | ABI/addresses not wired | regenerate `frontend/src/shared/abi.js` and paste deployed addresses into `frontend/src/shared/config.js` |
| Pages **404** | Pages source not set | repo must be public; **Settings ▸ Pages ▸ Source = GitHub Actions**; wait for the **Deploy Pages** run |
| CI: “workflow not allowed” | cross-org reusable workflow blocked | org **Settings ▸ Actions ▸ General** → allow all actions / `cyber-enigma/*` |


### A5. Test the GUI locally (Anvil)
```bash
anvil                                              # terminal 2 — leave running (prints accounts + keys)
# terminal 1, from the repo root:
forge script script/Deploy.s.sol:Deploy --rpc-url http://127.0.0.1:8545 --broadcast
# regenerate the ABI bundle from the build output:
cat > frontend/src/shared/abi.js <<EOF
export const ABIS = {
  IssuerRegistry: $(jq -c .abi out/IssuerRegistry.sol/IssuerRegistry.json),
  RecordRegistry: $(jq -c .abi out/RecordRegistry.sol/RecordRegistry.json),
  Verification:   $(jq -c .abi out/Verification.sol/Verification.json),
  AuditTrail:     $(jq -c .abi out/AuditTrail.sol/AuditTrail.json),
};
EOF
# paste the 4 printed addresses into the "anvil" block of frontend/src/shared/config.js, then:
cd frontend/src && python3 -m http.server 8080      # open http://localhost:8080
```
In MetaMask: add network **RPC `http://127.0.0.1:8545`, Chain ID `31337`**, import Anvil **account[0]** as Admin.
Then walk the four module pages in order (Registration → Record → Verification → Audit) using the **Key functions** in the table above.

---

## B. Remote — compile, validate, troubleshoot, test the GUI (on GitHub)

### B1. Compile & validate via CI
Every push / PR triggers **`.github/workflows/ci.yml`**. Open the repo's **Actions** tab → latest **CI** run → the
**build-test** job runs `forge build` + `forge test`. A green ✔ = compiles and tests ran (see Auto-Grade for the score).
```bash
gh run list  -R enigma-group-project/Enigma-Vehicle-Emission-Certification-Tracker --workflow ci.yml --limit 1
gh run watch -R enigma-group-project/Enigma-Vehicle-Emission-Certification-Tracker
```

### B2. Troubleshoot remotely
Open the failed run → **build-test** → expand the red step to read the log, or:
```bash
gh run view -R enigma-group-project/Enigma-Vehicle-Emission-Certification-Tracker --log-failed
```
Same root causes as the table in **A4** (most often: forge-std install or a Solidity error).

### B3. Test the GUI on GitHub Pages
- 🌐 **https://enigma-group-project.github.io/Enigma-Vehicle-Emission-Certification-Tracker/** — the live four-module web app (published by `.github/workflows/pages.yml` from `frontend/src`).
- 📊 **https://enigma-group-project.github.io/Enigma-Vehicle-Emission-Certification-Tracker/tracker/** — the project task tracker.
Reads work with no wallet on the configured network; writes use the visitor's MetaMask. For a hosted on-chain demo, deploy to **Sepolia** (RUNBOOK §2b), paste the addresses into `config.js`, set `DEFAULT_NETWORK="sepolia"`, and push.

### B4. Auto-Grade score (template only)
Every push runs **Auto-Grade** (`.github/workflows/grade.yml`, a reusable workflow from `cyber-enigma/autograder`).
Open **Actions ▸ Auto-Grade ▸ latest run ▸ Summary** to see the score table (a fresh skeleton ≈ **57/100**; it rises as tests pass and `TODO(memberN)` markers are cleared).

---

_Procedure doc generated for the Enigma framework. Compile = `forge build` · validate = `forge test` · GUI = the URLs above._
