class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.text :tagcontent
      t.references :url, foreign_key: true

      t.timestamps
    end
  end
end
