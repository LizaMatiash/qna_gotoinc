class Answer < ApplicationRecord
  include HasVote
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable
  has_many :comments, dependent: :destroy, as: :commentable

  validates :body, presence: true

  accepts_nested_attributes_for :attachments

  after_create :rating
  after_create :report_subscribers

  private

  def report_subscribers
    ReportSubscribersJob.perform_later(self)
  end
end
