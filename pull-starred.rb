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
local_git_directory = ENV['GIT_REPO_DIRECTORY'] || "/tmp"
starred_path = ENV['STARRED_GITHUB_REPOSITORIES'] || "/etc/starred_repositories"

starred_config = Configuration.new(user, "starred", starred_path, local_git_directory)

pull_repositories_with(starred_config)
