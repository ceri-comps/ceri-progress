module.exports =
  structure: template 1, """
    <div class="overlay" #ref=overlay>
      <div class="progress" style="position:absolute;top:50%;left:50%;transform: translate(-50%,-50%); width: 200px" >
        <div 
          :class.expr="@percent<0?'indeterminate':'determinate'"
          #ref=percentEl>
        </div>
      </div>
    </div>
  """
  props:
    opacity:
      type: Number
      default: 0.5
    whiteout:
      type: Boolean
  initStyle:
    this:
      opacity: 0
    overlay:
      position: "absolute"
      top: 0
      left: 0
      right: 0
      bottom: 0
  computedStyle:
    overlay: ->
      if (o = @options)?
        o.whiteout ?= @whiteout
        if o.whiteout
          bgC = "#FFF"
        else
          o.opacity ?= @opacity
          bgC = "rgba(0,0,0,#{o.opacity})"
        return backgroundColor: bgC
      return {}
  data: ->
    enter:
      style:
        opacity: [0,1]
      duration: 100
    leave:
      style:
        opacity: [1, 0]
      duration: 200
  methods:
    percentToStyle: (percent, oldPercent) -> style: width: [oldPercent, percent, "%"]