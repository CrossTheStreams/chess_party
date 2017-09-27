//= require jquery
//= require cable
// Load all Bootstrap JavaScript
//= require bootstrap-sprockets
//= require chessboard-0.3.0
//= require chess.min
//= require channels/game

$(function(){
  //always pass csrf tokens on ajax calls
  $.ajaxSetup({
    headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
  });
});
