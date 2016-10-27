class CreateMeetingTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :meeting_topics do |t|
      t.string :topic
      t.references :report, foreign_key: true

      t.timestamps
    end
  end
end
