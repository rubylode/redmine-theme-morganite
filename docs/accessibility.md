# Contrast

Morganite is warm neutrals with one coral accent, and a sidebar that is dark in both modes. It aims at WCAG 2.2 AA in light and dark: 4.5:1 for text (3:1 for large text) and 3:1 for the parts of a control that identify it (field borders) and for focus indicators.

## How it is measured

- The page check (`npm run check`) loads 29 pages in light and dark, at 1280px and 390px wide, and measures every visible piece of text against the colour stacked behind it. On 2026-11-02 against Redmine 7.0.2 with the Rubylode plugins mounted it measured 2,796 text pairs per run at desktop width and 3,336 at phone width, in light and in dark, and found none below AA: 116 of 116 gated runs clean. At the 16px base size every measured pair also reaches 4.5:1, so none relies on the 3:1 allowance for large text.
- The tokens, one pair at a time, below. Field borders and focus rings are not text, so the check does not see them, and it skips text over a gradient or an image. Chip colours are the mixes the stylesheet makes (`color-mix`), worked out on each of the three row colours a chip can sit on (panel, stripe, hovered row); the lowest is shown.
- The sidebar is painted by a gradient on the page wrapper, which the check skips, so its text pairs are measured here from the token values. The selected and hovered items are white on a translucent white tint over the sidebar colour.
- The ratios are worked out from the token values in `tokens.css` and `dark.css` with the WCAG relative luminance formula.

## Light

| Pair | Foreground | Background | Ratio |
|---|---|---|---|
| Body text on the page | `#231f1d` | `#ffffff` | 16.34 |
| Body text on a sunken panel or stripe | `#231f1d` | `#f9f7f5` | 15.29 |
| Secondary text on the page | `#6b635f` | `#ffffff` | 5.87 |
| Secondary text on a panel | `#6b635f` | `#ffffff` | 5.87 |
| Secondary text on a sunken panel or stripe | `#6b635f` | `#f9f7f5` | 5.50 |
| Secondary text on a hovered row | `#6b635f` | `#fff5f4` | 5.49 |
| Link on a panel | `#c23a43` | `#ffffff` | 5.28 |
| Link on a sunken panel or stripe | `#c23a43` | `#f9f7f5` | 4.94 |
| Link on a hovered row | `#c23a43` | `#fff5f4` | 4.93 |
| Link, hovered, on a panel | `#a42c36` | `#ffffff` | 7.02 |
| White on the primary | `#ffffff` | `#c23a43` | 5.28 |
| White on the primary, hovered | `#ffffff` | `#a42c36` | 7.02 |
| Button text | `#3a3532` | `#ffffff` | 12.10 |
| Delete button text | `#9b1c28` | `#fdecea` | 7.09 |
| Header links | `#3a3532` | `#ffffff` | 12.10 |
| Search field text | `#231f1d` | `#fcfbfa` | 15.81 |
| Sidebar text on the sidebar | `#d8d1cd` | `#1f1b1a` | 11.32 |
| Sidebar selected item (white on a 14% white tint) | `#ffffff` | `#3e3b3a` | 11.10 |
| Sidebar hovered item | `#ffffff` | `#312d2c` | 13.62 |
| Tracker chip | `#9c2b34` | `#fff5f4` | 6.99 |
| Initials on the lightest of their colours (`#15803d`) | `#ffffff` | `#15803d` | 5.02 |
| Initials on `#0b7a75` | `#ffffff` | `#0b7a75` | 5.18 |
| Priority Immediate, white on red | `#ffffff` | `#a8323b` | 6.59 |
| Chip New (lowest, on a hovered row or stripe) | `#194365` | `#e1e2e9` | 8.00 |
| Chip In Progress (lowest, on a hovered row or stripe) | `#825311` | `#fae6d6` | 5.43 |
| Chip Resolved (lowest, on a hovered row or stripe) | `#135e53` | `#daeae6` | 6.13 |
| Chip Feedback (lowest, on a hovered row or stripe) | `#55376d` | `#efdfeb` | 7.63 |
| Chip Closed (lowest, on a hovered row or stripe) | `#1c532f` | `#e2e6dd` | 7.13 |
| Chip Rejected (lowest, on a hovered row or stripe) | `#534d4a` | `#e9e6e4` | 6.69 |
| Chip High (priority) (lowest, on a hovered row or stripe) | `#825311` | `#fae6d6` | 5.43 |
| Chip Urgent (priority) (lowest, on a hovered row or stripe) | `#802925` | `#f9dcda` | 7.20 |
| Code block (kept light) | `#231f1d` | `#f6f3f1` | 14.79 |
| Field border on a panel (control) | `#8a817c` | `#ffffff` | 3.81 |
| Field border on the page (control) | `#8a817c` | `#ffffff` | 3.81 |
| Header field border (control) | `#8a817c` | `#fcfbfa` | 3.69 |
| Focus ring on a panel | `#dc4f55` | `#ffffff` | 3.97 |

