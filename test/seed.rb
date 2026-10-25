# frozen_string_literal: true

# Demo data for checking a theme and taking its screenshots. The people and the work are made up.
# Run by `ruby bin/demo up` through rails runner; running it twice changes nothing the second time.

Redmine::DefaultData::Loader.load("en") if Tracker.none?
Setting.default_language = "en"
Setting.text_formatting = "common_mark"
Setting.welcome_text = "Welcome to the demo tracker."
Setting.notified_events = [] # no mail from the demo

admin = User.find_by_login("admin")
admin.update_columns(must_change_passwd: false)
User.current = admin

if News.exists?(title: "1.1 is two weeks out") # the last thing this script creates
  puts "demo data already loaded"
  return
end
abort "The demo data is half loaded. Run: ruby bin/demo reset" if Project.exists?(identifier: "atlas")

today = Date.today
role = ->(name) { Role.find_by!(name: name) }

people = [
  ["ana", "Ana", "Reyes", "Manager"],
  ["ben", "Ben", "Okafor", "Developer"],
  ["chloe", "Chloe", "Lin", "Developer"],
  ["dmitri", "Dmitri", "Volkov", "Reporter"]
].to_h do |login, first, last, role_name|
  user = User.new(login: login, firstname: first, lastname: last, mail: "#{login}@example.com", language: "en")
  user.password = user.password_confirmation = "demo-password-1"
  user.save!
  [login, [user, role_name]]
end

make_project = lambda do |name, identifier, description, parent: nil|
  project = Project.new(name: name, identifier: identifier, description: description, is_public: true,
                        enabled_module_names: %w[issue_tracking time_tracking news documents files wiki gantt calendar])
  project.parent = parent if parent
  project.trackers = Tracker.all
  project.save!
  people.each_value { |user, role_name| Member.create!(project: project, principal: user, roles: [role.(role_name)]) }
  project
end

atlas = make_project.("Atlas", "atlas", "The mapping service: tiles, search and the public API.")
harbor = make_project.("Harbor", "harbor", "Deployment and hosting for Atlas.", parent: atlas)
make_project.("Lantern", "lantern", "The status page and alerting.")

versions = {
  "1.0" => Version.create!(project: atlas, name: "1.0", status: "open", effective_date: today - 30), # closed after its issues exist
  "1.1" => Version.create!(project: atlas, name: "1.1", status: "open", effective_date: today + 14, description: "Search and the new tile cache."),
  "2.0" => Version.create!(project: atlas, name: "2.0", status: "open", effective_date: today + 90, description: "Offline maps.")
}
categories = %w[Backend Frontend Infrastructure Docs].to_h { |name| [name, IssueCategory.create!(project: atlas, name: name)] }

user_for = ->(login) { login ? people.fetch(login).first : nil }
make_issue = lambda do |attributes|
  issue = Issue.new(project: attributes.fetch(:project, atlas), author: user_for.(attributes[:author]) || admin,
                    tracker: Tracker.find_by!(name: attributes.fetch(:tracker)),
                    status: IssueStatus.find_by!(name: attributes.fetch(:status, "New")),
                    priority: IssuePriority.find_by!(name: attributes.fetch(:priority, "Normal")),
                    subject: attributes.fetch(:subject), description: attributes[:description],
                    assigned_to: user_for.(attributes[:assignee]), category: categories[attributes[:category]],
                    fixed_version: versions[attributes[:version]], done_ratio: attributes.fetch(:done, 0),
                    estimated_hours: attributes[:estimate],
                    start_date: attributes[:start] && today + attributes[:start],
                    due_date: attributes[:due] && today + attributes[:due])
  issue.parent_issue_id = attributes[:parent].id if attributes[:parent]
  issue.save!
  issue
end

