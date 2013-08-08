# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Form - Show and hide dependant form fields
(($) ->
  # show if it is checked
  $("input[data-hide]").each (box) ->
    shown = (if $(@).prop('checked') then 'block' else 'none')
    $($(@).data('hide'))[0].style.display = shown

  # On click, toggle visibility
  $("input[data-hide]").click ->
    to_hide = $(@).data('hide')
    $(to_hide).fadeToggle()  
) jQuery