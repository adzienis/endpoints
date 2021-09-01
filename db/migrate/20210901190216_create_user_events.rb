class CreateUserEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :user_events do |t|
      t.jsonb :data

      t.timestamps
    end
  end
end
