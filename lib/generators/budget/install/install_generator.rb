# frozen_string_literal: true

module Budget
  class InstallGenerator < Rails::Generators::Base
    source_root File.join(__dir__, 'templates')

    def install_migrations
      say_status :copying, 'migrations'
      silence_stream(STDOUT) do
        silence_warnings { rake 'budget:install:migrations' }
      end
    end

    def install_route
      route "mount Budget::Engine => '/'"
    end

    def include_seed_data
      append_file 'db/seeds.rb', "\nBudget::Engine.load_seed"
    end
  end
end
