# Rubylode Morganite for Redmine

<p><img src="docs/thumbnail.png" alt="Rubylode Morganite theme" width="160"></p>

[![check](https://img.shields.io/github/actions/workflow/status/rubylode/redmine-theme-morganite/check.yml?branch=main&label=check)](https://github.com/rubylode/redmine-theme-morganite/actions/workflows/check.yml)
[![security](https://img.shields.io/github/actions/workflow/status/rubylode/redmine-theme-morganite/security.yml?branch=main&label=security)](https://github.com/rubylode/redmine-theme-morganite/actions/workflows/security.yml)
[![version](https://img.shields.io/github/v/tag/rubylode/redmine-theme-morganite?sort=semver&label=version)](https://github.com/rubylode/redmine-theme-morganite/tags)
[![license](https://img.shields.io/github/license/rubylode/redmine-theme-morganite)](https://github.com/rubylode/redmine-theme-morganite/blob/main/LICENSE)
![Redmine](https://img.shields.io/badge/Redmine-7.0-b22222)

A theme for Redmine 7 and up: warm neutrals and a coral accent on a white page, a dark sidebar for the project menu and an issue list that reads as a to-do list.

It is plain CSS plus one small script (`javascripts/theme.js`, about 170 lines), with no plugin, no build step and no change to Redmine itself. The script only reads the page. It puts a status dot beside the group name in an issue list grouped by status, gives the top bar a hairline shadow once the page scrolls, and adds three things of Morganite's own: round initials beside assignees, a chip round the tracker name and a row of view tabs above the issue list. Without the script the theme still works, with plain names and trackers and the project menu alone. It is built on the shared Rubylode theme base, so it covers the same pages as the other Rubylode themes and styles the Rubylode plugins.

Light is the main look. Dark follows your system setting (see [Dark mode](#dark-mode)).

![A walk through Rubylode Morganite: the issue list, an issue, the wiki, the to-do page and the new issue form](docs/demo/walkthrough-light.gif)

| | |
|---|---|
| ![The issue list](docs/screenshots/issues-light.png) | ![An issue](docs/screenshots/issue-light.png) |
| ![The new issue form](docs/screenshots/new-issue-light.png) | ![The project overview, with the Rubylode Projects plugin](docs/screenshots/project-light.png) |
| ![The projects list, with the Rubylode Projects plugin](docs/screenshots/projects-light.png) | ![My page, with the Rubylode Home plugin](docs/screenshots/my-page-light.png) |
| ![The welcome page, with the Rubylode Home plugin](docs/screenshots/home-light.png) | ![A status block, from the Rubylode Uptime Kuma plugin](docs/screenshots/service-status-light.png) |
| ![The Stats page, with the Rubylode Stats plugin](docs/screenshots/stats-light.png) | ![The to-do page, with the Rubylode To-do plugin](docs/screenshots/todo-light.png) |

Dark mode:

![A walk through Rubylode Morganite in dark mode](docs/demo/walkthrough-dark.gif)

| | |
|---|---|
| ![The issue list in dark mode](docs/screenshots/issues-dark.png) | ![An issue in dark mode](docs/screenshots/issue-dark.png) |
| ![The new issue form in dark mode](docs/screenshots/new-issue-dark.png) | ![The project overview in dark mode](docs/screenshots/project-dark.png) |
| ![The projects list in dark mode](docs/screenshots/projects-dark.png) | ![My page in dark mode](docs/screenshots/my-page-dark.png) |
| ![The welcome page in dark mode](docs/screenshots/home-dark.png) | ![A status block in dark mode](docs/screenshots/service-status-dark.png) |
| ![The Stats page in dark mode](docs/screenshots/stats-dark.png) | ![The to-do page in dark mode](docs/screenshots/todo-dark.png) |

The screenshots come from the demo Redmine in this repository; the people, projects and issues in it are made up.

## Contents

- [What it looks like](#what-it-looks-like)
- [Install](#install)
- [What is covered](#what-is-covered)
- [Rubylode plugins](#rubylode-plugins)
- [Customising](#customising)
- [Fonts](#fonts)
- [Dark mode](#dark-mode)
- [Accessibility](#accessibility)
- [Compatibility](#compatibility)
- [Development](#development)
- [Checks and releases](#checks-and-releases)
- [License](#license)

## What it looks like

- A white page with warm grey lines and stripes, and one accent: coral for links, the main buttons, focus and the selected tab. Hovered rows take a pale coral tint.
- A full-height dark sidebar, 224px wide, on the left, in light mode as well as dark. It holds the project name behind a coral tile and the project menu, with the selected item on a lighter tint. On the administration pages it holds the administration menu. A thin white bar across the top holds the global links, the New issue button, the search and project switcher and your avatar.
- The issue list reads as a to-do list: a round check before each subject, filled and ticked when the issue is closed, a chip round the tracker, round initials for the assignee in one of six colours (the name stays in the tooltip), and groups as plain sections with a count. Status and priority are the shared base's chips.
- Above the issue list, the Gantt chart, the calendar and the activity page, a row of underlined tabs moves between Issues, Gantt, Calendar and Activity.
- Cards, fields and buttons have round corners (8px for controls, 14px for cards), and the page has almost no shadow. Rows are a little looser than in the other Rubylode themes.

## Install

1. Download the zip attached to the latest release (the Releases page of this repository) and unzip it inside the `themes` folder of your Redmine, so that `themes/morganite/stylesheets/application.css` exists. Or clone this repository and copy (or link) its `morganite` folder into `themes/`.
2. Restart Redmine.
3. In Administration, Settings, Display, choose **Morganite** as the theme and save.

To go back, choose another theme on the same page. Nothing is written to the database apart from that setting.

The theme folder holds the stylesheets, `javascripts/theme.js`, the fonts (see [Fonts](#fonts)) and the mark (`images/morganite-mark.svg`).

## What is covered

The page check loads these pages, in light and dark, at desktop and phone width: sign in, the home page, the project overview (Redmine's own and the Rubylode Projects plugin's), the projects list, the issue list (plain and grouped), activity, the roadmap, an issue, an issue with subtasks, a child issue, the edit and new issue forms, the to-do page, the Stats page, the pages of the four status plugins, My page (Redmine's own and the Rubylode Home plugin's), a wiki page and its editor, spent time, Gantt, the calendar, project settings and administration. Flash messages, tabs, the right-click menu, dropdowns, pagination, the text editor and the phone slide-out menu are styled as well.

<!-- rubylode-plugins:start -->
## Rubylode plugins

Rubylode Morganite styles the Rubylode plugins' blocks natively. Each plugin draws with its own CSS custom properties, and one section of the
theme, `morganite/stylesheets/plugins.css`, points them at Rubylode Morganite's tokens, so the blocks follow the theme in light and dark:

- [Rubylode Projects](https://github.com/rubylode/redmine-rubylode-projects) (`--rubylode-projects-*`): the overview cards and the projects list.
- [Rubylode Home](https://github.com/rubylode/redmine-rubylode-home) (`--rubylode-home-*`): My page and the welcome page.
- [Rubylode To-do](https://github.com/rubylode/redmine-rubylode-todo) (`--todo-*`): the to-do page.
- [Rubylode Uptime Kuma](https://github.com/rubylode/redmine-rubylode-uptime-kuma) (`--rubylode-uptime-kuma-*`),
  [Rubylode GlitchTip](https://github.com/rubylode/redmine-rubylode-glitchtip) (`--rubylode-glitchtip-*`),
  [Rubylode Windmill](https://github.com/rubylode/redmine-rubylode-windmill) (`--rubylode-windmill-*`) and
  [Rubylode Beszel](https://github.com/rubylode/redmine-rubylode-beszel) (`--rubylode-beszel-*`): the status blocks.
- [Rubylode Stats](https://github.com/rubylode/redmine-rubylode-stats) (`--stats-tooltip-*`): the chart tooltip.
- [Rubylode New issue button](https://github.com/rubylode/redmine-rubylode-new-issue-button): a rounded primary button beside the search.
  Plugins load their stylesheets after the theme's, so these rules start with `body #header` to win whatever the order.

None of them is needed. Without a plugin its rules match nothing.
<!-- rubylode-plugins:end -->

## Customising

Every colour, corner, shadow, font and a few sizes are custom properties in `morganite/stylesheets/tokens.css` (light values) and `morganite/stylesheets/dark.css` (dark values). Change them there, or override them from a stylesheet of your own. The names start with `--theme-` and are the same in every Rubylode theme. The main ones:

| Token | What it is |
|---|---|
| `--theme-page`, `--theme-surface`, `--theme-surface-sunken`, `--theme-surface-hover` | the page, the panels, sunken panels and stripes, hovered rows |
| `--theme-line`, `--theme-line-soft`, `--theme-line-strong` | panel borders and row lines, column lines, field borders |
| `--theme-ink`, `--theme-ink-soft`, `--theme-ink-muted` | text, secondary text, labels and notes |
| `--theme-accent-0` to `--theme-accent-9` | the coral ramp; Redmine's blue ramp points into it. `--theme-link` and `--theme-primary` are step 6 |
| `--theme-sidebar-background`, `--theme-sidebar-ink`, `--theme-sidebar-selected-background` | the dark sidebar, its text and its selected item |
| `--theme-status-new`, `-in-progress`, `-resolved`, `-feedback`, `-closed`, `-rejected` | status colours, by Redmine's default status ids 1 to 6 |
| `--theme-radius-small`, `--theme-radius`, `--theme-radius-panel`, `--theme-radius-pill` | corners of fields, cards, panels and chips |
| `--theme-border-width`, `--theme-border-style`, `--theme-density` | panel borders, and the height of table rows and list items |
| `--theme-font-size` | the size of running text (16px); every other text size follows it |
| `--theme-font`, `--theme-font-monospace`, `--theme-title-font`, `--theme-title-weight` | the text, code and heading fonts |

The rest (messages, avatars, diffs, the Gantt chart, the header heights, the icons drawn in the stylesheet) are listed with a comment each in `tokens.css`. If you used the old `--morganite-*` names, the rename table is in the changelog.

Morganite's own touches that tokens cannot express (the dark sidebar text, the round checks, the chips, the initials and the view tabs) are in `morganite/stylesheets/flourishes.css`, loaded last. The sidebar is `morganite/stylesheets/sidebar-layout.css`, set by the `--theme-sidebar-*` tokens. The colours of the script's additions are `--theme-initials-0` to `-5`, `--theme-tracker-chip-background` and `-ink`, and `--theme-check-border`.

### Widths

The sidebar needs room, so it falls back as the window narrows:

- 1100px and wider: the sidebar and the thin top bar described above.
- From 900px to 1099px: two rows across the top. The first holds the mark, the global links, the New issue button, the search and the person menu. The second holds the project name and its tabs, which scroll behind two buttons when they do not fit.
- Below 900px: Redmine's own phone layout, with the menus sliding in from the right on the same dark colour as the sidebar, and the New issue button in the page.
- The sign-in page keeps the two rows at every width.

The initials, the chips and the tabs stay at every width.

Status and priority colours are matched by Redmine's default ids (statuses 1 New to 6 Rejected, priorities 1 Low to 5 Immediate). If yours differ, change the ids in the issue list sections of `morganite/stylesheets/structure.css`.

## Fonts

Morganite ships its own fonts, so text looks the same on every system and nothing is loaded from another site: Noto Sans for text and Noto Sans Mono for code, as woff2 files in `morganite/fonts/` (latin and latin-ext). Both are under the SIL Open Font License 1.1; the licence texts are in the same folder. A browser downloads a file only when a page uses it. To use other fonts, change `--theme-font` and `--theme-font-monospace` in `morganite/stylesheets/tokens.css`. The size of running text is `--theme-font-size` (16px), and every other text size follows it.

## Dark mode

Dark mode follows your system setting (`prefers-color-scheme`): a warm near-black page, panels a step lighter than the page, light ink and the coral lifted so links read on dark. The sidebar is dark in both modes and a step darker still in dark. Code blocks stay light, since Redmine's syntax colours are made for a light background. To keep Morganite light-only, remove the line `@import url(dark.css);` from `morganite/stylesheets/responsive.css`; every dark value is in that one file.

## Accessibility

Text and controls meet WCAG AA in both modes. The page check measures every visible text against the colour behind it on every page; the tokens were also measured one by one, including the parts the check cannot see (field borders, focus rings, chips on a hovered row). The measured ratios are in [docs/accessibility.md](docs/accessibility.md). In short: body text 15.3:1 or more in light and 15.7:1 in dark, secondary text at least 5.5:1 and 6.5:1, links at least 4.9:1 and 6.5:1, white on the primary at least 5.3:1, every status and priority chip at least 5.4:1, field borders at least 3.6:1 and focus rings at least 3.9:1.

## Compatibility

Redmine 7.0 and newer. Tested on 7.0.2, from both the `7.0.2` and the `7.0` image tags (on 2026-11-02 the 7.0 line was at 7.0.2). Older versions are not expected to work: Redmine 7 reads a theme from `themes/<name>` and is built on the Open Color variables this theme remaps.

Browsers: current Chrome, Edge, Firefox and Safari. The theme uses `:has()` and `color-mix()` (Chrome 111, Firefox 121, Safari 16.4 and newer); an older browser shows plainer status chips and keeps the rest.

## Development

You need Docker, Ruby, Node and Chrome.

```
npm install
ruby bin/demo up        # a throwaway Redmine with demo data at http://localhost:3101 (admin / admin)
npm run check           # loads every page in light and dark, at desktop and phone width
npm run screenshots     # docs/screenshots
npm run record          # docs/demo, a GIF of a walk through the pages
ruby bin/demo reset     # wipe the demo
```

If copies of the Rubylode plugins listed above sit next to this repository (`../redmine-rubylode-todo` and so on, or in a folder named in `RUBYLODE_PLUGINS_DIR`), the demo mounts them and the check, screenshots and recording show their pages. The demo points the status plugins at an address where nothing answers, so their pages show the "unavailable" state. Without the plugins the demo is plain Redmine, and the check skips their pages.

The stylesheets (except `flourishes.css`), `javascripts/theme.js`, `test/`, `bin/demo` and `docker-compose.yml` are generated from the base all Rubylode themes share, so a fix there reaches every theme. If you send a change to one of them, I will carry it over to the base.

The check fails on console errors, failed requests, sideways scrolling and text below WCAG AA contrast. `REDMINE_TAG=7.0 ruby bin/demo up` runs it against another Redmine version. After you change a stylesheet, run `ruby bin/demo restart` and reload: Redmine caches theme files until it restarts.

## Checks and releases

Every push starts a real Redmine from its Docker image (7.0.2 and the 7.0 line), loads every page of the theme in light and dark at desktop and phone width, and fails on console errors, failed requests, sideways scrolling and low text contrast. On GitHub that is `.github/workflows/check.yml`, on GitHub's own runners, and it also runs on pull requests. On a self-hosted Gitea it is `.gitea/workflows/check.yml`, which runs only on pushes to `main`, because that runner works on the host with Docker access and must only run code that is already merged.

A tag such as `v2.0.0` runs the same check, builds `morganite-<version>.zip` holding the theme folder, and attaches it to a release with the matching section of `CHANGELOG.md` as its notes (`release.yml` in the same folders). The tag needs a section for that version in the changelog. More on both, and on the drift check that compares the generated files with the shared base, in [docs/ci.md](docs/ci.md).

## License

GPL version 2 or later, the same as Redmine. See `LICENSE`. Copyright (C) 2026  Nick Gorbikoff.

No warranty, as the GPL says. Try it on a copy of your tracker before the real one.
