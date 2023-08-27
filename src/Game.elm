module Game exposing (Model, Msg, init, view, update, subscriptions)
import Html exposing (..)
import Html.Attributes exposing (src, style, alt, class)
import Html.Events exposing (onClick)
import Random
import Time

-- MODEL

type RPS 
  = Rock
  | Paper
  | Scissors

type alias State =
  { left : RPS
  , right : RPS
  }

type alias Model =
  { state : State
  , rolling : Bool
  , count : Int
  }

init : (Model, Cmd Msg)
init = 
  ( Model { left = Rock, right = Rock} False 0
  , Cmd.none
  )

-- UPDATE

type Msg
  = Reroll Time.Posix
  | Change State
  | StartRolling

update : Msg -> Model -> (Model, Cmd Msg)
update msg model
  = case msg of
      Reroll _ -> if model.count < 100
        then ({model | count = model.count + 1},  Random.generate Change (Random.map2 State roll roll))
        else ({model | rolling = False}, Cmd.none)
      Change s -> ( { model | state=s}, Cmd.none)
      StartRolling -> ( { model | rolling=True, count = 0 }, Cmd.none)

roll : Random.Generator RPS
roll = Random.uniform Rock [Paper , Scissors]

-- VIEW

view : Model -> Html Msg
view model =
  let
    left_src = rpsToPath model.state.left
    right_src = rpsToPath model.state.right
  in
    div [ class "container"] 
      [ h1 [style "font-size" "3em"] [ text "Game - Rock, Paper, Scissors" ]
      , div []
        [ img [ src ("/assets/" ++ left_src), style "padding" "auto", alt left_src ] []
        , img [ src ("/assets/" ++ right_src), style "padding" "auto", alt right_src ] []
        ]
      , button [onClick StartRolling, style "width" "120px", style "height" "50px", style "margin" "40px"] [ text "Reroll~" ]
      ]

rpsToPath : RPS -> String
rpsToPath rps
  = case rps of
    Rock -> "rps_rock.svg"
    Paper -> "rps_paper.svg"
    Scissors -> "rps_scissors.svg"



-- SUBSCRIPTION

subscriptions : Model -> Sub Msg
subscriptions model
  = if model.rolling then Time.every 10 Reroll else Sub.none