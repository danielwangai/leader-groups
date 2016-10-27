class CreateMeetingChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :meeting_challenges do |t|
      t.text :challenge
      t.references :report, foreign_key: true

      t.timestamps
    end
  end
end
