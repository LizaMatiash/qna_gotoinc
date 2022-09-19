class Question < ApplicationRecord
  include HasVote
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable
  # has_many :votes, dependent: :destroy, as: :votable
  belongs_to :user
  validates :title, :body, presence: true

  # scope :rating, ->(question) { Vote.where(votable_id: question).inject (0) { |sum, vote| sum + vote.votes} }

  accepts_nested_attributes_for :attachments
  # accepts_nested_attributes_for :votes, reject_if: :all_blank
end
