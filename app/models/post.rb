class Post < ActiveRecord::Base
  include VoteableCarlos
  include SlugCarlos
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments

  has_many :post_categories
  has_many :categories, through: :post_categories
  validates_presence_of :title

  after_validation :slug
  def slug
    self.generate_slug(self.title)
  end

end