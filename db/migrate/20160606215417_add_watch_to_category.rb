# frozen_string_literal: true
class AddWatchToCategory < ActiveRecord::Migration
  def change
    add_column :budget_categories, :watched, :boolean, default: false
  end
end
