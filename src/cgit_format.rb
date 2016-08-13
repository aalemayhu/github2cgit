require_relative 'repository.rb'

def map_to_cgit_repos(github_repository_payload)
  cgit_repos = []
  github_repository_payload.each  do |repo| 
    name = repo["name"]
    description = repo["description"]
    owner = repo["owner"]["login"]
    git_url = repo["git_url"]
    cgit_repos.push(Repository.new(name, description, owner, git_url))
  end
  return cgit_repos
end

