module Game exposing (Model, Msg, init, view, update, subscriptions)
import Html exposing (..)
import Html.Attributes exposing (src, style, alt, class)
import Html.Events exposing (onClick)
import Random
import Time
import String exposing (left)

-- MODEL

type RPS 
  = Rock
  | Paper
  | Scissors

rpsToString : RPS -> String
rpsToString rps = case rps of
  Rock -> "rock"
  Paper -> "paper"
  Scissors -> "scissors"

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
  ( Model { left = Rock, right = Paper} False 0
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
      Reroll _ -> if model.count < 200
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
    left =  rpsToString model.state.left
    right = rpsToString model.state.right
  in
    div [ class "container"] 
      [ h1 [style "font-size" "3em"] [ text "Game - Rock, Paper, Scissors" ]
      , div []
        [ img [ src ("/assets/rps_" ++ left ++ ".svg"), style "padding" "auto", alt left ] [] 
        , img [ src ("/assets/rps_" ++ right ++ ".svg"), style "padding" "auto", alt right ] [] 
        ]
      , button
        [ onClick StartRolling
        , style "border-radius" "10px"
        , style "border" "5px #3f3f3f solid"
        , style "width" "120px"
        , style "height" "50px"
        , style "margin" "40px"
        , style "font-size" "2em" 
        ] [ text "Reroll~" ]
      -- cache
      , div [ style "display" "none" ] 
        [ img [ src "/assets/rps_rock.svg", style "padding" "auto", alt "rock" ] []
        , img [ src "/assets/rps_paper.svg", style "padding" "auto", alt "paper" ] []
        , img [ src "/assets/rps_scissors.svg", style "padding" "auto", alt "scissors" ] []
        ]
      ]




-- SUBSCRIPTION

subscriptions : Model -> Sub Msg
subscriptions model
  = if model.rolling then Time.every 10 Reroll else Sub.none