describe "deck constructor", ->

  it "should create a card collection", ->
    collection = new Deck()
    expect(collection.length).toBe 52
  it 'should be perfect',->
    expect(1).toEqual(1)

