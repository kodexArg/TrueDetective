---
title: Steam configurations — workshop.txt and upload
description: workshop.txt keys, defaults, and True Detective package identity
updated: 2026-08-08
---

# workshop.txt and upload surface

File lives at Workshop package root (this repo: repository root
`workshop.txt`). Used by the in-game uploader / package tools.

## Keys (English identifiers)

| Key | Example / default | Meaning |
|---|---|---|
| `version` | `1` | Format version |
| `id` | `3383387174` | Steam **Workshop item id** (empty until first publish) |
| `title` | `True Detective` | Workshop title |
| `description` | multi-line `description=` rows | Workshop body (BBCode-friendly) |
| `tags` | `Build 42;Misc` | Semicolon-separated tags |
| `visibility` | `public` | Also: `friends`, `private`, `unlisted` (Steam norms) |

> B42.20 fact (verified in game classes 2026-08-08): the mod manager's
> **Homepage** row is fed from Steam Workshop metadata, not from mod.info —
> the `mod.info` parser (`ZomboidFileSystem`) has no `url` key. Local/staged
> packages always show a blank Homepage. Put homepage links in the
> `workshop.txt` description instead.

## True Detective package (this project)

The B42 / Survey Sense line publishes as an **update of the original
Workshop item `3383387174`** (owner decision 2026-08-08): one page, one
subscriber base. The B41 build is superseded on that page.

```text
version=1
id=3383387174
title=True Detective
description=[h1]True Detective[/h1]
description=Build 42.20 profession mod — playable Detective occupation.
description=
description=Mod ID: TrueDetective
description=Source: https://github.com/kodexArg/TrueDetective
description=License: MIT
tags=Build 42;Misc
visibility=public
```

## Upload tree

Only **`Contents/`** is the workshop content payload. Sibling folders
(`docs/`, `scripts/`, `.git`, harness) stay out of the Workshop zip when
the package root is structured per wiki Workshop folder rules.

Preview image: `preview.png` at package root, **256×256** (game/uploader
expectation).

## Two IDs (always English labels)

| Name | Example | Used for |
|---|---|---|
| **Workshop ID** | `3383387174` | Steam URL, `workshop.txt` `id=`, server `WorkshopItems=` |
| **Mod ID** | `TrueDetective` | `mod.info` `id=`, `Mods=`, `default.txt` `mod =` |

Do not swap them.

## Server-oriented lines (defaults empty)

When hosting with Workshop mods (dedicated or listen):

```text
WorkshopItems=3383387174
Mods=TrueDetective
```

Multiple mods: semicolon-separated lists (no spaces is safest community
practice). Exact key names are English and case-sensitive as the server
`.ini` defines them.
