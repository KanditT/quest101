# frozen_string_literal: true

class CreateQuests < ActiveRecord::Migration[8.0]
  def change
    create_table :quests do |t|
      t.string :name
      t.boolean :status # rubocop:disable Rails/ThreeStateBooleanColumn

      t.timestamps
    end
  end
end
