$ ->
  new Aris.AppEdit

@Aris ||= {}

class Aris.AppEdit
  constructor: ->
    @init_add_env_vars()
    @init_delete_env_var_rows()

  init_add_env_vars: ->
    @$add_button = $('[data-behavior="add-env-var"]')
    @$add_button.on 'click', @add_env_var

  init_delete_env_var_rows: ->
    @$row_container = $('[data-behavior="row-container"]')
    @$row_container.on 'click', '[data-behavior~="deletes-row"]', @delete_env_var_row

  delete_env_var_row: (event) =>
    event.preventDefault()
    $button = $(event.target)
    $row = $button.parents('[data-behavior~="deletable-row"]')
    $row.fadeOut -> $row.detach()

  add_env_var: (event) =>
    event.preventDefault()
    $rows = $('[data-behavior~="env-vars-template"]')
    template = $rows.first().clone()
    template.find('input').val('')
    template.appendTo($rows.first().parent()).toggle();

