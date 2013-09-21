# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Form - Show and hide dependant form fields
jQuery ->
  # show if it is checked
  $("input[data-hide]").each (box) ->
    shown = $(@).prop('checked')
    $($(@).data('hide')).toggle(shown)

  # On change, toggle visibility
  $("input[data-hide]").change ->
    to_hide = $(@).data('hide')
    $(to_hide).fadeToggle()  

  # append checkbox to handle "No Max"
  $("input[data-maxable]").each (box) ->
    box_id = @.id
    checkbox_id = box_id + $(@).data('maxable')
    new_html = "<label class='nomax'>No Max <input type='checkbox' id='" + checkbox_id + "' /></label>"
    $(@).parent().append(new_html);
    # Set click event on our new checkbox
    $("#" + checkbox_id).on "change", (event) ->
      if $(@).prop('checked')
        $("#" + box_id).val(null)
        $("#" + box_id).attr('readonly', 'readonly')
      else
        $("#" + box_id).removeAttr('readonly')
    #if there's nothing in the box, then might as well check the box
    $("#" + checkbox_id).prop('checked', true).change() if @.value.length == 0
