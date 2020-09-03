class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.string :name
      t.string :start
      t.string :end

      t.timestamps
    end
  end
end
