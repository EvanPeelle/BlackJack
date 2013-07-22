class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @stood = false
    @gameEnded= false
    @double = false
  dealerPlay: ->
    @.at(0).flip() if !@.at(0).get 'revealed'
    if @smartScore() < 16
      @hit()
      @dealerPlay()
    else
      @trigger 'tallyScoreTime'
  hit: ->
    @add(@deck.pop()).last()
    @trigger "tallyScoreTime" if @smartScore() > 21 and !@double and !@isDealer
  stand: ->
    @trigger 'stood'
    @stood = true
  scores: ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1 and card.get('revealed')
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
  smartScore: ->
    if _.max(@scores()) <= 21 then _.max(@scores()) else _.min(@scores())
  doubleDown: ->
    @double = true
    @hit()
    @trigger 'doubleDown stood'
