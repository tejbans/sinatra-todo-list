class User < ActiveRecord::Base
  has_many  :lists

  has_secure_password

end