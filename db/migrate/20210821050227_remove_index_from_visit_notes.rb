class RemoveIndexFromVisitNotes < ActiveRecord::Migration[6.1]
  def change
    remove_index :visit_notes, name: "index_visit_notes_on_title"
  end
end
