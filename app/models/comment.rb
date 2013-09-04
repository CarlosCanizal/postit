class Comment < ActiveRecord::Base
  include Votable
  belongs_to :user
  belongs_to :post
  has_many :votes, as: :votable

end
