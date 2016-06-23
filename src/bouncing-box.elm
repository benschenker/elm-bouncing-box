import Html exposing (Html, button, div, text)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Style exposing (..)
import Time exposing (Time, millisecond)



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
  , points: Int
  , speed: Int
  , direction: Int
  }

init : (Model, Cmd Msg)
init =
  (Model 30 0 1 1, Cmd.none)



-- UPDATE


type Msg
  = Tick Time


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ({ model | position = model.position + model.speed * model.direction }, Cmd.none)




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
        [ div [class "box", style boxStyles] []
        ]
