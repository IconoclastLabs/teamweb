# Really crappy code to hide / show for Me/Org please refactor at some point
(($) ->
  # show if it is checked
  $("input[data-org]").each (box) ->
    shown = $(@).prop('value') == "Me"
    $($(@).data('org')).toggle(shown)

  # On change, toggle visibility
  $("input[data-org]").change ->
    to_hide = $(@).data('org')
    $(to_hide).fadeToggle()  

) jQuery