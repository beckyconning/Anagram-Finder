class CreateConnections < ActiveRecord::Migration
  def self.up
    create_table :connections do |t|
      t.integer :to_node_id
      t.integer :from_node_id

      t.timestamps
    end
  end

  def self.down
    drop_table :connections
  end
end
