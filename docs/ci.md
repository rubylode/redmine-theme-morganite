# Checks and releases

## GitHub

`.github/workflows/check.yml` runs on every push and pull request, on GitHub's own runners: it starts Redmine 7.0.2 and the
7.0 line from the official Docker image, loads the demo data and runs the page check. `.github/workflows/release.yml` runs on
a `v*` tag (or by hand, from a tag): the same check, then a zip of the `morganite` folder attached to a GitHub release, with the
matching section of `CHANGELOG.md` as its notes.

## Gitea

The Gitea workflows run on a self-hosted runner with the label `theme-ci`. That runner works on its host with Docker access,
so only trusted branches may run there:

- `check.yml` runs on pushes to `main` and by hand, and a manual run stops at once unless it was started from `main`. It
  never runs on pull requests. Check a contribution on your own machine, then merge it.
- `release.yml` runs on a `v*` tag. Before anything from the repository runs, it checks that the tagged commit is on `main`.
  It has two jobs: `check` runs `npm ci`, the demo Redmine and the page check with no release token in its environment;
  `release` runs after it, builds the zip and publishes it. Nothing passes from the first job to the second except the tag.
- The release uses the per-run token. If your Gitea refuses that token for releases, add a `RELEASE_TOKEN` secret with the
  `write:repository` scope and nothing else; the workflow then uses it.
- Protect `v*` tags in the repository settings (Settings, Tags, protected tags), so that only maintainers can start a release.

## Drift check

The stylesheets, `javascripts/theme.js`, `test/`, `bin/demo` and `docker-compose.yml` here are generated from the shared base of the
Rubylode themes. The workspace that holds the base runs a `drift` job on every push to its `main` branch: it clones this
repository and runs `ruby bin/build_theme morganite --check` against it, which fails when a generated file here differs from
what the base makes of it. A hand edit to a generated file shows up there, and so does a change to the base that was never
built into this theme. The job needs no workflow in this repository.
