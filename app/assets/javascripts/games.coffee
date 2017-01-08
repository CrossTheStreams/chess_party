# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(->
  window.chess = new Chess()

  window.board = ChessBoard('board', {
    draggable: true
    position: 'start'
    onDrop: (from, to, piece, boardAfter, boardBefore, player) ->
      move = chess.move(from: from, to: to)
      if move

      else
        @position('start')

    onChange: () ->
  })
)
