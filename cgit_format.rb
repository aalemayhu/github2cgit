def write_cgit_format_to(config_file, repos, local_git_directory)
  repos.each  do |repo| 
    name = repo["name"]
    description = repo["description"]
    owner=repo["owner"]["login"]
    git_url = repo["git_url"]
    local_path = "#{local_git_directory}/#{owner}/#{name}.git" # is this right?
    if File.directory?(local_path)
      `cd #{local_path} && git remote update &`
    else
      `git clone --mirror --quiet #{git_url} #{local_path} &`
    end

    cgit_repo = Repository.new(name, local_path, description, owner)
    config_file.write(cgit_repo.to_string())
  end
end
