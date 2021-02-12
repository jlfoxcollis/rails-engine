class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.partial_search(find)
    key = "%#{find}%".downcase

    where("LOWER(name) like :search", search: key)
  end
end