## Dark

| Pair | Foreground | Background | Ratio |
|---|---|---|---|
| Body text on the page | `#f6f1f1` | `#181314` | 16.44 |
| Body text on a panel | `#f6f1f1` | `#1d1819` | 15.68 |
| Secondary text on the page | `#b8abae` | `#181314` | 8.30 |
| Secondary text on a panel | `#b8abae` | `#1d1819` | 7.92 |
| Secondary text on a sunken panel or stripe | `#b8abae` | `#231d1f` | 7.48 |
| Secondary text on a hovered row | `#b8abae` | `#3a2326` | 6.54 |
| Link on a panel | `#fb8f8a` | `#1d1819` | 7.85 |
| Link on a sunken panel or stripe | `#fb8f8a` | `#231d1f` | 7.42 |
| Link on a hovered row | `#fb8f8a` | `#3a2326` | 6.49 |
| White on the primary | `#ffffff` | `#c23a43` | 5.28 |
| White on the primary, hovered | `#ffffff` | `#a42c36` | 7.02 |
| Button text | `#e2dadb` | `#2a2325` | 11.19 |
| Delete button text | `#f2a7ae` | `#35202a` | 7.84 |
| Header links | `#e2dadb` | `#1d1819` | 12.77 |
| Search field text | `#f6f1f1` | `#231d1f` | 14.82 |
| Sidebar text on the sidebar | `#d8d1cd` | `#130f10` | 12.62 |
| Sidebar selected item (white on a 14% white tint) | `#ffffff` | `#343131` | 12.89 |
| Tracker chip | `#ffb0ab` | `#4a2a2d` | 7.26 |
| Priority Immediate, white on red | `#ffffff` | `#a8323b` | 6.59 |
| Chip New (lowest, on a hovered row or stripe) | `#a4cbe8` | `#403a46` | 6.43 |
| Chip In Progress (lowest, on a hovered row or stripe) | `#eabf82` | `#573624` | 6.27 |
| Chip Resolved (lowest, on a hovered row or stripe) | `#84c9bf` | `#353938` | 6.18 |
| Chip Feedback (lowest, on a hovered row or stripe) | `#c1a5d6` | `#492d40` | 5.55 |
| Chip Closed (lowest, on a hovered row or stripe) | `#8dbf9e` | `#38362d` | 5.81 |
| Chip Rejected (lowest, on a hovered row or stripe) | `#cfc7c9` | `#4e383b` | 6.49 |
| Chip High (priority) (lowest, on a hovered row or stripe) | `#eabf82` | `#573624` | 6.27 |
| Chip Urgent (priority) (lowest, on a hovered row or stripe) | `#e89994` | `#56292a` | 5.39 |
| Code block (kept light) | `#231f1d` | `#f6f3f1` | 14.79 |
| Field border on a panel (control) | `#918386` | `#1d1819` | 4.84 |
| Field border on the page (control) | `#918386` | `#181314` | 5.07 |
| Header field border (control) | `#918386` | `#231d1f` | 4.57 |
| Focus ring on a panel | `#fb8f8a` | `#1d1819` | 7.85 |
| Focus ring on the page | `#fb8f8a` | `#181314` | 8.23 |

## Not covered

- Redmine's own avatar colours with white initials: the three that fall below 4.5:1 (red, orange, pink) are darkened; the rest are Redmine's.
- Syntax highlighting inside code blocks is Redmine's, made for a light background, which is why code blocks stay light in dark mode.
- The initials beside an assignee repeat the name, which stays in the page for screen readers, so the initials are hidden from them.
- Colour is never the only signal: status and priority carry their name in the issue list, and the priority chip its bar count on the issue page.
