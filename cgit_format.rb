def write_cgit_format_to(config_file, repos, local_git_directory)
  repos.each  do |repo| 
    name = repo["name"]
    description = repo["description"]
    owner=repo["owner"]["login"]
    git_url = repo["git_url"]
    local_path = "#{local_git_directory}/#{name}.git" # is this right?
    if File.directory?(local_path)
      `cd #{local_path} && git pull --quiet --all &`
    else
      `git clone --mirror --quiet #{git_url} #{local_path} &`
    end
    config_file.write("\nrepo.url=#{name}\n")
    config_file.write("repo.path=#{local_path}\n")
    config_file.write("repo.desc=#{description}\n")
    config_file.write("repo.owner=#{owner}\n")
  end
end
