
module Budget
  class Engine < ::Rails::Engine
    isolate_namespace Budget

    rake_tasks do
      load File.join(root, 'lib', 'tasks', 'import.rake')
    end

    initializer 'budget.seeds.ensure' do
      # don't run this initializer unless the migrations have been run
      next unless Budget::Category.table_exists?

      # ensure teh category roots exist and are loaded
      %i(income expense transfers transfer_from transfer_to).each do |fixture|
        Category.public_send(fixture) ||
          Rails.logger.error("unable to load category: #{fixture}, run the seeds for the budget engine")
      end
    end

    initializer 'budget.assets.precompile' do |app|
      app.config.assets.precompile += %w(budget/application.css budget/application.js)
    end
  end
end
