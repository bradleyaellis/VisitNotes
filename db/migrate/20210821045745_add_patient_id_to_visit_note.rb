class AddPatientIdToVisitNote < ActiveRecord::Migration[6.1]
  def change
    add_column :visit_notes, :patient_id, :integer, required: true
  end
end
