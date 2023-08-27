module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (class, src, alt, href)
import Browser
import Url
import Browser.Navigation as Nav


-- MODEL
type alias Model =
  { key : Nav.Key
  , url : Url.Url
  }

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key = ( Model key url, Cmd.none )


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
      ( { model | url = url }
      , Cmd.none
      )


-- VIEW
view : Model -> Browser.Document Msg
view model =
  { title = "URL Interceptor"
  , body =
      [ mainPage
      ]
  }


mainPage : Html msg
mainPage = div [ class "container"] 
    [ header [] 
        [ h1 [] [text "Welcome to my World!"]
        
        -- Show up
        , img [src "./assets/logo.svg", alt "logo"] []
        , h3 [] [text "This is LTstrange!"]
        , h4 [] [ text "Welcome to my website!"]
        , p [] [ text " where I explore a world of coding, game development, language design, and operating systems."]
        , p [] [ text "I am good at languages like C, C#, Rust, and Python,"]
        , p [] [ text "and I've even crafted my own programming language called Siren."]
        , p [] [ text "Check out my " , a [ href "https://github.com/LTstrange"] [ text "github repository"] ,text"!"]
        
        -- Info
        , h2 [] [text "Info"]
        , p [] [ text "Email: 835422774@qq.com"]
        ]
    ]


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