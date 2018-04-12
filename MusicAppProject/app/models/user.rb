class User < ApplicationRecord


  # cats 99
  # https://github.com/appacademy/curriculum/blob/master/rails/projects/ninety_nine_cats_ii/solution/app/models/user.rb

  # first rails app
  # https://github.com/appacademy/curriculum/blob/master/rails/homeworks/rails-auth/solution/app/models/user.rb
  validates :email, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  # 1. before_valiation OR after_initialize
  # before_validation :ensure_session_token
  after_initialize :ensure_session_token
  # 2. attr_reader :password
  attr_reader :password

  # 3. 2 selfs -- find_by_credentials + generate_session_token
  def self.find_by_credentials(email, password)
    # look up user in the database
    # check if the passowrd they supplied us is the right password
    debugger 
    user = User.find_by(email: email)
    debugger
    # if found the user && he has the right passord return user esle nil
    user && user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    #generat a random  token
    SecureRandom.urlsafe_base64(16)
  end

  # 4. 2 regarding password
  def password=(password)
      @password = password
      self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    bcrypt = BCrypt::Password.new(self.password_digest)
    bcrypt.is_password?(password) #back to original ... check if its the same
  end

  #5 2 regarding sessions
  def reset_session_token
    # reassign to a new one, then save then return
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    # assign session token
    self.session_token ||= User.generate_session_token
  end

end
