class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
