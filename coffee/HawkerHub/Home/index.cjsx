_       = require 'lodash'
React   = require 'react'
UI      = require 'material-ui'
UITheme = require '../Common/UITheme'
LabeledButton = require '../Common/LabeledButton'
FoodCardList = require '../Food/FoodCardList'
Navbar = require '../Navbar'
AddItem = require '../AddItem'
{ User, UserStore } = require '../../Entity/User'
{ FilterStore, FilterAction } = require '../../Entity/Filter'
{ FoodStore } = require '../../Entity/Food'

module.exports = React.createClass
  mixins: [UITheme]
  getInitialState: ->
    name: null
    heading: ""
    addItemShown: false
    hasLoggedIn: true
    singleView: false
  componentWillReceiveProps: (nextProps) ->
    sameFilter = @props.query.filter is nextProps.query.filter
    if (not sameFilter) then FilterAction.change { name: nextProps.query.filter }
  componentWillMount: ->
    FilterStore.listen (filter) =>
      @setState { heading: filter.heading() }
    UserStore.listen (e) =>
      switch e
        when 'hub_logout_success'
          location.reload()
          @setState { name: null, hasLoggedIn: false }
        when 'fb_login_success'
          @setState { name: User.name }
    FoodStore.listen (event) =>
      if event.name is 'created' then @setState { addItemShown: false }
  componentDidMount: ->
    singleView = false
    if @props.params && @props.params.id && !@props.params.query
      FilterAction.change { name: 'single', arg: @props.params.id }
      singleView = true
    else
      FilterAction.change { name: (@props.query.filter or 'latest') }
    @setState { singleView }
  showAddItem: -> @setState { addItemShown: true }
  hideAddItem: -> @setState { addItemShown: false }
  render: ->
    buttonShown =
      if !@state.addItemShown
        <LabeledButton style={{'float':'right'}} label="Add Item" icon="add" onClick={@showAddItem} />
      else
        <LabeledButton style={{'float':'right'}} label="Close" icon="close" onClick={@hideAddItem} />
    <div className="container">
      {
        if (@state.hasLoggedIn && !@state.singleView)
          <div className="row context-bar">
            <div className="ten columns">
              <h1>{@state.heading}</h1>
            </div>
            <div className="two columns">{ buttonShown }</div>
          </div>
      }
      { if (@state.addItemShown) then <AddItem ref="addItem" /> }
      { if (@state.hasLoggedIn)
          <FoodCardList singleView={@state.singleView}/> }
    </div>
