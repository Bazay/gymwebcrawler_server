class CreateGymClasses < ActiveRecord::Migration
  def change
    create_table :gym_classes do |t|
      t.string :name
      t.string :start_time
      t.string :end_time
      t.string :day

      t.timestamps null: false
    end
  end
end
