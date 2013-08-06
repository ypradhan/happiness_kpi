namespace "happiness_kpi", (exports) ->
  exports.chartView = Backbone.View.extend

    el: '#lineChart'

    initialize: ->
      @buildChart()
      @emotionCollection = new happiness_kpi.emotionsCollection

    buildChart: ->
      @chart = new Highcharts.Chart
        chart:
          type: 'spline'
          renderTo: 'lineChart'

        title:
          text: "Average Happiness"

        xAxis:
          categories: []

        yAxis:
          title:
            text: 'Happiness Level'
          plotLines: [
            value: 0,
            width: 1,
            color: '#808080'
          ]

        legend:
          layout: 'vertical'
          align: 'right'
          verticalAlign: 'middle'
          borderWidth: 0

        series: [
          name: 'Happiness'
          data: []
        ]

    plotData: ->
      @fetchData (dates, values) =>
        @chart.series[0].setData values
        @chart.xAxis[0].categories =  dates

    fetchData: (callback) ->
      dates = []; values = []

      @emotionCollection.fetch success: =>
        @emotionCollection.forEach (eachItem) =>
          values.push eachItem.get 'value'
          dates.push eachItem.get 'date'

        callback(dates, values)
