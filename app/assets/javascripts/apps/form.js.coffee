window.Aris ||= {}

class Aris.AppsForm
  @update_form: ->
    $('[data-behavior=external-hosting-toggle]').each (i, el) ->
      checked = $(this).prop 'checked'
      $("[data-external-visible=true]").toggle checked
      $("[data-external-visible=false]").toggle !checked

$ ->
  Aris.AppsForm.update_form()
  $('[data-behavior=external-hosting-toggle]').each (i, el) ->
    $(el).on 'change', (event) ->
      Aris.AppsForm.update_form()
