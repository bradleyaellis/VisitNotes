class AddPatientAndNoteIdsToProgressWords < ActiveRecord::Migration[6.1]
  def change
    add_column :progress_words, :patient_id, :integer, required: true
    add_column :progress_words, :visit_note_id, :integer
  end
end
