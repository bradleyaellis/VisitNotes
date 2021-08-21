class VisitNote < ApplicationRecord
    belongs_to :patient

    validates :title, :body, presence: true
end
