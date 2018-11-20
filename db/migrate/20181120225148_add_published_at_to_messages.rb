class AddPublishedAtToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :published_at, :datetime
  end
end
