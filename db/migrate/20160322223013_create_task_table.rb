class CreateTaskTable < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string  :description
      t.boolean :completed
      t.integer  :priority
      t.integer :list_id
      t.timestamps  null: false
    end

  end
end
