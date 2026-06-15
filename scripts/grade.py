#!/usr/bin/env python3
"""Auto-grader for an Enigma student prototype repo. Run from the repo root.
Objective/heuristic checks only; manual rubric items are noted at the end."""
import glob, json, os, re, subprocess

def sh(cmd, timeout=900):
    try:
        return subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=timeout)
    except Exception as e:
        class R:  # noqa
            returncode = 1; stdout = ""; stderr = str(e)
        return R()

rows, score, maxs = [], 0.0, 0.0
def add(cat, got, mx, note=""):
    global score, maxs
    score += got; maxs += mx
    rows.append(f"| {cat} | {got:.1f} / {mx} | {note} |")

# 1) compiles (15)
build = sh("forge build")
ok = build.returncode == 0
add("Compiles (forge build)", 15 if ok else 0, 15, "ok" if ok else "build failed")

# 2) tests passing (35)
passed = total = 0
if ok:
    t = sh("forge test --json")
    out = (t.stdout or "").strip().splitlines()
    for line in reversed(out):
        line = line.strip()
        if not line.startswith("{"):
            continue
        try:
            data = json.loads(line)
        except Exception:
            continue
        for suite in data.values():
            for r in (suite.get("test_results") or {}).values():
                total += 1
                if r.get("status") == "Success":
                    passed += 1
        break
ratio = (passed / total) if total else 0.0
add("Tests passing", 35 * ratio, 35, f"{passed}/{total} passing")

# 3) required files (15)
req = ["contracts/IssuerRegistry.sol","contracts/RecordRegistry.sol","contracts/Verification.sol",
       "contracts/AuditTrail.sol","contracts/interfaces/IAttestationRegistry.sol","script/Deploy.s.sol",
       "test/IssuerRegistry.t.sol","test/RecordRegistry.t.sol","test/Verification.t.sol","test/AuditTrail.t.sol",
       "schemas/attestation-onchain.schema.json","schemas/record.schema.json","frontend/src/index.html","README.md"]
present = sum(1 for f in req if os.path.exists(f))
add("Required files present", 15 * present / len(req), 15, f"{present}/{len(req)}")

# 4) implementation completeness (15): contract TODO markers cleared
csrc = ""
for f in glob.glob("contracts/**/*.sol", recursive=True):
    try: csrc += open(f).read()
    except Exception: pass
todos = len(re.findall(r"TODO\(member", csrc)) + csrc.count('revert("TODO')
impl = 15.0 if todos == 0 else max(0.0, 15 - todos)
add("Contract impl (TODOs cleared)", impl, 15, f"{todos} contract TODO markers left")

# 5) docs present (10)
docs = ["docs/architecture.md","docs/issuer-module.md","docs/record-module.md",
        "docs/verification-module.md","docs/audit-module.md"]
dp = sum(1 for f in docs if os.path.exists(f))
add("Docs present", 10 * dp / len(docs), 10, f"{dp}/{len(docs)}")

# 6) hygiene (10): eval table filled, gitignore, no obvious secrets
readme = open("README.md").read() if os.path.exists("README.md") else ""
hy, notes = 10.0, []
if "~_____" in readme: hy -= 3; notes.append("eval table not filled")
if not os.path.exists(".gitignore"): hy -= 2; notes.append("missing .gitignore")
sec = sh("grep -rIlE "
         "'(PRIVATE_KEY|MNEMONIC)[A-Za-z0-9_]*[[:space:]]*=[[:space:]]*[^[:space:]]{16,}"
         "|BEGIN (RSA|EC|OPENSSH) PRIVATE KEY' "
         "--exclude=grade.py --exclude-dir=.autograder --exclude-dir=.git --exclude-dir=lib . || true")
if (sec.stdout or "").strip(): hy -= 5; notes.append("possible secret committed")
hy = max(0.0, hy)
add("Hygiene", hy, 10, ", ".join(notes) or "ok")

pct = 100 * score / maxs if maxs else 0
report = ("# Auto-grade report\n\n| Category | Score | Notes |\n|---|---|---|\n"
          + "\n".join(rows)
          + f"\n\n**Automated total: {score:.1f} / {maxs:.0f} ({pct:.0f}%)**\n\n"
          + "> Manually graded by the instructor (not in this score): problem definition & blockchain fit, "
            "system-design narrative, evaluation/trade-off discussion, security reasoning depth, report & "
            "presentation. See PROJECT_BRIEF §11.\n")
print(report)
json.dump({"score": round(score,1), "max": maxs, "pct": round(pct,1),
           "tests_passed": passed, "tests_total": total, "contract_todos": todos},
          open("grade.json", "w"), indent=2)
