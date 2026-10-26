# Changelog

All notable changes to this theme. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.0.0] - 2026-10-26

### Added

- Morganite: warm neutrals and a coral accent on a white page, in the Open Color variables Redmine 7 is built on.
- On screens 1100px and wider, all navigation moves into a dark left sidebar, in plain CSS: the title, search and project jump, the general links, the project menu (or the administration menu) and, at the bottom, the profile. The white top bar is gone. Narrower screens and the login page keep Redmine's own layout.
- The issue list reads as a to-do list: a round check before each subject (filled and ticked when the issue is closed), plain sections instead of grouped table headers, a chip around the tracker, round initials for the assignee, and Issues, Gantt, Calendar and Activity as underline tabs above the list. The last three come from one small script, `javascripts/theme.js`, which only reads the page.
- Activity is a quiet feed: a small date label, then rows with hairlines.
- Striped rows and thin column lines in tables, a quiet card for the issue, rounded fields and buttons, a login card, wiki headings and tables.
- A dark set for the system dark setting, in one block at the end of the stylesheet.
- Tested on Redmine 7.0.2 and the 7.0 line, in light and dark, at desktop and phone width: no console errors, no failed requests, no sideways scrolling, and text at AA contrast on the pages that matter, including the wiki, the activity page and the Rubylode to-do page.
