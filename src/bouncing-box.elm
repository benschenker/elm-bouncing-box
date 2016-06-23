import Html exposing (Html, button, div, text)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Style exposing (..)
import Time exposing (Time, second)



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { top : Int
  , left : Int
  }

init : (Model, Cmd Msg)
init =
  (Model 100 30, Cmd.none)



-- UPDATE


type Msg
  = Tick Time


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ({ model | left = model.left + 10 }, Cmd.none)




-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick



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
      , top (px model.top)
      , left (px model.left)
      ]
  in
      div []
        [ div [class "box", style boxStyles] []
        ]
