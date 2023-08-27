module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (class, src, alt, href)
import Browser
import Url
import Url.Parser as Parser exposing ((</>), Parser, oneOf)
import Browser.Navigation as Nav
import Html.Attributes exposing (style)
import Game


-- ROUTE
type Route
  = HomePage
  | GamePage
  | NotFoundPage

parseRoute : Parser (Route -> c) c
parseRoute = 
  oneOf 
  [ Parser.map HomePage Parser.top
  , Parser.map GamePage (Parser.s "game")
  ]

parseUrl: Url.Url -> Route
parseUrl url = case Parser.parse parseRoute url of
  Just r -> r
  Nothing -> NotFoundPage

routeToSubModel: Route -> (SubModel, Cmd Msg)
routeToSubModel route = case route of
      HomePage -> (HomeModel, Cmd.none)
      GamePage -> 
        let
          (game_model, game_cmd) = Game.init
        in 
          (GameModel game_model, Cmd.map GotGameMsg game_cmd)
      NotFoundPage -> (NotFoundModel, Cmd.none)

-- MODEL

type SubModel
  = GameModel Game.Model
  | HomeModel
  | NotFoundModel

type alias Model =
  { key : Nav.Key
  , subModel : SubModel
  }

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
  let
    (subModel, c) = routeToSubModel (parseUrl url)
  in
    ( Model key subModel, c )


-- UPDATE
type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url
  | GotGameMsg Game.Msg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case (msg, model.subModel) of

  -- LinkClicked
    (LinkClicked urlRequest, _) ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )
        Browser.External href ->
          ( model, Nav.load href )

    -- UrlChanged
    (UrlChanged url, _) ->
      let
        (submodel, cmd) =  routeToSubModel (parseUrl url)
      in
      ( {model| subModel = submodel}, cmd )

    -- Message Handling
    (GotGameMsg gameMsg, GameModel m) -> 
      let 
        (newM, c) = Game.update gameMsg m 
        cmd = Cmd.map GotGameMsg c
      in
        ({ model | subModel = (GameModel newM )}, cmd)

    -- Ignore when message not match model
    (_, _) -> (model, Cmd.none)


-- VIEW
view : Model -> Browser.Document Msg
view model =
  case model.subModel of
    HomeModel ->
      { title = "Home"
      , body = [ mainPage ]
      }
    GameModel gameModel ->
      { title = "Game"
      , body = [ gamePage gameModel ]
      }
    NotFoundModel -> 
      { title = "Not Found"
      , body = [notFoundPage]
      }

mainPage : Html msg
mainPage = 
  div [ class "container"] 
    [ header [] [ h1 [] [text "Welcome to my World!"]]
    , div [] 
      -- Show up
      [ img [src "/assets/logo.svg", alt "logo"] []
      , h3 [] [text "This is LTstrange!"]
      , h4 [] [ text "Welcome to my website!"]
      , p [] [ text " where I explore a world of coding, game development, language design, and operating systems."]
      , p [] [ text "I am good at languages like C, C#, Rust, and Python,"]
      , p [] [ text "and I've even crafted my own programming language called Siren."]
      , p [] [ text "Check out my " , a [ href "https://github.com/LTstrange"] [ text "github repository"] ,text"!"]

      -- Links
      , h2 [] [ text "Links"]
      , a [ href "/game"] [ text "game"]

      -- Info
      , h2 [] [text "Info"]
      , p [] [ text "Email: 835422774@qq.com"]
      , p [ style "font-size" "7px"] [ text "This website is built by elm"]
      ]
    ]

gamePage : Game.Model -> Html Msg
gamePage gameModel = Game.view gameModel |> Html.map GotGameMsg

notFoundPage : Html msg
notFoundPage = div [ class "container"] [ h1 [] [text "Not Found"] ]


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
  case model.subModel of
    GameModel game_model -> Game.subscriptions game_model |> Sub.map GotGameMsg
    HomeModel -> Sub.none
    NotFoundModel -> Sub.none

-- MAIN
main : Program () Model Msg
main = Browser.application 
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }