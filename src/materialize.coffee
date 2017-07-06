module.exports =
  structure: template 1, """
      <div class="overlay" style="position:absolute;top:0;left:0;right:0;bottom:0;background-color:rgba(0,0,0,0.5);z-index:995">
        <div class="progress" style="position:absolute;top:50%;left:50%;transform: translate(-50%,-50%); width: 200px" >
          <div 
            :class.expr="@percent<0?'indeterminate':'determinate'"
            #ref=percentEl>
          </div>
        </div>
      </div>
      <div
    """
  initStyle:
    opacity: 0
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