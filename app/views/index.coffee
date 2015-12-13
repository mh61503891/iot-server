data = [
  {label: 'Series 1', values: [ ]}
  {label: 'Series 2', values: [ ]}
  {label: 'Series 3', values: [ ]}
]
max = 0
$ ->
  $('#clear').on 'click', ->
    max = 0
  chart = $('#chart').epoch
    data: data
    type: 'time.line'
    axes: ['right', 'left']
  ws = new WebSocket(location.origin.replace(/^http/, 'ws'))
  ws.onmessage = (message) ->
    data = JSON.parse(message.data)
    chart.push [
      {time: data.timestamp, y: data.values[0]}
      {time: data.timestamp, y: data.values[1]}
      {time: data.timestamp, y: data.values[2]}
    ]
    sum = Math.abs(data.values[0]) +
          Math.abs(data.values[1]) +
          Math.abs(data.values[2])
    current = Math.round( sum * 10 ) / 10
    max = current if current > max
    $('span#current-score').html(current)
    $('span#max-score').html(max)
