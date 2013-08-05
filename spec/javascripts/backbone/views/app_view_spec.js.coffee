#= require application

describe "App View", ->
  beforeEach ->
    $("body").append('<div id="display"></div>')
    @subject = new happiness_kpi.appView

    @callback = ->
      done()


  afterEach ->
    $("body").append('<div id="display"></div>').remove()

  it 'has an el property', ->
    assert.equal(@subject.$el.selector, "#display")

  describe "#initialize", ->

    it "calls the render function", ->
      @subject.render = sinon.spy()

      @subject.initialize()

      sinon.assert.calledOnce @subject.render

  describe "#render", ->

    it "renders the 'faces' template", ->
      sinon.spy(HandlebarsTemplates, "faces")

      @subject.initialize()

      sinon.assert.calledOnce HandlebarsTemplates.faces
      HandlebarsTemplates.faces.restore()

  describe "#happySelected", ->

    it "is called when the happy face is clicked", ->
      sinon.spy(@subject, "happySelected")
      @subject.delegateEvents()

      $("input#happy").click()

      sinon.assert.calledOnce @subject.happySelected

    it "sets the 'value' for the emotionsCollection", ->
      @subject.saveNewEmotion(3, @callback)

      expect(@subject.emotionsCollection.models[0].attributes.value).to.equal(3)

  describe "#undecidedSelected", ->

    it "is called when the undecided face is clicked", ->
      sinon.spy(@subject, "undecidedSelected")
      @subject.delegateEvents()

      $("input#undecided").click()

      sinon.assert.calledOnce @subject.undecidedSelected

    it "sets the 'value' for the emotionsCollection", ->
      @subject.saveNewEmotion(2, @callback)

      expect(@subject.emotionsCollection.models[0].attributes.value).to.equal(2)

  describe "#sadSelected", ->

    it "is called when the sad face is clicked", ->
      sinon.spy(@subject, "sadSelected")
      @subject.delegateEvents()

      $("input#sad").click()

      sinon.assert.calledOnce @subject.sadSelected

    it "sets the 'value' for the emotionsCollection", ->
      @subject.saveNewEmotion(1, @callback)

      expect(@subject.emotionsCollection.models[0].attributes.value).to.equal(1)

  describe "#saveNewEmotion", ->

    it "creates a new instance of the 'emotionsCollection' collection", ->
      @subject.saveNewEmotion(3, @callback)

      expect(@subject.emotionsCollection).to.exist

    it "sets the 'emotion' model's emotion", ->
      @subject.saveNewEmotion(3, @callback)

      expect(@subject.emotionsCollection.models[0].attributes.value).to.equal(3)
