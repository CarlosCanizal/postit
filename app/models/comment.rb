class Comment < ActiveRecord::Base
  include VoteableCarlos
  belongs_to :user
  belongs_to :post

  validates_presence_of :body


end
