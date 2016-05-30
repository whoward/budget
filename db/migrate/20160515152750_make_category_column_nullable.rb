# frozen_string_literal: true
class MakeCategoryColumnNullable < ActiveRecord::Migration
  def change
    change_column_null :budget_categories, :depth, true
  end
end
