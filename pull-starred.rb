require 'httparty'
require 'fileutils'
require_relative 'cgit_format.rb'

def pull_starred_repositories_to(write_path, user, local_git_directory)
  tmp_path = "#{write_path}.tmp"
  starred_file = File.open(tmp_path, 'w')
  starred_repositories = HTTParty.get("https://api.github.com/users/#{user}/starred")
  write_cgit_format_to(starred_file, starred_repositories, local_git_directory)
  starred_file.close unless starred_file.nil?
  FileUtils.mv(tmp_path, write_path)
end

local_git_directory = ENV['GIT_REPO_DIRECTORY'] || "/tmp"
user = ENV['GITHUB_USER'] || "scanf"
starred_path = ENV['STARRED_GITHUB_REPOSITORIES'] || "/etc/starred_repositories"
pull_starred_repositories_to(starred_path, user, local_git_directory)
