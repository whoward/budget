

# frozen_string_literal: true
class DummyImportService < Budget::ImportService
end

Budget::ImportService.register(DummyImportService)
