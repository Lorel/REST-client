$(document).on 'ready', () ->
  $.Mustache.addFromDom 'param-form'
  index = 0
  $endpoint = $ 'input[name="endpoint"]'
  $route = $ 'input[name="route"]'
  $request = $ '#request .display'
  $response = $ '#response .display'

  $('#add-param').on 'click', () ->
    $field = $ $.Mustache.render('param-form', { id: index++ })
    $(this).before $field.hide()
    $field.slideDown()
    bindInputs()

  bindInputs = ->
    $('input').off 'input'
    $('input').on 'input', ->
      $request.html compose()

  bindInputs()

  compose = () ->
    $paramInputs = $ 'input.param'
    url = $endpoint.val()
    url += $route.val()
    url += '?' if $("input.name").filter(() -> this.value).length
    $paramInputs.each (i) ->
      return unless $("input[name='name-param-" + $(this).data('id') + "']")[0].value
      url += $(this).val()
      if $(this).attr('name').indexOf('value') < 0
        url += '='
      else
        url += '&' if i + 1 != $paramInputs.length
    return url

  $('#submit').on 'click', () ->
    $.getJSON compose(), (data) ->
      $response.removeClass('error').text JSON.stringify(data, null, 2)
    .error (err, message) ->
      console.log(err)
      $response.addClass('error').text(message)
      $response.append("\nResponse: " + err.responseText) if err.status != 200

  $('#reset').on 'click', () ->
    $endpoint.val('')
    $route.val('')
    $request.empty()
    $response.removeClass('error').empty()
    $('#params .row').slideUp(() -> $(this).remove())
