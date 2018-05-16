$(document).on 'turbolinks:load', ->
  $('.spinner').hide()
  # $(document).ajaxStart(->
  #   $('.spinner').fadeIn 'fast'
  # ).ajaxStop ->
  #   $('.spinner').fadeOut 'fast'

  player = new Plyr('#player')
