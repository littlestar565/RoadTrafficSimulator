'use strict'

define ->
  class LanePosition
    constructor: (@car, @_lane, @position) ->
      @id = window.__nextId++
      @free = true

    @property 'lane',
      get: -> @_lane
      set: (lane) ->
        @release()
        @_lane = lane
        @acquire()

    @property 'relativePosition',
      get: -> @position/@lane.length()

    acquire: ->
      if @lane and @lane.addCarPosition?
        @free = false
        @lane.addCarPosition @

    release: ->
      if not @free and @lane and @lane.removeCar
        @free = true
        @lane.removeCar @

    getNext: ->
      return @lane.getNext @ if @lane and not @free

    getDistanceToNextCar: ->
      next = @getNext()
      return next.position - @position if next?
      return Infinity
