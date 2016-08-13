class Repository
  
  attr_accessor :url
  attr_accessor :path
  attr_accessor :desc
  attr_accessor :owner

  def initialize(url, path, desc, owner)
    @url = url
    @path = path
    @desc = desc
    @owner = owner
  end

  def to_string
      return "\nrepo.url=#{name}\n" \
      "repo.path=#{local_path}\n" \
      "repo.desc=#{description}\n" \
      "repo.owner=#{owner}\n"
  end
end
