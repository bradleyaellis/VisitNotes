class Patient < ApplicationRecord
    has_many :visit_notes
    has_many :visit_note_words, :through => :visit_notes
    # has_many :progress_words
end