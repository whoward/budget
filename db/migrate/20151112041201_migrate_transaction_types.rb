class MigrateTransactionTypes < ActiveRecord::Migration
  def change
    execute "update budget_transactions set type = concat('Budget::', type)"
  end
end
