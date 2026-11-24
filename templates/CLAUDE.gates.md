## Build run rules (from spec-first)

Spec of record: `specs/NNN-<slug>/`. Code implements it; behaviour changes land
in the spec first, in the same PR.

### Owner gates: always ask first, one at a time, with exact steps
<!-- Record the owner's answer word for word, with the date. -->
- Money: payment, billing or account settings, any write that can reach a
  live external account, anything with legal or tax effect.
- Big decisions: cloud/IAM/secrets changes, paid model runs, irreversible
  data changes that are not backed up, anything the spec lists as open.

### Claude does without asking
- Verify, merge and deploy slices that touch no gate above.
- Before any table drop: a fresh backup, checked.

### Never
- Confirm or send a money action on the owner's behalf.
- Deploy inside the blackout window: <e.g. business hours, a release freeze, or none>.
- Share a checkout or a test database between two sessions.

### Reporting
Outcome first, under 10 lines, no operations; one question at a time with
options and a recommendation.
