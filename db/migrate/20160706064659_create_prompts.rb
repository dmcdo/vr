class CreatePrompts < ActiveRecord::Migration
  def change
    create_table :prompts do |t|
      t.references :user
      t.references :orig_lesson
      t.string :token
      t.string :video_token
      t.string :script

      t.timestamps null: false
    end
  end
end