showcase_text = <<~MARKDOWN
  Tiles near the poles come back blank at zoom levels above 12. Seen in the web client and in the mobile apps, so it is the service and not the viewer.

  ## What happens

  1. Request a tile north of 85° at zoom 13 or higher.
  2. The service answers `200` with an empty body.
  3. The client caches the blank tile for a day.

  ## What I expect

  A tile with the polar cap drawn, or a `404` the client can handle.

  > The cache hides it on a second try, so test with a cold cache.

  | Zoom | Tile rows | Result |
  |------|-----------|--------|
  | 11   | 2048      | drawn  |
  | 12   | 4096      | drawn  |
  | 13   | 8192      | blank  |

  ```ruby
  def tile_for(latitude, longitude, zoom)
    row = ((1 - Math.log(Math.tan(latitude.to_f * Math::PI / 180) + 1 / Math.cos(latitude.to_f * Math::PI / 180)) / Math::PI) / 2 * 2**zoom).floor
    [row, ((longitude + 180) / 360 * 2**zoom).floor]
  end
  ```

  Checklist before closing:

  - [x] Reproduce on a cold cache
  - [ ] Fix the row calculation near the poles
  - [ ] Add a regression test
  - [ ] Purge the blank tiles from the cache

  See also the [tile format notes](https://example.com/tiles) and `config/tiles.yml`.
MARKDOWN

showcase = make_issue.(tracker: "Bug", status: "In Progress", priority: "Urgent", subject: "Tiles near the poles come back blank above zoom 12",
                       description: showcase_text, author: "dmitri", assignee: "ben", category: "Backend", version: "1.1", done: 40,
                       estimate: 12, start: -6, due: 3)

[
  ["ana", "Confirmed on staging and on production. Taking it as the 1.1 blocker.", { priority: IssuePriority.find_by!(name: "Urgent") }],
  ["ben", "The row calculation overflows at the poles; I have a fix, still adding the test.", { status: IssueStatus.find_by!(name: "In Progress"), done_ratio: 40 }],
  ["chloe", "The mobile apps cache the blank tile for a day, so they will show it until the cache expires.", {}],
  ["dmitri", "Cold cache reproduces it every time, a warm cache hides it.", {}]
].each do |login, notes, changes|
  User.current = user_for.(login)
  showcase.reload.init_journal(User.current, notes)
  changes.each { |key, value| showcase.public_send("#{key}=", value) }
  showcase.save!
end
User.current = admin

[
  { tracker: "Bug", status: "Resolved", priority: "High", subject: "Search returns places from the wrong country", assignee: "chloe", category: "Backend", version: "1.1", done: 100, estimate: 6, start: -20, due: -4 },
  { tracker: "Feature", status: "In Progress", priority: "High", subject: "A new tile cache with per-zoom expiry", assignee: "ben", category: "Backend", version: "1.1", done: 60, estimate: 40, start: -12, due: 9 },
  { tracker: "Feature", status: "New", priority: "Normal", subject: "Offline map packs for a chosen area", assignee: "chloe", category: "Frontend", version: "2.0", estimate: 80, start: 20, due: 80 },
  { tracker: "Feature", status: "Feedback", priority: "Normal", subject: "Dark map style", assignee: "chloe", category: "Frontend", version: "1.1", done: 80, estimate: 16, start: -9, due: 5 },
  { tracker: "Support", status: "New", priority: "Low", subject: "How do I embed a map in a page that blocks scripts?", assignee: nil, category: "Docs", version: nil, author: "dmitri" },
  { tracker: "Bug", status: "New", priority: "Normal", subject: "The scale bar shows miles when the unit is set to metres", assignee: nil, category: "Frontend", version: "1.1", author: "dmitri", due: -2 },
  { tracker: "Bug", status: "Closed", priority: "Normal", subject: "Attribution text overlaps the zoom buttons on small screens", assignee: "chloe", category: "Frontend", version: "1.0", done: 100, start: -50, due: -35 },
  { tracker: "Feature", status: "Closed", priority: "High", subject: "Public API keys with per-key rate limits", assignee: "ben", category: "Backend", version: "1.0", done: 100, estimate: 30, start: -70, due: -32 },
  { tracker: "Support", status: "Rejected", priority: "Low", subject: "Please add a satellite layer", assignee: "ana", category: nil, version: nil, author: "dmitri" },
  { tracker: "Feature", status: "New", priority: "Low", subject: "Export a route as a GPX file", assignee: nil, category: "Backend", version: "2.0", estimate: 10 },
  { tracker: "Bug", status: "In Progress", priority: "Immediate", subject: "The API returns 500 for an empty search string", assignee: "ben", category: "Backend", version: "1.1", done: 20, estimate: 3, start: -1, due: 0 },
  { tracker: "Support", status: "Resolved", priority: "Normal", subject: "Rate limit headers are missing from cached responses", assignee: "ben", category: "Docs", version: "1.1", done: 100, author: "chloe" }
].each { |attributes| make_issue.(attributes) }

roadmap = make_issue.(tracker: "Feature", status: "In Progress", priority: "High", subject: "Ship the 1.1 release", assignee: "ana", version: "1.1", done: 35, start: -14, due: 14)
[
  ["Write the release notes", "Docs", "ana", "New", 0],
  ["Update the API reference for the search changes", "Docs", "chloe", "In Progress", 50],
  ["Cut the release branch and tag", "Infrastructure", "ben", "New", 0],
  ["Run the load test against the new tile cache", "Infrastructure", "ben", "New", 0]
].each do |subject, category, assignee, status, done|
  make_issue.(tracker: "Feature", status: status, priority: "Normal", subject: subject, assignee: assignee, category: category, version: "1.1",
              done: done, parent: roadmap, start: -3, due: 10)
end

harbor_issues = [
  ["Move the tile servers to the new cluster", "In Progress", "High", "ben"],
  ["Rotate the database credentials", "New", "Normal", "ana"],
  ["Alert when disk use passes 80 percent", "New", "Normal", nil]
]
harbor_issues.each do |subject, status, priority, assignee|
  make_issue.(project: harbor, tracker: "Feature", status: status, priority: priority, subject: subject, assignee: assignee, due: 21)
end

versions.fetch("1.0").update!(status: "closed")

IssueRelation.create!(issue_from: showcase, issue_to: Issue.find_by!(subject: "Ship the 1.1 release"), relation_type: "blocks")

activity = TimeEntryActivity.first
[[showcase, "ben", 3.5, 1], [showcase, "ben", 2.0, 2], [showcase, "chloe", 1.25, 2]].each do |issue, login, hours, days_ago|
  TimeEntry.create!(project: issue.project, issue: issue, user: user_for.(login), spent_on: today - days_ago, hours: hours, activity: activity, comments: "Looking into the tile rows")
end

atlas.create_wiki!(start_page: "Home") unless atlas.wiki
home = WikiPage.new(wiki: atlas.wiki, title: "Home")
home.build_content(author: admin, text: <<~MARKDOWN)
  # Atlas

  Atlas serves map tiles, search and a public API to the web client and the mobile apps.

  ## Where things live

  | Part | What it does | Owner |
  |------|--------------|-------|
  | Tiles | Draws and caches map tiles | Ben |
  | Search | Finds places and addresses | Chloe |
  | API | Keys, limits and the public docs | Ana |

  ## Running it locally

  ```
  bin/setup
  bin/atlas serve --port 4000
  ```

  Then open `http://localhost:4000`. Questions go in the Support tracker.
MARKDOWN
home.save!

News.create!(project: atlas, author: user_for.("ana"), title: "1.1 is two weeks out", summary: "The tile cache and search are the last two items.",
             description: "Feature freeze is on Friday. After that only fixes go in, so move anything that is not ready to 2.0.")

puts "demo data loaded: #{Project.count} projects, #{Issue.count} issues"
