class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="play-again-button">Play Again</button>
    <button class="change-bet-button">Change Bet</button>
    <button class="double-down-button">Double Down</button>
    <div class="scoreboard-container"></div>
    <div class="message-container"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit() if @model.get "gameInProgress"
    "click .stand-button": -> @model.get('playerHand').stand() if @model.get "gameInProgress"
    "click .play-again-button": -> @model.startGame() if !@model.get "gameInProgress"
    "click .change-bet-button": -> @model.get('scoreboard').changeBet(prompt("How Much?")) if !@model.get "gameInProgress" 
    "click .double-down-button": -> @model.get('playerHand').doubleDown() if @model.get "gameInProgress"
  initialize: ->
    @render()
    @model.on 'renderNewGame', =>
      @render()


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.scoreboard-container').html new ScoreboardView(model: @model.get 'scoreboard').el
    @$('.message-container').html new MessageView(model: @model.get 'message').el