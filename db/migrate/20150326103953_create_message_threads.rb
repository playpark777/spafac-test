class CreateMessageThreads < ActiveRecord::Migration[4.2]
  def change
    create_table :message_threads do |t|

      t.timestamps null: false
    end
  end
end
