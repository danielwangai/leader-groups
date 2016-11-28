class CreateMeetingIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :meeting_issues do |t|
      t.string :issue
      t.references :report, foreign_key: true

      t.timestamps
    end
  end
end
