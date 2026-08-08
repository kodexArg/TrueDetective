---
title: adr-08-logging-strategy
type: adr
category: devops
use_case: debugging a failed install or agent batch, writing an error during harness work, choosing where to put a log file, reviewing whether a change left no trace for the harness
created: 2026-08-08
modified: 2026-08-08
tags: [adr, devops, logging, harness, debug]
---

# ADR-08 — logging strategy

## CONTEXT

> The harness debugs from files, not from chat memory. Every serious
> failure of install, load, or agent work must leave a dated log under the
> repo so the next session can read it.

Rules only. Game console paths for PZ live in
[[adr-06-steam-configurations]]. Code style for any logger helper is
[[adr-07-clean-code]].

## ASSERTIONS

1. **Mandatory project log tree.** Repository root carries a **`log/`**
   directory (name exact: `log`). It is the harness debug surface for this
   project.
2. **File name per iteration.** Each log file is named
   **`YYYYMMDD-NNN`** plus extension `.log`  
   Example: `log/20260808-001.log`, then `log/20260808-002.log` the same
   day. `NNN` is a three-digit sequence starting at `001` for that calendar
   day (UTC or host local — pick host local and stay consistent).
3. **What must be logged.** Any error that stops install, mod load proof,
   script failure, guardian/dispatch failure, or agent batch failure is
   written to a new or open iteration file under `log/`. Include: timestamp,
   command or step, exit code or error text, paths touched. Do not log
   secrets.
4. **One iteration, one file.** One continuous work pass (install attempt,
   load verify, CI failure dig, agent delivery close) uses one
   `YYYYMMDD-NNN` file. A new pass gets a new sequence number.
5. **Game console is secondary evidence.** PZ client output remains in
   `~/Zomboid/console.txt` and `~/Zomboid/Logs/`. When debugging load,
   copy or quote the relevant lines into the project `log/` file so the
   harness has a durable in-repo trace.
6. **In-mod print tag.** Runtime `print` from the mod uses a stable English
   prefix **`[TrueDetective]`** so console greps stay simple. That does not
   replace the `log/` file for harness failures.
7. **Git policy.** `log/*.log` is gitignored except a `log/.gitkeep` (or
   equivalent) so the folder exists. Logs stay local unless the owner asks
   to commit a specific file for a bug report.
8. **No silent failure.** If a required step fails and no `log/` entry was
   written, the batch is incomplete — write the log before closing.

## FORBIDDEN

- **NEVER** drop a hard failure only in chat with no `log/YYYYMMDD-NNN.log`
  (rules 1–3, 8).
- **NEVER** put tokens, cookies, or passwords in a log file (rule 3).
- **NEVER** invent a second debug tree (`logs/`, `debug/`, `.logs/`) as
  SSOT (rule 1).
- **NEVER** reuse an old day’s sequence without advancing `NNN` for a new
  pass (rule 4).

## REJECTED

- **Chat-only debugging** — rejected; harness trusts `log/`.
- **Single rotating `latest.log` only** — rejected as the sole scheme;
  dated sequence is mandatory (a `latest` symlink is optional extra).
- **Committing every log by default** — rejected; local unless owner
  asks.

## RELATED

### governed paths

- `log/` — harness iteration logs (`YYYYMMDD-NNN.log`)
- `~/Zomboid/console.txt` — secondary game evidence
- `scripts/install-local.sh` — install failures must log

### related files

- [[adr-06-steam-configurations]] — game paths and console
- [[adr-07-clean-code]] — no secrets in code; minimal helpers
- [[adr-09-gh-deploy-and-versioning]] — CI failures also land in `log/`
  when investigated locally
- [[CLONE]] — install steps
