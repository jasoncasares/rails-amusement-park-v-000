class User < ActiveRecord::Base
  has_many :rides
  has_many :attractions, through: :rides
  validates_presence_of :password_digest
  has_secure_password

  def mood
    if nausea > happiness
      "sad"
    else
      "happy"
    end
  end
end
