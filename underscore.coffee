window._ = {}

### Collections ###

_.each = _.forEach = (collection, callback, context) ->
  if Array.isArray collection
    callback.call context, item, index, collection for item, index in collection
  else
    callback.call context, item, key, collection for key, item of collection

### Arrays ###

### Arrays ###

### Functions ###

### Objects ###

### Cross Document ###

### Utility ###

### Chaining ###

_.identity = (val) ->
  val

_.first = (array, n) ->
  if n? then array.slice 0, n else array[0]

_.last = (array, n) ->
  if n > array.length
    return array
  if n? then array.slice array.length - n, array.length else array[array.length - 1]


_.indexOf = (array, target) ->
  result = -1
  _.each array, (item, index) ->
    if item is target and result is -1
      result = index
  result

_.filter = (collection, test) ->
  results = []
  _.each collection, (item) ->
    if test item
      results.push item
  results

_.reject = (collection, test) ->
  _.filter collection, (item) ->
    !test item

_.uniq = (array) ->
  results = []
  _.each array, (item) ->
    if _.indexOf(results, item) is -1
      results.push item
  results

_.map = (collection, iterator) ->
  results = []
  _.each collection, (item) ->
    results.push iterator item
  results

_.pluck = (collection, key) ->
  _.map collection, (item) ->
    item[key]

_.reduce = (collection, iterator, accumulator) ->
  if !accumulator?
    accumulator = collection.shift();
  _.each collection, (item) ->
    accumulator = iterator accumulator, item
  accumulator

_.contains = (collection, target) ->
  if _.indexOf(collection, target) is -1 then false else true

_.every = (collection, iterator) ->
  iterator = iterator or _.identity
  !!_.reduce collection, (accumulator, value) ->
    accumulator and iterator value
  , true

_.some = (collection, iterator) ->
  iterator = iterator or _.identity
  !_.every collection, (value) ->
    !iterator value

_.extend = (obj) ->
  args = Array.prototype.slice.call arguments
  _.each args, (arg) ->
    _.each arg, (item, key) ->
      obj[key] = item
  obj

_.defaults = (obj) ->
  args = Array.prototype.slice.call arguments
  _.each args, (arg) ->
    _.each arg, (item, key) ->
      if !obj[key]? then obj[key] = item
  obj

_.once = (func) ->
  alreadyCalled = false
  result = undefined
  ->
    if !alreadyCalled
      result = func.apply(this, arguments)
      alreadyCalled = true
    result

_.memoize = (func) ->
  cache = {}
  ->
    args = Array.prototype.slice.call arguments
    if !cache[args]?
      cache[args] = func.apply null, args
    cache[args]

_.delay = (func, wait) ->
  args = Array.prototype.slice.call arguments, 2
  setTimeout ->
    func.apply this, args
  , wait

_.shuffle = (array) ->
  used = []
  while used.length < array.length
    ran = Math.floor Math.random() * array.length
    if !_.contains used, ran then used.push ran
  shuffled = []
  _.each used, (item) ->
    shuffled.push array[item]
  if shuffled.join() is array.join() then _.shuffle(array) else shuffled
