# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Form - Show and hide dependant form fields
(($) ->
  # show if it is checked
  $("input[data-hide]").each (box) ->
    shown = $(@).prop('checked')
    $($(@).data('hide')).toggle(shown)

  # On change, toggle visibility
  $("input[data-hide]").change ->
    to_hide = $(@).data('hide')
    $(to_hide).fadeToggle()  
) jQuery