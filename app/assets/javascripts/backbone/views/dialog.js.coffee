class Messenger.Views.Dialog extends Backbone.View
  template: JST['backbone/templates/dialog']
  el: '#dialog'

  events: 
    'submit form' : 'sendMessage'

  initialize: (collocutor_id, messages) ->
    @collocutor_id = collocutor_id
    @$el.html @template({collocutor_id: collocutor_id})
    @$textarea = $('textarea', @$el)
    
    Messenger.dialog = new Messenger.Collections.Messages
    Messenger.dialog.bind 'add', @addMessage

    for attributes in messages
      message = new Messenger.Models.Message attributes
      Messenger.dialog.add message

    PrivatePub.subscribe "/dialogs/#{Messenger.currentUser.id}/#{collocutor_id}", (data, channel) ->
      switch data.action
        when 'create'
          unless Messenger.dialog.get data.message.id
            Messenger.dialog.add data.message
            $.ajax
              url: "/dialogs/#{collocutor_id}/messages/#{data.message.id}/read"
              type: 'PATCH'
        when 'read'
          if message = Messenger.dialog.get data.message
            message.set 'read',  true
          else
            Messenger.dialog.add data.message
        when 'readUntil'
          messages = _.filter Messenger.dialog.models, (message) -> 
            message.get('read') == false && message.get('sender_id') == Messenger.currentUser.id && message.id <= data.id
          _.each messages, (message) ->
            message.set 'read', true

    lastUnreadMessage = _.last Messenger.dialog.where({read: false, recipient_id: Messenger.currentUser.id})
    if lastUnreadMessage
      $.ajax
        url: "/dialogs/#{collocutor_id}/read/#{lastUnreadMessage.id}"
        type: 'PATCH'

  sendMessage: (e) ->
    e.preventDefault()
    text = $.trim(@$textarea.val())
    if text.length > 0
      collocutor_id = @collocutor_id
      $textarea = @$textarea
      message = new Messenger.Models.Message
      message.url = "/dialogs/#{collocutor_id}/messages"
      message.save {text: text},
        error: (model, xhr, options) ->
          alert "Couldn't save message"
        success: (model, response, options) ->
          Messenger.dialog.add model
          $textarea.val ''

  addMessage: (message) ->
    messageView = new Messenger.Views.Message {model: message}
    $('#messages').append messageView.render().$el
    

        
    
