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
    timeout:
      type: Number
      default: 5000
  data: ->
    percent: -2
    options: null
  initStyle:
    top: 0
    left: 0
    right: 0
    bottom: 0
    position: "absolute"
    display:"block"
  computedStyle: 
    this: -> 
      zIndex: if @options?.zIndex? then @options.zIndex else @zIndex
  methods:
    show: (o) ->
      @percent = -1
      o.el.appendChild(@)
      @options = o
      @animation = @$animate @$cancelAnimation @animation,
        @util.assign {}, @enter, o, {el: @}
      @startTimeout(o)
    hide: ->
      @animation = @$animate @$cancelAnimation @animation,
        @util.assign {el: @, done: -> @remove()}, @leave
      @clearTimeout()
      @options = null
    startTimeout: (o) ->
      if (o ?= @options)?
        @clearTimeout(o)
        o.timeout ?= @timeout or 5000 if o.onTimeout
        if o.timeout
          o.clearTimeout = setTimeout (=>
            o.onTimeout?()
            @hide()
            ), o.timeout
    clearTimeout: (o) ->
      if (o ?= @options)?.clearTimeout?
        clearTimeout(o.clearTimeout)
        o.clearTimeout = null
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