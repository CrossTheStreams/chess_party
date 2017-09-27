# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(->
  # Initialize the global chess engine object with the current board setup
  window.chessEngine = new Chess(currentGame.fen)

  window.board = ChessBoard('board', {
    draggable: true
    position: currentGame.fen
    onDrop: (from, to, piece, boardAfter, boardBefore, player) ->
      #console.log("from : "+from)
      #console.log("to : "+to)
      if chessEngine.turn() != currentUserColor
        console.log("not current user's turn")
        'snapback'
      else
        move = chessEngine.move(from: from, to: to)
        if move
          console.log('valid move')
          if chessEngine.in_check()
            console.log("yo dawg, we in check now")
          if chessEngine.in_checkmate()
            console.log("awww shit, that's checkmate!")
          window.chessParty.commitMove(chessEngine.fen())
        else
          window.chessEngine = new Chess(currentGame.fen)
          console.log('invalid move')
          'snapback'
    onChange: () ->
      console.log('onChange')
    onMoveEnd: () ->
      console.log(window.board.fen())
      console.log('onMoveEnd')
  })

  window.chessParty = {
    receiveOpponentMove: (gameObj) ->
      console.log("receiveOpponentMove")
      console.log(JSON.stringify(gameObj))
      window.board.position(gameObj.fen, true)
      window.currentGame = gameObj
      window.chessEngine = new Chess(gameObj.fen)

    commitMove: (newFen) ->
      $.ajax('/games/'+currentGame.id, {
        method: 'PUT',
        data: {
          game: {
            id: currentGame.id,
            fen: newFen,
            old_fen: currentGame.fen
          }
        },
        success: (response) ->
          currentGame = response.game
          console.log('successful server response:')
          console.log(response)
        error: (response) ->
          # Multiple tabs and/or network problems can lead to a game-state that's
          # out-of-sync. If the update fails, alert the user and animate the board to 
          # it's previous position.
          alert("There was an unexpected error. The game may be out of sync. Try refreshing the page.")
          window.board.position(currentGame.fen, true)
          console.log('failed PUT to server')
          console.log(response)
      })
  }
)
