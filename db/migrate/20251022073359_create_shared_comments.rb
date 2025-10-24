class CreateSharedComments < ActiveRecord::Migration[7.2]
  def change
    create_table :shared_comments do |t|
      t.references :travel_record, null: false, foreign_key: true
      t.string :commenter_name, null: false
      t.string :commenter, null: false
      t.timestamps
    end
  end
end
