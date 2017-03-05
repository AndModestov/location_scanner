ready = ->
  PrivatePub.subscribe '/points', (data, channel) ->
    id = $.parseJSON(data['point']).id
    latitude = $.parseJSON(data['point']).latitude
    longitude = $.parseJSON(data['point']).longitude

    $('.points').append("<tr><td><a href='points/#{id}'>#{id}</a></td><td>#{latitude}</td><td>#{longitude}</td></tr>")
    $('input#create_form').val('')

  $('.table_clear').click (e) ->
    point_id = $(this).data('pointId')
    $('#nearest_points_' + point_id).html('')

  PrivatePub.subscribe '/nearest_points', (data, channel) ->
    base_point_id = $.parseJSON(data['base_point_id'])
    id = $.parseJSON(data['point']).id
    latitude = $.parseJSON(data['point']).latitude
    longitude = $.parseJSON(data['point']).longitude

    $('#nearest_points_'+ base_point_id).append("<tr><td><a href='points/#{id}'>#{id}</a></td><td>#{latitude}</td><td>#{longitude}</td></tr>")

  $('.destroy_point').bind 'ajax:success', (e, data, status, xhr) ->
    id = xhr.responseJSON.point
    $('#point_' + id).html('')

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
