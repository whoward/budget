# frozen_string_literal: true

Sequel.migration do
  change do
    run 'create extension if not exists "fuzzystrmatch"'
  end
end
