class CreateCategorizations < ActiveRecord::Migration
  def self.up
    create_table :categorizations, :id => false do |t|
      t.references :category
      t.references :event
    end
  end

  def self.down
    drop_table :categorizations
  end
end
