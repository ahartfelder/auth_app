class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false}, length: { maximum: 105 }, format: { with: /^(.+)@(.+)$/, message: "Email invalid", multiline: true }
  validates :password, length: { in: 6..20 }

  def activate_user
    self.toggle!(:confirmed?)
    
  end
end
