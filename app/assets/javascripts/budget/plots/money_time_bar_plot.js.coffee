
class window.MoneyTimeBarPlot
  
  constructor: (options) ->
    @url = options.url

    @parent = $(options.parent)

    @title = options.title

    @width = options.dimensions.width
    @height = options.dimensions.height
    @margin = options.dimensions.margin

    @xAxis = options.xAxis
    @yAxis = options.yAxis

  fetch: ->
    jQuery.get @url, (csv) =>
      @render Papa.parse(csv, header: true, dynamicTyping: true, skipEmptyLines: true)

  render: (result) ->

    data = result.data.map (d) -> 
      x: Date.UTC(d.year, d.month - 1, d.day)
      y: d.value
      color: if d.value < 0 then "red" else "green"

    @parent.highcharts
      title:
        text: @title

      legend:
        enabled: false

      xAxis:
        type: 'datetime'

      yAxis:
        title:
          text: @yAxis.title
        labels:
          formatter: -> accounting.formatMoney(this.value)

      tooltip:
        pointFormatter: -> "<b>" + accounting.formatMoney(this.y) + "</b>"

      series: [
        {
          type: 'column'
          name: 'Debt'
          data: data
        }
      ]

    
    null
