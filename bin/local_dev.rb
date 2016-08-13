#!/usr/bin/ruby

require_relative "../src/app.rb"

local_git_directory = "/tmp/cgit"
cgit_repositories_rcpath = "/tmp/cgit/github_repositories"

`mkdir -p #{local_git_directory}`
`touch #{cgit_repositories_rcpath}`

app = App.new("scanf", local_git_directory, cgit_repositories_rcpath)
app.run()