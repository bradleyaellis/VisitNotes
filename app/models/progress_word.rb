class ProgressWord < ApplicationRecord
    belongs_to :patient
    belongs_to :visit_note, optional: true
end
