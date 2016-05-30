# frozen_string_literal: true

module ControllerHelpers
  extend ActiveSupport::Concern

  included do
    routes { Budget::Engine.routes }
  end
end

RSpec.configure do |config|
  config.include ControllerHelpers, type: :controller

  # automatically infers the spec type (controller, model, etc) from the directory
  config.infer_spec_type_from_file_location!
end
