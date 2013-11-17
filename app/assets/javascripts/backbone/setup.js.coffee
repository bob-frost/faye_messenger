#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./collections

window.Messenger =
  Models: {}
  Collections: {}
  Views: {}

  init: ->
    Messenger.currentUser = if current_user then new Messenger.Models.User(current_user) else null

$ ->
  Messenger.init()