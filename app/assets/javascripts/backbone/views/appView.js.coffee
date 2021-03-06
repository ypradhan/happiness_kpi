namespace "happiness_kpi", (exports) ->
  exports.appView = Backbone.View.extend

    template: HandlebarsTemplates['templates/faces']

    el: '#display'

    initialize: ->
      @render()

    events: ->
      'click #happy':     @happySelected
      'click #undecided': @undecidedSelected
      'click #sad':       @sadSelected

    render: ->
      $('#choices').modal {
        show: true,
        backdrop: true,
        backdrop: 'static',
        keyboard: false
      }

      @$el.html HandlebarsTemplates.faces()

    happySelected: ->
      @saveNewEmotion(3, null)

    undecidedSelected: ->
      @saveNewEmotion(2, null)

    sadSelected: ->
      @saveNewEmotion(1, null)

    saveNewEmotion: (emotion, callback) ->
      @emotion = new happiness_kpi.emotion

      @emotion.set({ emotion: emotion })

      @emotion.save null, success: callback

      @closeModal()

    closeModal: ->
      $('#choices').modal 'hide'
