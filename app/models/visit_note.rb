class VisitNote < ApplicationRecord
    belongs_to :patient

    has_many :visit_note_words

    validates :title, :body, presence: true
end
