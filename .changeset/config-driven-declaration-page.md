---
'grants-config-grasslands': minor
---

Move the declaration page copy into the page's `config:` block and drop the `view:` override, so the page renders from the unified grants-ui declaration template. The page heading now comes from the page `title` rather than a duplicate `config.heading`. Presentation only — the heading, button label, body copy and support panel are unchanged, and the page still posts no hidden fields.
