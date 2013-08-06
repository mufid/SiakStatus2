class CreateSiakStatuses < ActiveRecord::Migration
  def change
    create_table :siak_statuses do |t|
      t.integer :ping_ms

      t.timestamps
    end
  end
end
