class ChangeDatatypeFollowedIdOfRelationships < ActiveRecord::Migration[6.1]
  def change
    change_column :relationships, :followed_id, :integer
  end
end
