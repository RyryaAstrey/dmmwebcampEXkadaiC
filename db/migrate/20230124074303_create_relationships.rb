class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.string :followed_id
      t.string :integer

      t.timestamps
    end
  end
end
