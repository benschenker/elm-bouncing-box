module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Window exposing (..)
import Css exposing (..)
import Time exposing (Time, millisecond)


-- import Debug  exposing(log)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { position : Int
    , points : Int
    , speed : Int
    , direction : Int
    , viewWidth : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 30 0 1 1 500, Cmd.none )



-- UPDATE


type Msg
    = Tick Time
    | Point


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            if model.position > model.viewWidth then
                ( { model
                    | direction = -1
                    , position = model.position - model.speed
                  }
                , Cmd.none
                )
            else if model.position < 0 then
                ( { model
                    | direction = 1
                    , position = model.position + model.speed
                  }
                , Cmd.none
                )
            else
                ( { model | position = model.position + model.speed * model.direction }, Cmd.none )

        Point ->
            ( { model
                | points = model.points + 1
                , speed = model.speed + 5
              }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (100 * millisecond) Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        styles =
            Css.asPairs >> Html.Attributes.style

        boxStyles =
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
    in
        div []
            [ div
                [ class "box"
                , boxStyles
                , onClick Point
                ]
                [ Html.text (toString model.points) ]
            ]
