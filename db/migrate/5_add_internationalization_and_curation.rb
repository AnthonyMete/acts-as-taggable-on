class AddInternationalizationAndCuration < ActiveRecord::Migration
  def self.up
    add_column :tags, :localized_name, :hstore
    add_column :tags, :is_accessible, :boolean
    add_hstore_index :tags, :localized_name
  end

  def self.down
    remove_column :tags, :localized_name
    remove_column :tags, :is_accessible
    remove_hstore_index :tags, :localized_name
  end
end