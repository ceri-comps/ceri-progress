module.exports =
  mixins: [
    require "ceri/lib/animate"
    require "ceri/lib/watch"
    require "ceri/lib/util"
    require "ceri/lib/structure"
    require "ceri/lib/props"
    require "ceri/lib/style"
    require "ceri/lib/events"
  ]
  events:
    click:
      cbs: ->
      prevent: true
    mousedown:
      cbs: ->
      prevent: true
  props:
    zIndex:
      type: Number
      default: 995
  data: ->
    percent: -2
  initStyle:
    top: 0
    left: 0
    right: 0
    bottom: 0
    position: "absolute"
    display:"block"
  computedStyle: ->
    zIndex: @zIndex
  methods:
    show: (o) ->
      @percent = -1
      o.el.appendChild(@)
      @zIndex = o.zIndex if o.zIndex?
      @animation = @$animate @$cancelAnimation @animation,
        @util.assign {}, @enter, o, {el: @}
      @startTimeout(o)
    hide: ->
      @animation = @$animate @$cancelAnimation @animation,
        @util.assign {el: @, done: -> @remove()}, @leave
      @clearTimeout()
    startTimeout: (o) ->
      o = @timeout if not o and @timeout
      if o?
        o.timeout = 500000 if o.onTimeout and not o.timeout
        if o.timeout
          @timeout = o
          o.object = setTimeout (=>
            o.onTimeout?()
            @hide()
            ), o.timeout
    clearTimeout: ->
      if (o = @timeout)?
        clearTimeout(o.object)
        @timeout = null
  watch:
    percent: 
      initial: false
      cbs:(percent, oldPercent) ->
        el = @percentEl || @
        percent = 100 if percent > 100
        oldPercent = 100 if oldPercent > 100
        @animation2 = @$animate @$cancelAnimation @animation2,
          @util.assign {el: el}, @percentToStyle(percent, oldPercent)
        @startTimeout()
  connectedCallback: ->
    if @percent == -2
      @remove()