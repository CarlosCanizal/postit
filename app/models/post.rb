class Post < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments

  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :votable

  validates_presence_of :title


  def total_votes
    self.votes.where(vote:true).count - self.votes.where(vote:false).count
  end
end