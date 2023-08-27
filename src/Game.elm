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

type alias SvgCache =
    { rock : Html Msg
    , paper : Html Msg
    , scissors : Html Msg
    }

type alias State =
  { left : RPS
  , right : RPS
  }

type alias Model =
  { state : State
  , rolling : Bool
  , count : Int
  , cache : SvgCache
  }

init : (Model, Cmd Msg)
init = 
  ( Model { left = Rock, right = Paper} False 0
    { rock = img [ src "/assets/rps_rock.svg", style "padding" "auto", alt "rock" ] []
    , paper = img [ src "/assets/rps_paper.svg", style "padding" "auto", alt "paper" ] []
    ,  scissors = img [ src "/assets/rps_scissors.svg", style "padding" "auto", alt "scissors" ] [] }
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
    left_svg = rpsToSvg model.state.left model
    right_svg = rpsToSvg model.state.right model
  in
    div [ class "container"] 
      [ h1 [style "font-size" "3em"] [ text "Game - Rock, Paper, Scissors" ]
      , div []
        [ left_svg
        , right_svg
        ]
      , button [onClick StartRolling, style "width" "120px", style "height" "50px", style "margin" "40px"] [ text "Reroll~" ]
      -- cache
      , div [ style "display" "none" ] [model.cache.rock, model.cache.scissors, model.cache.paper]
      ]

rpsToSvg : RPS -> Model -> Html Msg
rpsToSvg rps model
  = case rps of
    Rock -> model.cache.rock
    Paper -> model.cache.paper
    Scissors -> model.cache.scissors



-- SUBSCRIPTION

subscriptions : Model -> Sub Msg
subscriptions model
  = if model.rolling then Time.every 10 Reroll else Sub.none