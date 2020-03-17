$(function() {
  const app = App.cable.subscriptions.create({channel: 'ChatChannel', room_id: $('.room').data('room') }, {
    connected: function(data) {
    },
    disconnected: function(data) {
    },
    received(data) {
      $('.message').append(data['data']);
    }
  })
  $(document).on('keypress', '.post', function(e) {
    if (e.keyCode === 13) {
      app.perform("speak", {data: $('.post').val(), current_user_id: $('.room').data('user')});
      $('.post').val('');
    }
  })
})
