require 'haml'

module Budget
  class Engine < ::Rails::Engine
    isolate_namespace Budget
  end
end
