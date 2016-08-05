require 'httparty'

starred_repositories = HTTParty.get("https://api.github.com/users/scanf/starred")
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
  puts "repo.url=#{name}"
  puts "repo.path=#{local_path}"
  puts "repo.desc=#{description}"
  puts ""
end
