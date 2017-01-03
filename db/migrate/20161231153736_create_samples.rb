class CreateSamples < ActiveRecord::Migration[5.0]
  def change
    create_table :samples do |t|
      t.belongs_to :samples_group
      t.string :created_by
      t.string :created_by_uid
      t.datetime :created_at
      t.string :content
      t.boolean :resolved, :default => false
    end
  end
end
