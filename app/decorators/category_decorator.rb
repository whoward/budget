# frozen_string_literal: true

module Budget
  class CategoryDecorator < ApplicationDecorator
    delegate :name, :budgeted_cents
    delegate :name, to: :parent, prefix: true

    def icon
      klass = icon_class
      h.icon_tag(klass) if klass
    end

    def link_to_edit
      h.link_to_edit_resource(object) if object.can_edit?
    end

    def link_to_delete
      h.link_to_delete_resource(object) if object.can_destroy?
    end

    private

    delegate :parent

    def icon_class
      'eye fa-2x' if object.watched
    end
  end
end
