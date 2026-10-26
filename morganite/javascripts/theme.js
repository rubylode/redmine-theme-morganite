/* Morganite, a theme for Redmine 7
 * Copyright (C) 2026  Nick Gorbikoff
 * GNU General Public License, version 2 or later. See the LICENSE file.
 *
 * A small script that adds three things CSS cannot: initials next to assignees, a chip around the tracker name, and a row
 * of view tabs. It reads the page and writes nothing to Redmine. Without it the theme still works. */
(function () {
  "use strict";

  function addInitials() {
    document.querySelectorAll("table.list td.assigned_to").forEach(function (cell) {
      var link = cell.querySelector("a");
      if (!link || cell.querySelector(".assignee-initials")) { return; }
      var words = link.textContent.trim().split(/\s+/);
      var initials = (words[0][0] + (words.length > 1 ? words[words.length - 1][0] : "")).toUpperCase();
      var sum = 0;
      for (var index = 0; index < initials.length; index++) { sum += initials.charCodeAt(index); }
      var badge = document.createElement("span");
      badge.className = "assignee-initials tone-" + (sum % 6);
      badge.setAttribute("aria-hidden", "true");
      badge.textContent = initials;
      badge.title = link.textContent.trim();
      link.classList.add("assignee-name");
      cell.insertBefore(badge, cell.firstChild);
    });
  }

  function addTrackerChips() {
    document.querySelectorAll("table.list td.tracker").forEach(function (cell) {
      var text = cell.textContent.trim();
      if (!text || cell.querySelector(".tracker-chip")) { return; }
      var chip = document.createElement("span");
      chip.className = "tracker-chip";
      chip.textContent = text;
      cell.textContent = "";
      cell.appendChild(chip);
    });
  }

  function addViewTabs() {
    var onViewPage = document.body.matches(".controller-issues.action-index, .controller-gantts, .controller-calendars, .controller-activities");
    var title = document.querySelector("#content > h2");
    if (!onViewPage || !title || document.querySelector("nav.view-tabs")) { return; }
    var links = ["issues", "gantt", "calendar", "activity"].map(function (name) {
      return document.querySelector("#main-menu a." + name);
    }).filter(Boolean);
    if (links.length < 2) { return; }
    var nav = document.createElement("nav");
    nav.className = "view-tabs";
    links.forEach(function (source) {
      var tab = document.createElement("a");
      tab.href = source.getAttribute("href");
      tab.textContent = source.textContent.trim();
      if (source.pathname === window.location.pathname) { tab.className = "selected"; }
      nav.appendChild(tab);
    });
    title.insertAdjacentElement("afterend", nav);
  }

  function run() {
    addInitials();
    addTrackerChips();
    addViewTabs();
  }

  if (document.readyState === "loading") { document.addEventListener("DOMContentLoaded", run); } else { run(); }
})();
