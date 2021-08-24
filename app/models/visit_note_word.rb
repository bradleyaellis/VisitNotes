class VisitNoteWord < ApplicationRecord
    belongs_to :patient
    belongs_to :visit_note
    belongs_to :progress_word
end