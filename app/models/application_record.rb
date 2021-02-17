class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.paginate(per_page, page)
    per_page = (per_page || 20).to_i
    starting = ([page.to_i, 1].max - 1) * per_page
    limit(per_page).offset(starting)
  end

  def self.partial_search(find)
    key = "%#{find}%".downcase

    where("LOWER(name) like :search", search: key)
  end
end
