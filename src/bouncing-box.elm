module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Window exposing (..)
import Style exposing (..)
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
        boxStyles : List Style
        boxStyles =
            [ backgroundColor "teal"
            , borderColor "grey"
            , borderStyle "solid"
            , borderWidth (px 1)
            , display block
            , Style.width (px 50)
            , Style.height (px 50)
            , fontSize (pc 200)
            , color "white"
            , textAlign "center"
            , position "absolute"
            , top (px 100)
            , left (px model.position)
            ]
    in
        div []
            [ div
                [ class "box"
                , style boxStyles
                , onClick Point
                ]
                [ text (toString model.points) ]
            ]
