class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :name
      t.boolean :public, default: true
      t.text :description

      t.timestamps
    end
  end
end
