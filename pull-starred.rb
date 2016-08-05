require 'httparty'

write_path = ENV['STARRED_GITHUB_REPOSITORIES'] || "/etc/starred_repositories"
user = ENV['GITHUB_USER'] || "scanf"
local_git_directory = ENV['GIT_REPO_DIRECTORY'] || "/tmp"
starred_file = File.open(write_path, 'w')

starred_repositories = HTTParty.get("https://api.github.com/users/#{user}/starred")
starred_repositories.each  do |repo| 
  name = repo["name"]
  description = repo["description"]
  git_url = repo["git_url"]
  local_path = "#{local_git_directory}/#{name}.git" # is this right?
  if File.directory?(local_path)
    `cd #{local_path} && git pull --quiet --all &`
  else
    `git clone --quiet #{git_url} #{local_path} &`
  end
  starred_file.write("repo.url=#{name}\n")
  starred_file.write("repo.path=#{local_path}\n")
  starred_file.write("repo.desc=#{description}\n")
end

starred_file.close unless starred_file.nil?
