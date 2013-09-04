class Category < ActiveRecord::Base

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates_presence_of :name

  after_validation :slug
  def slug
    self.generate_slug(self.name)
  end

end
