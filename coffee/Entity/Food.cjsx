$          = require 'jquery'
_          = require 'lodash'
URL        = require 'url'
App        = require 'ampersand-app'
Collection = require 'ampersand-rest-collection'
Model      = require 'ampersand-model'
Reflux     = require 'reflux'

FoodAction = Reflux.createActions ['create', 'fetch', 'fetchUser', 'reset']

Food = Model.extend
  url: -> App.urlFor 'item'
  idAttribute: 'itemId'
  props:
    'itemId': 'string'
    'addedDate': 'any'
    'itemName': 'string'
    'photoURL': 'string'
    'caption': 'string'
    'longitude': 'string'
    'latitude': 'string'
    'userId': 'string'
  derived:
    name: ->
      deps: ['itemName']
      fn: -> @itemName

foods = new Collection [], { model: Food }

FoodStore = Reflux.createStore
  listenables: FoodAction

  onCreate: (options) ->
    newFood = new Food options
    newFood.save()
    foods.add newFood
    @trigger { name: 'created', value: newFood }

  onFetch: (options) ->
    { orderBy, limit, startAt } = options
    orderBy = orderBy or 'id'
    limit = limit or 3
    startAt = startAt or foods.length
    App.withLocation (latitude, longitude) =>
      url = App.urlFor 'item', {orderBy, limit, startAt, latitude, longitude}
      $.ajax
        type: 'GET'
        dataType: 'json'
        crossOrigin: true
        url: url
        success: (data) =>
          newFood = _.map data, (datum) => new Food datum
          foods.add newFood
          @trigger { name: 'fetched', value: newFood }

  onFetchUser: (userId) ->
    base = App.urlFor 'users'
    url = URL.resolve base, '/users/#{userId}/recent'
    $.ajax
      type: 'GET'
      dataType: 'json'
      crossOrigin: true
      url: url
      success: (data) =>
        newFood = _.map data.data, (datum) => new Food datum
        foods.add newFood
        @trigger { name: 'fetched', value: newFood }

module.exports = { FoodAction, FoodStore }
