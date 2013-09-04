class Comment < ActiveRecord::Base
  include VoteableCarlos
  belongs_to :user
  belongs_to :post


end
