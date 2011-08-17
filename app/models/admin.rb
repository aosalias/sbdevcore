class Admin < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :username

  devise :database_authenticatable, :recoverable, :rememberable, :authentication_keys => [:username]
end
