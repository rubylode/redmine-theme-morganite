# Morganite for Redmine

Peach and coral on white, with airy list rows and soft shadows.

A theme for Redmine 7 and up. Light and dark, following your system setting. It is CSS and a small script, with no plugin and
no change to Redmine itself.

<!-- Screenshots and the recording go here once the theme is built:
![The issue list](docs/screenshots/issues-light.png)
![A walk through the theme](docs/demo/walkthrough-light.gif) -->

## Contents

- [Install](#install)
- [What is covered](#what-is-covered)
- [Compatibility](#compatibility)
- [Development](#development)
- [License](#license)
- [Disclaimer](#disclaimer)

## Install

1. Copy the `morganite` folder from this repository into the `themes` folder of your Redmine.
2. Restart Redmine.
3. In Administration, Settings, Display, choose **Morganite** as the theme and save.

To go back, choose another theme on the same page. Nothing is written to the database apart from that setting.

## What is covered

The header and menus, the sidebar, the issue list, the issue page with its history, the new and edit forms, buttons, flash
messages, tables, tabs, the context menu and the login page, in light and dark. Other pages (Gantt, calendar, wiki, administration)
take their colours from the same variables and are fixed up as problems turn up.

## Compatibility

Redmine 7.0 and newer. Tested on 7.0.2 and the 7.0 line. Older versions are not expected to work.

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

The check fails on console errors, failed requests, sideways scrolling and text below WCAG AA contrast. `REDMINE_TAG=7.0 ruby bin/demo up`
runs it against another Redmine version.

## License

GPL version 2 or later, the same as Redmine. See `LICENSE`. Copyright (C) 2026  Nick Gorbikoff.

## Disclaimer

Use at your own risk. This software is provided as is, without warranty of any kind, express or implied. The author is not
liable for any damage, data loss or downtime that comes from using it. Try it on a copy of your tracker before you use it on the
real one.
