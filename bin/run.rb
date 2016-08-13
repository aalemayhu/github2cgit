#!/usr/bin/ruby

require_relative "../src/app.rb"

user = ENV['GITHUB_USER'] || "scanf"
local_git_directory = ENV['CGIT_REPO_DIRECTORY'] || "/tmp"
cgit_repositories_rcpath = ENV['CGIT_REPOSITORIES_FILE'] || "/etc/github_repositories"

app = App.new(user, local_git_directory, cgit_repositories_rcpath)
app.run()