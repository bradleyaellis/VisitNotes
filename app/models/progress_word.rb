class ProgressWord < ApplicationRecord
    belongs_to :student
    belongs_to :visit_note, optional: true
end
