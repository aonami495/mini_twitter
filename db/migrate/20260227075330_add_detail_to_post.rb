class AddDetailToPost < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :reply_to, foreign_key: { to_table: :posts }
    add_reference :posts, :quote,  foreign_key: { to_table: :posts }
  end
end
