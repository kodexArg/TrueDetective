# Runtime adapters — triage-and-fix

> **This clone:** agent tooling is **runtime-agnostic**. SSOT is always
> `docs/agents/`, `docs/skills/`, `docs/hooks/`. Primary operator on this host
> for True Detective sessions is **Grok** (path injection). Other hosts are
> optional adapters of the same tree.

The playbook (`SKILL.md`) and every `kwf-*` YAML contract are identical across
hosts. Only **how you spawn a node** and **which model tier string you pass**
change. Read this file before the first dispatch on a host.

| Tier intent | Meaning |
|---|---|
| cheap / low | Scout, familiar, priest, shadow |
| mid | Sorcerer (trivial plans only) |
| high | Camp builders (warrior/thief/dwarf/archer), bard |
| heavy | Mage, inquisitor, elf-mage, paladin |

## Grok (primary on this host)

**No native `kwf-*` registry required.** The main agent **is the script**: for
each node, `Read` `docs/agents/kwf-<name>.md`, then spawn a worker with a
prompt that **inlines that file** plus the phase handoff, requiring the YAML
output contract as the final message.

| Tier intent | Worker |
|---|---|
| cheap / low | read-only scout worker |
| mid | mid worker |
| high | write-capable builder |
| heavy | high-effort worker (mage, inquisitor, heavy builders) |

Builders that must edit: use a write-capable worker, never a read-only scout.
Priest and shadow stay tool-free in prompt even if the worker could use tools
— instruct "tools: none; judge only."

Parallelism: fan out forest (hunter+falcon+hound) and camp slices as parallel
spawns in one turn when the host allows. Doctrine loop: resume the same planner
when supported; otherwise re-dispatch with the full prior plan + inquisitor
findings.

## Cursor

Same path-injection adapter as Grok when Cursor `Task` types are a fixed enum.
Map cheap → read-only scout, mid/high → write builders, heavy → high-effort.

## Kimi Code CLI

**Optional.** Cast files in `docs/agents/kwf-*.md` resolve when that directory
is on `extra_agent_dirs`. Skill on the Kimi skill path. Dispatch via native
`Agent` + `subagent_type: kwf-<name>` if the host supports it; otherwise use
the same path-injection pattern as Grok.

## Other hosts

Any agent that can **read files by path** can run the party. Symlinks under
product-specific folders (for example `.claude/agents` → `docs/agents`) are
**projections only** — never a second SSOT. They are not required for Grok.

## Souls

Every `kwf-*` / guardian agent may declare `soul: docs/agents/souls/<name>.md`
([[adr-02-harness]]). On dispatch, **prepend that file** to the node prompt
when the host does not load `soul:` natively. Soul is voice only — YAML
contract and law links in the agent file win.

## Shared invariants (all runtimes)

1. YAML final-message contracts — never prose handoffs between phases.
2. Dead / garbage node → phase abort (`hunter-failed`, …).
3. Builders create their own git worktrees; bard merges path-disjoint slices.
4. Post-bard: `guardian-dispatch --bundle` (paste payload; cheap tier;
   parallel when both owed) + `kskill-assertion-review` when assertions moved.
5. `bin/kwf-deps` path: `docs/skills/kskill-triage-and-fix/bin/kwf-deps` from repo root.

## Guardians (all runtimes)

| Intent | Pin |
|---|---|
| cheap (default) | cheapest worker that can Read/Grep/Glob |
| escalate | mid/high only when triage cannot return the one-line pass |

Owner always runs `python3 docs/hooks/khook-guardian-dispatch --bundle …` and
inlines that stdout into the guardian prompt before spawn. Do not let the
guardian rediscover the batch.
