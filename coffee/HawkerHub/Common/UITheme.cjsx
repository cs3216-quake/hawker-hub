React = require 'react'
mui   = require 'material-ui'

Colors = require 'material-ui/lib/styles/colors'
Spacing = require 'material-ui/lib/styles/spacing'
ColorManipulator = require 'material-ui/lib/utils/color-manipulator'

HawkerHubLightTheme =
  spacing: Spacing
  contentFontFamily: "Helvetica Neue"
  getPalette: ->
    primary1Color: "rgb(185,43,39)"
    primary2Color: Colors.red
    primary3Color: Colors.red
    accent1Color: Colors.red100
    accent2Color: Colors.white
    accent3Color: Colors.white
    textColor: Colors.red900
    canvasColor: "rgb(185,43,39)"
    borderColor: Colors.grey800
    disabledColor: ColorManipulator.fade(Colors.darkBlack, 0.3)
  getComponentThemes: (palette, spacing) ->
    spacing = spacing || Spacing
    obj =
      appBar:
        color: palette.canvasColor
        textColor: palette.textColor
        height: spacing.desktopKeylineIncrement * 0.6
      avatar:
        borderColor: 'rgba(0, 0, 0, 0.08)'
      button:
        height: 36
        minWidth: 88
        iconButtonSize: spacing.iconSize * 2
      checkbox:
        boxColor: palette.textColor
        checkedColor: palette.primary1Color
        requiredColor: palette.primary1Color
        disabledColor: palette.disabledColor
        labelColor: palette.textColor
        labelDisabledColor: palette.disabledColor
      datePicker:
        color: palette.primary1Color
        textColor: Colors.white
        calendarTextColor: palette.textColor
        selectColor: palette.primary2Color
        selectTextColor: Colors.white
      dropDownMenu:
        accentColor: palette.borderColor
      flatButton:
        color: 'transparent'
        textColor: palette.canvasColor
        primaryTextColor: Colors.white
        secondaryTextColor: palette.primary1Color
      floatingActionButton:
        buttonSize: 56
        miniSize: 40
        color: palette.accent2Color
        iconColor: Colors.white
        secondaryColor: palette.primary1Color
        secondaryIconColor: Colors.white
      inkBar:
        backgroundColor: Colors.yellow200
      leftNav:
        width: spacing.desktopKeylineIncrement * 7
        color: Colors.white
      listItem:
        nestedLevelDepth: 18
      menu:
        backgroundColor: Colors.white
        containerBackgroundColor: Colors.white
      menuItem:
        dataHeight: 32
        height: 48
        hoverColor: 'rgba(0, 0, 0, .035)'
        padding: spacing.desktopGutter
        selectedTextColor: palette.accent2Color
      menuSubheader:
        padding: spacing.desktopGutter
        borderColor: palette.borderColor
        textColor: palette.primary1Color
      paper:
        backgroundColor: Colors.white
      radioButton:
        borderColor:  palette.textColor
        backgroundColor: Colors.white
        checkedColor: palette.primary1Color
        requiredColor: palette.primary1Color
        disabledColor: palette.disabledColor
        size: 24
        labelColor: palette.textColor
        labelDisabledColor: palette.disabledColor
      raisedButton:
        color: Colors.white
        textColor: palette.textColor
        primaryColor: palette.accent2Color
        primaryTextColor: Colors.white
        secondaryColor: palette.primary1Color
        secondaryTextColor: Colors.white
      refreshIndicator:
        strokeColor: Colors.grey300
        loadingStrokeColor: palette.primary1Color
      slider:
        trackSize: 2
        trackColor: Colors.minBlack
        trackColorSelected: Colors.grey500
        handleSize: 12
        handleSizeDisabled: 8
        handleColorZero: Colors.grey400
        handleFillColor: Colors.white
        selectionColor: palette.primary3Color
        rippleColor: palette.primary1Color
      snackbar:
        textColor: Colors.white
        backgroundColor: '#323232'
        actionColor: palette.accent1Color
      table:
        backgroundColor: Colors.white
      tableHeader:
        borderColor: palette.borderColor
      tableHeaderColumn:
        textColor: Colors.lightBlack
        height: 56
        spacing: 24
      tableFooter:
        borderColor: palette.borderColor
        textColor: Colors.lightBlack
      tableRow:
        hoverColor: Colors.grey200
        stripeColor: ColorManipulator.lighten(palette.primary1Color, 0.55)
        selectedColor: Colors.grey300
        textColor: Colors.darkBlack
        borderColor: palette.borderColor
      tableRowColumn:
        height: 48
        spacing: 24
      timePicker:
        color: Colors.white
        textColor: Colors.grey600
        accentColor: palette.primary1Color
        clockColor: Colors.black
        selectColor: palette.primary2Color
        selectTextColor: Colors.white
      toggle:
        thumbOnColor: palette.primary1Color
        thumbOffColor: Colors.grey50
        thumbDisabledColor: Colors.grey400
        thumbRequiredColor: palette.primary1Color
        trackOnColor: ColorManipulator.fade(palette.primary1Color, 0.5)
        trackOffColor: Colors.minBlack
        trackDisabledColor: Colors.faintBlack
        labelColor: palette.textColor
        labelDisabledColor: palette.disabledColor
      toolbar:
        backgroundColor: ColorManipulator.darken('#eeeeee', 0.05)
        height: 56
        titleFontSize: 20
        iconColor: 'rgba(0, 0, 0, .40)'
        separatorColor: 'rgba(0, 0, 0, .175)'
        menuHoverColor: 'rgba(0, 0, 0, .10)'
      tabs:
        color: Colors.white
        backgroundColor: 'transparent'
        activeColor: Colors.white
      textField:
        textColor: Colors.white
        hintColor: Colors.white
        floatingLabelColor: palette.textColor
        disabledTextColor: palette.disabledColor
        errorColor: Colors.redA700
        focusColor: Colors.white
        backgroundColor: 'transparent'
        borderColor: Colors.white
    obj.flatButton.disabledTextColor =
      ColorManipulator.fade(obj.flatButton.textColor, 0.3)
    obj.floatingActionButton.disabledColor =
      ColorManipulator.darken(Colors.white, 0.1)
    obj.floatingActionButton.disabledTextColor =
      ColorManipulator.fade(palette.textColor, 0.3)
    obj.raisedButton.disabledColor =
      ColorManipulator.darken(obj.raisedButton.color, 0.1)
    obj.raisedButton.disabledTextColor =
      ColorManipulator.fade(obj.raisedButton.textColor, 0.3)
    obj.slider.handleSizeActive =
      obj.slider.handleSize * 2
    obj.toggle.trackRequiredColor =
      ColorManipulator.fade(obj.toggle.thumbRequiredColor, 0.5)
    obj

ThemeManager = new mui.Styles.ThemeManager()
ThemeManager.setTheme HawkerHubLightTheme

module.exports =
  childContextTypes:
    muiTheme: React.PropTypes.object
  getChildContext: ->
    muiTheme: ThemeManager.getCurrentTheme()
