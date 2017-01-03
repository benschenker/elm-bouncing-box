module BoxCss exposing (boxCss)

import Html.Attributes exposing (..)
import Css exposing (..)


styles =
    Css.asPairs >> Html.Attributes.style


boxCss model =
    styles
        [ backgroundColor (hex "#008080")
        , borderColor (hex "#808080")
        , borderStyle solid
        , Css.property "borderWidth" <| toString (px 1)
        , display block
        , Css.width (px 50)
        , Css.height (px 50)
        , fontSize (pct 200)
        , color (hex "#000000")
        , textAlign center
        , position absolute
        , top (px 100)
        , left (px (toFloat model.position))
        ]