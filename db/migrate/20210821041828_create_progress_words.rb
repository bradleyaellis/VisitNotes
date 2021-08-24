class CreateProgressWords < ActiveRecord::Migration[6.1]
  def change
    create_table :progress_words do |t|
      t.string :name

      t.timestamps
    end
  end
end
