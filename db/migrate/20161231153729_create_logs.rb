class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.string :created_by
      t.string :created_by_uid
      t.datetime :created_at
      t.string :description
      t.string :content
      t.boolean :resolved, :default => false
    end
  end
end
