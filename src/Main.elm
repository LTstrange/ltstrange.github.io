module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (class, src, alt, href)
import Browser
import Url
import Url.Parser as Parser exposing ((</>), Parser, oneOf)
import Browser.Navigation as Nav
import Html.Attributes exposing (style)


-- MODEL
type Route
  = Home
  | GamePage
  | NotFoundPage

parseRoute : Parser (Route -> c) c
parseRoute = 
  oneOf 
  [ Parser.map Home Parser.top
  , Parser.map GamePage (Parser.s "game")
  ]

type alias Model =
  { key : Nav.Key
  , route : Route
  }

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
  let
    route = case Parser.parse parseRoute url of
     Just r -> r
     Nothing -> NotFoundPage

    model = Model key route
  in
  ( model, Cmd.none )


-- UPDATE
type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    UrlChanged url ->
      let
        route = case Parser.parse parseRoute url of
          Just r -> r
          Nothing -> NotFoundPage
      in
      ( {model| route=route}, Cmd.none )


-- VIEW
view : Model -> Browser.Document Msg
view model =
  case model.route of
    Home ->
      { title = "Home"
      , body =
        [ mainPage
        ]
      }
    GamePage ->
      { title = "Game"
      , body =
        [ gamePage
        ]
      }
    NotFoundPage -> 
      { title = "Not Found"
      , body = [notFoundPage]
      }
  


mainPage : Html msg
mainPage = div [ class "container"] 
    [ header [] 
        [ h1 [] [text "Welcome to my World!"]],
      div [] 
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

gamePage : Html msg
gamePage = div [ class "container"] [h1 [] [text "Game"]]

notFoundPage : Html msg
notFoundPage = div [ class "container"] [ h1 [] [text "Not Found"] ]

-- MAIN
main : Program () Model Msg
main = Browser.application 
    { init = init
    , update = update
    , view = view
    , subscriptions = \_ -> Sub.none
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }