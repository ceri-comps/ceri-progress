# ceri-progress

A simple progress bar with included overlay.

### [Demo](https://ceri-comps.github.io/ceri-progress)


# Install

```sh
npm install --save-dev ceri-progress
```
## Usage

```coffee
Progress = require("ceri-progress")
# load the theme (see below)
window.customElements.define("ceri-progress", Progress(require("ceri-progress/materialize")))
progress = document.createElement("ceri-progress")
# block document.body with indetermined progress bar
progress.show({el:document.body, timeout: 5000, onTimeout: => return})
# change to determined progress bar with 10 percent progress
progress.percent = 10
# hide again
progress.hide()
```

## Mixin

the progress bar can be used as a mixin within other ceri components:
```coffee
  ...
  mixins: [
    require("ceri-progress/mixin")(require("ceri-progress/materialize"))
  ]
  ...
  methods:
    doSomething: ->
      setPercent = @$progress({el:this})
      setPercent(50)
      setPercent() # close
```

## Themes
#### Materialize
- setup [ceri-materialize](https://github.com/ceri-comps/ceri-materialize) and load the scss.
```scss
// and this additional requirement
@import "~ceri-progress/materialize";
```
- load theme file
```coffee
Progress = require("ceri-progress")
window.customElements.define("ceri-progress", Progress(require("ceri-progress/materialize")))
```

For example see [`dev/materialize`](dev/materialize.coffee).

# Development
Clone repository.
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## Notable changes
#### 0.2.0
- use ceri-materialize@2

## License
Copyright (c) 2017 Paul Pflugradt
Licensed under the MIT license.
