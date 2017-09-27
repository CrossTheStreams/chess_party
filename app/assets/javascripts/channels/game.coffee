$(document).ready(->
  App.cable.subscriptions.create { channel: "GameChannel", id: currentGame.id },

    connected: ->
      console.log("connected")

    received: (data) ->
      console.log("received()")
      if data.game
        window.chessParty.receiveOpponentMove(data.game)

)
