data = [
  {
    label: "Series 1"
    values: [ ]
  }
  {
    label: "Series 2"
    values: [ ]
  }
  {
    label: "Series 3"
    values: [ ]
  }
]

$ ->
  mchart = $('#chart').epoch
    type: 'time.line'
    data: data
    axes: ['top', 'right', 'bottom', 'left']
    fps: 120
    tickFormats:
      time: (d) ->
        d
  cache = 0
  ws = new WebSocket(location.origin.replace(/^http/, 'ws'))

  clear = ->
    $('span#max-score').html("")
    console.log 'clear'

  $('#clear').on 'click', ->
    clear()

  # setTimeout(clear, 5000)
  console.log ws
  ws.onmessage = (message) ->
    data = JSON.parse(message.data)
    # console.log data.timestamp
    mchart.push [
      {time: data.timestamp, y: data.values[0]}
      {time: data.timestamp, y: data.values[1]}
      {time: data.timestamp, y: data.values[2]}
    ]
    sum = Math.abs(data.values[0]) + Math.abs(data.values[1]) + Math.abs(data.values[2])
    val = Math.round( sum * 10 ) / 10
    $('span#current-score').html(val)
    if val > cache
      cache = val
      $('span#max-score').html(val)
    # console.log sum



    # console.log message
    # console.log data


# :message, "{\"sensor\":{\"Name\":\"BMA250E Accelerometer Sensor\",\"MinDelay\":0,\"MaximumRange\":32,\"Resolution\":0.00390625,\"Vendor\":\"Bosch\",\"Power\":0.12999999523162842,\"Type\":1,\"FifoReservedEventCount\":0,\"Version\":1,\"FifoMaxEventCount\":0},\"timestamp\":9825218054948,\"accuracy\":2,\"values\":[6.359,0.383,7.929]}"]

    # console.log data
    # mchart.push data
    # mchart.push [
    #   {time: 1370045820, y: 12}
    #   {time: 1370045820, y: 14}
    # ]

    # console.log message
  # ws.onopen = ->

    # data = {
    #   test: 'foo'
    # }
    # ws.send(JSON.stringify(data))



# {time: 1370044800, y: 100} , {time: 1370044801, y: 1000}
