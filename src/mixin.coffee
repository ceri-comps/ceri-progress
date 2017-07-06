
mixin = null
store = []
get = -> 
  if store.length > 0
    return store.pop()
  else
    return document.createElement "ceri-progress"
restore = (prgs) -> store.push prgs
module.exports = (theme) ->
  unless mixin
    unless window.customElements.get("ceri-progress")
      window.customElements.define "ceri-progress", require("./progress")(theme)
    mixin = 
      _name: "progress"
      _v: 1
      mixins: [
        require "ceri/lib/props"
        ]
      props:
        zIndex:
          type: Number
          default: 995
        timeout:
          type: Number
          default: 500000
      methods:
        $progress: (o) ->
          prgs = get()
          o.zIndex ?= @zIndex
          o.timeout ?= @timeout
          onTimeout = o.onTimeout
          o.onTimeout = ->
            onTimeout?()
            restore(prgs)
          prgs.show o
          return (percent) ->
            if percent? and percent <= 100
              prgs.percent = percent
            else
              prgs.hide()
              restore(prgs)
  return mixin