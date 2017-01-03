class CreateSamplesGroup < ActiveRecord::Migration[5.0]
  def change
    create_table :samples_group do |t|
      t.datetime :created_at
      t.string :title
      t.string :description
    end
  end
end
