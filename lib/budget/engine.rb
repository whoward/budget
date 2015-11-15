
module Budget
  class Engine < ::Rails::Engine
    isolate_namespace Budget

    initializer 'budget.seeds.ensure' do
      %i(income expense transfers transfer_from transfer_to).each do |fixture|
        Category.public_send(fixture) ||
          fail("unable to load category: #{fixture}, run the seeds for the budget engine")
      end
    end
  end
end
