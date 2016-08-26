# frozen_string_literal: true

require_relative 'application_decorator'

module Budget
  class AccountDecorator < ApplicationDecorator
    delegate :name

    def icon
      h.icon_tag("#{icon_class} fa-2x")
    end

    def created
      h.l(object.created_at, format: :long)
    end

    def link_to_edit
      h.link_to_edit_resource(object)
    end

    def link_to_delete
      h.link_to_delete_resource(object)
    end

    private

    delegate :debt?

    def visa?
      name =~ /visa/i
    end

    def mastercard?
      name =~ /mastercard/i
    end

    def chequing?
      name =~ /chequing/i
    end

    def savings?
      name =~ /savings/i
    end

    def icon_class
      if debt?
        :'balance-scale'
      elsif visa?
        :'cc-visa'
      elsif mastercard?
        :'cc-mastercard'
      elsif chequing?
        :'credit-card'
      elsif savings?
        :dollar
      else
        :bank
      end
    end
  end
end
