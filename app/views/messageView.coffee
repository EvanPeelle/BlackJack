class window.MessageView extends Backbone.View

  className: 'message'

  template: _.template '<div><strong><%= message %></strong></div>'

  initialize: ->
    @render()
    @model.on 'change' ,=> @render()
  render: ->
    @$el.html @template @model.attributes