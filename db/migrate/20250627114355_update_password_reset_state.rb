class UpdatePasswordResetState < ActiveRecord::Migration[6.1]
    def change
      # 1. Add new columns
      add_column :password_resets, :state, :string, default: 'pending'
      add_column :password_resets, :used_at, :datetime
      
      # 2. Backfill existing data
      reversible do |dir|
        dir.up do
          # Set state and used_at based on existing 'used' column
          execute <<-SQL.squish
            UPDATE password_resets
            SET 
              state = CASE WHEN used = TRUE THEN 'used' ELSE 'pending' END,
              used_at = CASE WHEN used = TRUE THEN NOW() ELSE NULL END
          SQL
        end
      end
      
      # 3. Remove old column (after data migration)
      remove_column :password_resets, :used, :boolean
    end
  end