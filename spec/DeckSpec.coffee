describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it "should give the last card from the deck", ->
      expect(deck.length).toBe 50
      expect(deck.last()).toEqual hand.hit()
      expect(deck.length).toBe 49
      expect(deck.last()).toEqual hand.hit()
      expect(deck.length).toBe 48
  describe 'dealerPlay', ->
    it "Should choose the greater Ace value when it doesn't bust", ->
      dealerHand = new Hand [new Card(rank:1 , suit:1), new Card(rank:9, suit:1)];
      console.log(dealerHand.at(0), dealerHand.at(1))
      expect(dealerHand.smartScore()).toEqual 20

