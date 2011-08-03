class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.boolean :color
      t.string :key

      t.timestamps
    end
  end

  def self.down
    drop_table :nodes
  end
end
