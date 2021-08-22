class VisitNote < ApplicationRecord
  # belongs_to :patient

  has_many :progress_words

  validates :title, :body, presence: true
end
