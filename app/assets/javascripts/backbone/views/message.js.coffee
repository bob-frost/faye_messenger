class Messenger.Views.Message extends Backbone.View
  template: JST['backbone/templates/message']

  initialize: ->
    _.bindAll @, 'render'
    @model.bind 'change', @render

  render: ->
    @$el.html @template(@model.toJSON())
    @
