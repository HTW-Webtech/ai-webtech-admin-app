$ ->
  $('[data-behavior=app-review-typeahead]').each (_, input) ->
    if !window.review_app_names
      alert 'Missing review app names'
    else
      bloodhound = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.whitespace
        queryTokenizer: Bloodhound.tokenizers.whitespace
        local: window.review_app_names
      })
      $input = $(input)
      $input.typeahead(null, {
        source: bloodhound,
        templates: {
          empty: [
            '<div class="empty-message">',
              'unable to find any Best Picture winners that match the current query',
            '</div>'
          ].join('\n'),
          suggestion: (name) ->
            "<div><a href='/admin/#{name}/app_review'>#{name}</a></div>"
        }
      })
      $input.keyup (event) ->
        if event.which == 13
          lis = $('ul.typeahead-app-review li')
          debugger

