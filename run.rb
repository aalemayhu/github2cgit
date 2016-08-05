require 'httparty'
require 'fileutils'
require_relative 'cgit_format.rb'
require_relative 'configuration.rb'

def pull_repositories_with(config)
  tmp_path = "#{config.file_path}.tmp"
  file = File.open(tmp_path, 'w')
  repositories = HTTParty.get(config.url())
  write_cgit_format_to(file, repositories, config.directory)
  file.close unless file.nil?
  FileUtils.mv(tmp_path, config.file_path)
end

user = ENV['GITHUB_USER'] || "scanf"
local_git_directory = ENV['CGIT_REPO_DIRECTORY'] || "/tmp"
cgit_repositories_rcpath = ENV['CGIT_REPOSITORIES_FILE'] || "/etc/github_repositories"

configs = [Configuration.new(user, "starred", cgit_repositories_rcpath, local_git_directory),
           Configuration.new(user, "repos", cgit_repositories_rcpath, local_git_directory)]

configs.each do |config|
  pull_repositories_with(config)
end
