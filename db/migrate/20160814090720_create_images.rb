class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.boolean :flag, :default => false
      t.timestamps null: false
    end
  end
end
