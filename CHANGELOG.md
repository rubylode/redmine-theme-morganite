# Changelog

All notable changes to this theme. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [2.1.0] - 2026-11-05

No change to how the theme looks. This release carries the build.

### Changed

- The workflows use the current versions of the GitHub actions, and Dependabot sends one grouped update a month instead of one pull request per action.

## [2.0.3] - 2026-11-03

### Changed

- The theme now has a Rubylode thumbnail, shown at the top of the README. The theme itself is unchanged.

## [2.0.2] - 2026-11-03

### Changed

- The chart colours are now a muted editorial set.

## [2.0.1] - 2026-11-02

### Added

- The theme defines the chart colour tokens the Stats plugin reads.

## [2.0.0] - 2026-11-02

### Changed

- Morganite is built on the shared Rubylode theme base. The stylesheets, `javascripts/theme.js`, `test/`, `bin/demo` and `docker-compose.yml` are generated from it, and `application.css` is now a short file that imports the others.
- The pages and parts the 1.0.0 stylesheet did not cover are styled: the roadmap, Gantt, calendar, wiki editor, spent time, My page, project settings, the phone slide-out menu and the rest of the shared page list, in light and dark.
- The Rubylode plugins are styled natively: Home, Projects, Stats, To-do, the New issue button, Uptime Kuma, Beszel, GlitchTip and Windmill.
- The text font is the bundled Noto Sans and the code font the bundled Noto Sans Mono, with the woff2 files and their SIL Open Font License 1.1 texts in `morganite/fonts/`. The 1.0.0 stack that started with Inter is dropped.
- The base text size is 16px, set by `--theme-font-size`. List text is 14px, up from about 11px, and fields and buttons are 15px.
- Dark is a full set of tokens in `dark.css`, no longer a block at the end of one stylesheet, and the dark page is a step darker than the panels.
- The sidebar keeps the dark left menu, but the global links, the search, the project switcher and the profile moved to a thin bar across the top, where they were all in the sidebar in 1.0.0. The sidebar holds the project name and its menu.
- The mark is a coral gem (`images/morganite-mark.svg`), shown in the top bar and above the sign-in form. 1.0.0 had none.
- Links, the main buttons and the selected tab use coral `#c23a43`, the same as before. The hover colour is `#a42c36`, and the lighter ramp steps moved down one step so that step 6 reaches 4.5:1 with white text.
- Field borders are `#8a817c`, up from `#e3ded9`, so they reach 3:1 against the page. Cards have 14px corners and fields and buttons 8px, as before.
- Status chips, priority chips with a bar meter and the issue card edge come from the base. Status New is blue, In Progress amber, Resolved teal, Feedback plum, Closed green and Rejected grey.
- Hovered rows are a coral tint as before, and the stripes are warm grey.
- Contrast was measured in both modes: every text pair is 4.5:1 or more. See `docs/accessibility.md`.
- Tested on Redmine 7.0.2 and the 7.0 line with every Rubylode plugin mounted: 116 of 116 gated page runs clean (29 pages, light and dark, desktop and phone width).

### Kept from 1.0.0

- The round check before each subject in the issue list, filled and ticked when the issue is closed, now shown on top-level rows only.
- The chip round the tracker, the round initials beside assignees and the Issues, Gantt, Calendar and Activity tabs, from `javascripts/theme.js`.
- Groups as plain sections, a muted closed subject and an overdue date in the danger colour.
- The to-do list look of the issue list, the soft stripes, the card for the issue, the login card and the feed look of the activity page.

### Not kept

- The check before a subject is not drawn on child rows of a list, where the base already draws its own arrow.

### Token meaning changes

Custom overrides need the new names. The `--morganite-*` names and Redmine's Open Color variables are no longer set by hand; the base sets the latter from the `--theme-*` tokens.

| 1.0.0 | 2.0.0 |
|---|---|
| `--morganite-coral-0` to `--morganite-coral-9` | `--theme-accent-0` to `--theme-accent-9` (the steps 5 to 7 are one step darker) |
| `--morganite-page` | `--theme-page` |
| `--morganite-rail` | `--theme-sidebar-background` |
| `--morganite-rail-ink` | `--theme-sidebar-ink` |
| `--morganite-rail-width` | `--theme-sidebar-width` |
| `--morganite-radius` | `--theme-radius` |
| `--fonts-main` | `--theme-font` |
| `--oc-gray-0` to `--oc-gray-9` | `--theme-neutral-0` to `--theme-neutral-9` |
| `--oc-blue-*`, `--oc-indigo-*` | `--theme-accent-*` and `--theme-link` |

## [1.0.0] - 2026-10-26

### Added

- Morganite theme: warm neutrals and a coral accent on a white page. The colours come from the Open Color variables Redmine 7 uses.
- On screens 1100px and wider, all navigation moves into a dark left sidebar, in plain CSS: the title, search and project jump, the general links, the project menu (or the administration menu) and, at the bottom, the profile. The white top bar is gone. Narrower screens and the login page keep Redmine's own layout.
- The issue list reads as a to-do list: a round check before each subject (filled and ticked when the issue is closed), plain sections instead of grouped table headers, a chip around the tracker, round initials for the assignee and underline tabs for Issues, Gantt, Calendar and Activity. The chip, the initials and the tabs come from `javascripts/theme.js`, which only reads the page.
- Activity is a feed with a small date label and hairline rows.
- Striped rows and thin column lines in tables, a card for the issue, rounded fields and buttons, a login card, styled wiki headings and tables.
- A dark set for the system dark setting, in one block at the end of the stylesheet.
- Tested on Redmine 7.0.2 and the 7.0 line, in light and dark, at desktop and phone width. No console errors, failed requests or sideways scrolling, and text at AA contrast on the pages that matter: the wiki, the activity page and the Rubylode to-do page.
