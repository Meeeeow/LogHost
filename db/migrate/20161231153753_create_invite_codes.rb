class CreateInviteCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :invite_codes do |t|
      t.string :code
      t.integer :used_by
    end
  end
end
