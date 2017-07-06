require "./materialize.config.scss"
window.customElements.define "ceri-progress", require("../src/progress.coffee")(require("../src/materialize.coffee"))
createView = require "ceri-dev-server/lib/createView"
module.exports = createView
  mixins: [
    require("ceri/lib/#if")
    require("ceri/lib/style")
  ]
  structure: template 1, """
    <button class=btn @click=start>Start</button>
    <ceri-progress #ref=progress></ceri-progress>
  """
  initStyle:
    display: "block"
    margin: "20px auto"
    width: "108px"
  methods:
    start: -> 
      @progress.show el: document.body
      setTimeout (=>
        i = setInterval (=>@progress.percent += 10),500
        setTimeout (=> 
          clearInterval(i)
          @progress.hide()
          ), 5500
      ),1000
  tests: (el) ->
    describe "ceri-progress", ->
      after ->
        el.remove()
      it "should work", ->
