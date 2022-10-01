class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  has_many :subscribe_lists, dependent: :destroy
  has_many :subscriptions, class_name: 'Question', through: :subscribe_lists 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github, :twitter]

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    authorization.user if authorization
    email = auth.info[:email]
    user = User.find_by(email: email) if email
    if user
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.new(
        # confirmed_at: Time.now,
        email: email,
        password: password,
        password_confirmation: password
      )
      user.save!
      # user.authorizations.create(provider: auth.provider, uid: auth.uid)
      user.create_authorization(auth)
    end
    user
  end

  def self.send_daily_digest
    find_each.each do |user|
      DailyMailer.delay.digest(user)
    end
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end
