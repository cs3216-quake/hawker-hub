_        = require 'lodash'
React    = require 'react'
Layout   = (require 'react-grid-layout').Responsive
PureRenderMixin =
  require 'react/lib/ReactComponentWithPureRenderMixin'
UI       = require 'material-ui'
UITheme  = require '../Common/UITheme'
FoodCard = require './FoodCard'

# Default Layout
# 3 items per row same width
DefaultLayout = (items) ->
  _.map items, (value, idx) ->
    { x: (idx * 4) % 12, y: idx, w: 4, h: 1, i: idx}

# Mobile Layout (1 item per row)
MobileLayout = (items) ->
  _.map items, (value, idx) ->
    { x: idx, y: idx, w: 12, h: 1, i: idx}

module.exports = React.createClass
  mixins: [UITheme]
  getInitialProps:
    items: []
  getInitialState: ->
    foods: []
    activeFilter: () -> true
  render: ->
    items = _.map @props.items, (value, idx) =>
      <UI.Paper zDepth={1} key={idx} className="food-card">
        <FoodCard handleMoreClick={@props.handleMoreClick} />
      </UI.Paper>
    layouts =
      lg: DefaultLayout(items)
      md: DefaultLayout(items)
      sm: DefaultLayout(items)
      xs: MobileLayout(items)
      xxs: MobileLayout(items)
    <Layout className="limit-width"
            onLayoutChange={->}
            isDraggable={false}
            layouts={layouts}
            breakpoints={{lg:1200, md:996, sm: 768, xs: 400, xxs: 0}}
            cols={{lg: 12, md: 12, sm: 8, xs: 1, xxs: 1}}
            rowHeight={350}>
      {items}
    </Layout>
