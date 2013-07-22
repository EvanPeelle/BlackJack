#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @startGame()
    @set 'scoreboard', scoreboard = new Scoreboard()
  startGame: ->
    @set 'message', new Message()
    @set 'gameInProgress', true
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @setTimeouts()
    @makeListeners()
    @trigger 'renderNewGame'
  tallyScore: ->
    playerScore = @get('playerHand').smartScore()
    dealerScore = @get('dealerHand').smartScore()
    if playerScore > 21
      @get('scoreboard').dealerWins()
      @get('message').set 'message', "Busted!!!"
    else if dealerScore > 21
      @get('scoreboard').playerWins()
      @get('message').set 'message', "Dealer Busts"
    else if playerScore > dealerScore
      @get('scoreboard').playerWins()
      @get('message').set 'message', "Player Wins"
    else if dealerScore > playerScore
      @get('scoreboard').dealerWins()
      @get('message').set 'message', "Dealer Wins"
  setTimeouts: ->
    setTimeout((=>
      @get('playerHand').at(0).flip()),
    300)
    setTimeout((=>
      @get('playerHand').at(1).flip()),
    600)
    setTimeout((=>
      @get('dealerHand').at(1).flip()),
    900)
  makeListeners: ->
    @get('playerHand').on 'stood', =>
      @get('dealerHand').dealerPlay()
      #@get('message').set 'message', "Standing"
      @set 'gameInProgress', false
    @get('playerHand').on 'doubleDown', =>
      @get('scoreboard').set 'double', 2;
      @get('message').set 'message', "Doubling Down"
    @get('dealerHand').on 'tallyScoreTime', =>
      console.log "tallyscoretime"
      @tallyScore()
    @get('playerHand').on 'tallyScoreTime', =>
      console.log "tallyscoretime"
      @tallyScore()
      @set 'gameInProgress', false