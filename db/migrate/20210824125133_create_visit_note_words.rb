class CreateVisitNoteWords < ActiveRecord::Migration[6.1]
  def change
    create_table :visit_note_words do |t|
      t.string :name
      t.integer :rating
      t.integer :patient_id
      t.integer :visit_note_id
      t.integer :progress_word_id

      t.timestamps
    end
  end
end
