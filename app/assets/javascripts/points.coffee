ready = ->
  PrivatePub.subscribe '/points', (data, channel) ->
    id = $.parseJSON(data['point']).id
    latitude = $.parseJSON(data['point']).latitude
    longitude = $.parseJSON(data['point']).longitude

    $('.points').append("<tr><td><a href='points/#{id}'>#{id}</a></td><td>#{latitude}</td><td>#{longitude}</td></tr>")
    $('input#create_form').val('')

  $('.destroy_point').bind 'ajax:success', (e, data, status, xhr) ->
    id = xhr.responseJSON.point
    $('#point_' + id).html('')

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
