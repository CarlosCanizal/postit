class User < ActiveRecord::Base
  include SlugCarlos
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length:{minimum:3}

  def admin?
    self.role  == 'admin'
  end

  def generate_pin!
    #self.update_column(:pin,rand(10**6))
    self.update_column(:pin,'123456')
  end

  def two_factor_auth?
    !self.phone.blank?
  end

  def remove_pin!
    self.update_column(:pin,nil)
  end

  after_validation :slug
  def slug
    self.generate_slug(self.username)
  end

end