
class SplitTransaction

  errors = 
    sum_of_parts_doesnt_equal_total: "All of the parts don't equal the value of the transaction"
    partitions_inconsistent_type: "Internal Error: partitions_inconsistent_type"
    transaction_must_be_income_or_expense: "Internal Error: transaction_must_be_income_or_expense"
    
  constructor: (node) ->
    @node = node

    @template = Template.embedded("partition-template")

    node.on "click", ".js-add", => @render(); false

    node.on "click", ".js-remove", (ev) => @remove(ev.target); false

    node.on "ajax:success", => Turbolinks.visit(routes.transactions)

    node.on "ajax:error", (ev, xhr) => alert(errors[xhr.responseJSON.reason])

  remove: (element) ->
    $(element).parents("tr:first").remove()

  render: ->
    html = @template(id: new Date().getTime())

    $(html).appendTo(@node.find("table"))
           .trigger("bind")

bind '.js-split-transaction', (node) -> new SplitTransaction(node)
