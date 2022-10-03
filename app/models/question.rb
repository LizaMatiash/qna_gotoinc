class Question < ApplicationRecord
  include HasVote
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable
  has_many :comments, dependent: :destroy, as: :commentable
  belongs_to :user
  has_many :subscribe_lists, dependent: :destroy
  has_many :subscribers, class_name: 'User', through: :subscribe_lists

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments

  scope :created_yesterday, -> { where(created_at: Time.zone.now.yesterday.all_day) }

  after_create :subscribe_author
  after_create :rating

  def subscribe(user)
    self.subscribers << user unless has_subscribed? user
  end

  def unsubscribe(user)
    self.subscribers.delete(user) if has_subscribed? user
  end

  def has_subscribed?(user)
    subscribers.include? user
  end

  private

  def subscribe_author
    subscribe(user)
  end
end
