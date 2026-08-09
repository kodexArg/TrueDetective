---
title: adr-09-gh-deploy-and-versioning
type: adr
category: devops
use_case: opening a GitHub issue or PR, merging to main, tagging a release, editing workshop version, adding or changing GitHub Actions, choosing branch protection
created: 2026-08-08
modified: 2026-08-08
tags: [adr, devops, github, versioning, deploy, gha, main]
---

# ADR-09 — GitHub deploy and versioning

## CONTEXT

> This ADR is the smallest shipping path for True Detective on GitHub:
> locked main, issue to PR, tags, and thin automation. No heavy release
> train.

Rules only. Workshop package keys are [[adr-06-steam-configurations]].
Issue party detail remains [[adr-04-issue-delivery]] when used; this ADR
is the always-on git/GitHub floor.

## ASSERTIONS

1. **Default branch is `main` and stays locked.** No direct push of product
   work to `main` by agents. Changes land through a pull request. Owner may
   override in an emergency; the emergency is recorded in `log/` and the PR
   trail when possible.
2. **Path is ISSUE → branch → PR → review → merge → (optional) tag.**  
   - Work starts from a GitHub **issue** when the change is product or law.  
   - Branch name: `issue-<n>-short-kebab` or `chore/short-kebab` for pure
     chore.  
   - Open a **PR** into `main`.  
   - Merge only when checks (if any) pass and the owner accepts.  
   - **Tag** only for a release the owner names.
3. **Version identity.** Release tags: **`v42.20-N.M`** (example
   `v42.20-0.1`). `modversion` in `mod.info` matches without the leading
   `v` when possible (`42.20-0.1`). Workshop item id stays `3383387174`:
   the B42 line updates the original item in place (owner decision
   2026-08-08).
4. **What “deploy” means here.** There is no cloud app deploy. Deploy is:
   - merge to `main` on `kodexArg/TrueDetective`  
   - optional git tag  
   - local `./scripts/install-local.sh` for the owner machine  
   - optional Steam Workshop upload by the **owner only** (never silent
     agent upload)
5. **GitHub Actions stay minimal.** Workflows under `.github/workflows/`
   only do cheap gates, for example:
   - PR: confirm required paths exist (`Contents/mods/TrueDetective/mod.info`,
     `42.0/media`, `docs/adrs/adr-00-discipline.md`)  
   - PR: fail on secrets-looking patterns in the diff if a simple scan is
     present  
   No multi-stage release pipeline, no auto Workshop publish, no force
   push actions.
6. **`main` history is linear preferred.** Prefer squash or rebase merge
   as the repo setting allows; avoid merge commit noise when the host
   default is squash. Do not rewrite published tags.
7. **Agent identity.** GitHub ops use **`kodexArg`** via `gh`. Do not mix
   work accounts.
8. **Failures.** A failed CI run or failed release step writes
   `log/YYYYMMDD-NNN.log` per [[adr-08-logging-strategy]] when handled in
   this workspace.

## FORBIDDEN

- **NEVER** push product commits straight to `main` as the normal path
  (rule 1).
- **NEVER** auto-upload to Steam Workshop from CI or an agent without
  explicit owner command (rule 4).
- **NEVER** add heavy multi-job deploy graphs “for later” (rule 5).
- **NEVER** retag or force-push a published release tag (rule 6).
- **NEVER** invent version schemes other than `v42.20-N.M` without
  amending this ADR (rule 3).

## REJECTED

- **Trunk free-for-all on `main`** — rejected; locked PR path.
- **Semver-only tags without the 42.20 game prefix** — rejected for this
  mod line; game version stays in the tag.
- **Full triage-and-fix mandatory for every one-line chore** — rejected;
  adr-04 remains available; this ADR allows a thin ISSUE→PR without the
  full party when the owner says so.
- **CD to Workshop** — rejected.

## RELATED

### governed paths

- `.github/workflows/` — minimal GHA
- `Contents/mods/TrueDetective/**/mod.info` — `modversion`
- `workshop.txt` — Workshop metadata (owner publish)
- `log/` — ship/debug failures

### related files

- [[adr-04-issue-delivery]] — optional full party
- [[adr-06-steam-configurations]] — Workshop ID / paths
- [[adr-08-logging-strategy]] — failure logs
- [[CONVENTION]] — tag naming
- [[PRD]] — product
