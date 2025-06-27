class BackfillPasswordResetExpirations < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL.squish
      UPDATE password_resets
      SET expires_at = created_at + INTERVAL '24 hours'
      WHERE expires_at IS NULL
    SQL
  end
end