module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Window exposing (..)
import BoxCss exposing (boxCss)
import Time exposing (Time, millisecond)
import Task


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
    , size : Window.Size
    }


init : ( Model, Cmd Msg )
init =
    ( Model 30 0 1 1 (Window.Size 0 0), Task.perform Resize Window.size )



-- UPDATE


type Msg
    = Tick Time
    | Point
    | Resize Window.Size


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            if model.position > model.size.width then
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

        Resize newSize ->
            ( { model | size = newSize }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every (100 * millisecond) Tick
        , Window.resizes Resize
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div
            [ boxCss model
            , onClick Point
            ]
            [ Html.text (toString model.points) ]
        ]
