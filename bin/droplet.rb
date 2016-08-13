#!/usr/bin/ruby

require_relative "../src/app.rb"

local_git_directory = "/srv/git"
cgit_repositories_rcpath = "/etc/github_repositories"

`mkdir -p #{local_git_directory}`
`touch #{cgit_repositories_rcpath}`

app = App.new("scanf", local_git_directory, cgit_repositories_rcpath)
app.run()

`sudo chown www-data:www-data #{cgit_repositories_rcpath}`
`sudo chown -R www-data:www-data #{local_git_directory}`
