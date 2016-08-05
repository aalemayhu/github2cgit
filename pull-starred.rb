require 'httparty'
require 'fileutils'


def write_cgit_format_to(config_file, repos)
  local_git_directory = ENV['GIT_REPO_DIRECTORY'] || "/tmp"
  repos.each  do |repo| 
    name = repo["name"]
    description = repo["description"]
    owner=repo["owner"]["login"]
    git_url = repo["git_url"]
    local_path = "#{local_git_directory}/#{name}.git" # is this right?
    if File.directory?(local_path)
      `cd #{local_path} && git pull --quiet --all &`
    else
      `git clone --quiet #{git_url} #{local_path} &`
    end
    config_file.write("\nrepo.url=#{name}\n")
    config_file.write("repo.path=#{local_path}\n")
    config_file.write("repo.desc=#{description}\n")
    config_file.write("repo.owner=#{owner}\n")
    return # debug, don't want to wait so long
  end
end

def pull_starred_repositories_to(write_path, user)
  tmp_path = "#{write_path}.tmp"
  starred_file = File.open(tmp_path, 'w')
  starred_repositories = HTTParty.get("https://api.github.com/users/#{user}/starred")
  write_cgit_format_to(starred_file, starred_repositories)
  starred_file.close unless starred_file.nil?
  FileUtils.mv(tmp_path, write_path)
end

user = ENV['GITHUB_USER'] || "scanf"
starred_path = ENV['STARRED_GITHUB_REPOSITORIES'] || "/etc/starred_repositories"
pull_starred_repositories(starred_path, user)
