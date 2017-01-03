module BoxCss exposing (css, boxWidth)

import Html.Attributes exposing (..)
import Css exposing (..)


styles =
    Css.asPairs >> Html.Attributes.style


boxWidth =
    50


css model =
    styles
        [ backgroundColor (hex "#008080")
        , borderColor (hex "#808080")
        , borderStyle solid
        , Css.property "borderWidth" <| toString (px 1)
        , display block
        , Css.width (px boxWidth)
        , Css.height (px 50)
        , fontSize (pct 200)
        , color (hex "#FFF")
        , textAlign center
        , position absolute
        , top (px 100)
        , left (px (toFloat model.position))
        ]
