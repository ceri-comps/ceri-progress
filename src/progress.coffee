comp = null
module.exports = (theme) ->
  unless comp
    comp = require "./progress-component"
    comp.mixins.push theme
    comp.structure = theme.structure
    ceri = require "ceri/lib/wrapper"
    comp = ceri(comp)
  return comp
 
