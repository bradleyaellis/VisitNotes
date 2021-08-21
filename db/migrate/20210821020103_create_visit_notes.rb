class CreateVisitNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :visit_notes do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
    add_index :visit_notes, :title
  end
end
