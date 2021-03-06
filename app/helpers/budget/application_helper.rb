
# frozen_string_literal: true
module Budget
  module ApplicationHelper
    def review_count
      @review_count ||= ImportableAccount.not_imported.count + ImportableTransaction.not_imported.count
    end

    def transactions_count
      @transactions_count ||= Transaction.count
    end

    def cents_to_dollars(cents)
      if cents
        (cents / 100.0).round(2)
      else
        0.00
      end
    end

    def cents_to_currency(cents, *args, &block)
      number_to_currency cents_to_dollars(cents), *args, &block
    end

    def page_header(header)
      content_tag(:div, class: 'page-header') do
        content_tag(:h1, header)
      end
    end

    def page_header_with_add_button(model, url: nil, header: nil, new_text: nil)
      url ||= url_for(controller: model.table_name.sub('budget_', ''), action: 'new')
      header ||= model.model_name.human.pluralize
      new_text ||= "New #{model.model_name.human}"

      content_tag(:div, class: 'page-header') do
        link_to(new_text, url, class: 'btn btn-primary pull-right') +
          content_tag(:h1, header)
      end
    end

    def grouped_options_for_income_and_expenses(selected = nil)
      categories = [Category.income, Category.expense].map(&:self_and_descendants).map(&:to_a).flatten
      grouped_options_for_categories(categories, selected)
    end

    def grouped_options_for_categories(categories, selected = nil)
      result = StringIO.new
      selected = selected.try(:to_i)

      visit = lambda do |elem|
        if elem.root?
          result << "<optgroup label='#{h elem.node.name}'>"
          elem.children.sort_by { |c| c.node.name }.each { |c| visit.call(c) }
          result << '</optgroup>'
        elsif elem.leaf?
          name = elem.ancestors[0..-2].map(&:node).map(&:name).join(' - ')
          value = elem.node.id
          is_selected = elem.node.id == selected ? 'selected' : nil
          result << content_tag(:option, name, value: value, selected: is_selected)
        end
      end

      AwesomeNestedSetTree.from_nodes(categories).roots.each { |r| visit.call(r) }

      result.string.html_safe
    end

    def link_to_edit_resource(resource, text: nil, url: nil)
      text ||= t('.edit', default: t('helpers.links.edit'))
      url ||= url_for(id: resource, controller: resource.class.table_name.sub('budget_', ''), action: 'edit')

      link_to text, url, class: %w(btn btn-mini)
    end

    def link_to_delete_resource(resource, text: nil, url: nil, confirm: nil)
      text ||= t('.destroy', default: t('helpers.links.destroy'))
      url ||= url_for(id: resource, controller: resource.class.table_name.sub('budget_', ''), action: 'destroy')
      confirm ||= t('.confirm', default: t('helpers.links.confirm', default: 'Are you sure?'))

      link_to text, url, method: :delete, data: { confirm: confirm  }, class: 'btn btn-mini btn-danger'
    end

    def icon_tag(icon_class, attributes = {})
      tag(:i, attributes.merge(class: "fa fa-#{icon_class}"))
    end

    def icon_with_tooltip(icon_class, text, placement: :top)
      icon_tag icon_class, data: {
        toggle: :tooltip,
        placement: placement,
        title: text
      }
    end

    def format_amount(cents)
      number_to_currency(cents_to_dollars(cents), unit: '')
    end
  end
end
