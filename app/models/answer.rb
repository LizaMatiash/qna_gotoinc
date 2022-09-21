class Answer < ApplicationRecord
  include HasVote
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable
  # has_many :votes, dependent: :destroy, as: :votable

  validates :body, presence: true

  accepts_nested_attributes_for :attachments
  # accepts_nested_attributes_for :votes, reject_if: :all_blank
end
