# frozen_string_literal: true

require_relative 'application_decorator'

module Budget
  class TransactionDecorator < ApplicationDecorator
    delegate :id, :cents

    delegate :name, to: :category, prefix: true
    delegate :name, to: :account, prefix: true

    def date
      object.date.to_s
    end

    def linked_description(options)
      h.link_to(object.description, h.edit_transaction_path(object, options))
    end

    def icon
      klass = icon_class
      h.icon_tag(klass) if klass
    end

    def notes_icon
      h.icon_with_tooltip(:'info-circle', object.notes) if object.notes.present?
    end

    def sign_class
      expense? ? :negative : :positive
    end

    private

    delegate :category, :account, to: :object

    def icon_class
      if split_transaction?
        :sitemap
      elsif transfer_to?
        :'arrow-right'
      elsif transfer_from?
        :'arrow-left'
      end
    end

    def split_transaction?
      object.split_transaction_id.present?
    end

    def transfer_to?
      category == Budget::Category.transfer_to
    end

    def transfer_from?
      category == Budget::Category.transfer_from
    end

    def expense?
      object.is_a?(Budget::Expense)
    end
  end
end
