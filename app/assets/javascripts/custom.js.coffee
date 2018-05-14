$(document).on 'turbolinks:load', ->
  $('.spinner').hide()

  $(document).ajaxStart(->
    alert('hi');
  )
  # $(document).ajaxStart(->
  #   $('.spinner').fadeIn 'fast'
  # ).ajaxStop ->
  #   $('.spinner').fadeOut 'fast'
