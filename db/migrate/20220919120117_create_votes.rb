class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true
      t.references :user
      t.integer :value

      t.timestamps
    end
  end
end
