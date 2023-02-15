class CreateOriginalStrings < ActiveRecord::Migration[7.0]
  def change
    create_table :original_strings do |t|
      t.text :value, null: false, limit: 1000

      t.timestamps
    end
  end
end
