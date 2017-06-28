$(function() {
  var ws = new WebSocket("ws://localhost:8080/echo");
  ws.onmessage = function(e) {
    $('#result').val(event.data);
  }

  $("#run").click(function() {
    var data = $('#codetype').val() + "withcode" + $('#codes').val();
    ws.send(data);
  });
});
