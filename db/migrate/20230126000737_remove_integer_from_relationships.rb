class RemoveIntegerFromRelationships < ActiveRecord::Migration[6.1]
  def change
    remove_column :relationships, :integer, :string
  end
end
