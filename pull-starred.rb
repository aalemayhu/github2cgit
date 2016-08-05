require 'httparty'

write_path = ENV['STARRED_GITHUB_REPOSITORIES'] || "/etc/starred_repositories"
user = ENV['GITHUB_USER'] || "scanf"
starred_file = File.open(write_path, 'w')

starred_repositories = HTTParty.get("https://api.github.com/users/#{user}/starred")
starred_repositories.each  do |repo| 
  name = repo["name"]
  description = repo["description"]
  git_url = repo["git_url"]
  local_path = "/tmp/#{name}.git" # is this right?
  if File.directory?(local_path)
    `cd #{local_path} && git pull --quiet --all`
  else
    `git clone --quiet #{git_url} #{local_path}`
  end
  starred_file("repo.url=#{name}")
  starred_file("repo.path=#{local_path}")
  starred_file("repo.desc=#{description}")
  starred_file("")
end

starred_file.close unless starred_file.nil?
