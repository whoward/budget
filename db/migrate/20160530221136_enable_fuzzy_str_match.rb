# frozen_string_literal: true
class EnableFuzzyStrMatch < ActiveRecord::Migration
  def change
    enable_extension 'fuzzystrmatch'
  end
end
