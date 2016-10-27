class AddRequiresAttentionFieldToMeetingChallenges < ActiveRecord::Migration[5.0]
  def change
    add_column :meeting_challenges, :requires_attention, :boolean
  end
end
