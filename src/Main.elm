module Main exposing (main)
import Html exposing (..)
import Html.Attributes exposing (class, src, alt, href)
import Browser


-- MAIN
main : Program () Model Msg
main = Browser.element {init=init, update=update, view=view, subscriptions=subscriptions}


-- MODEL
type Model = Home

init : () -> (Model, Cmd msg)
init _ = (Home, Cmd.none)


-- UPDATE
type Msg = None

update : Msg -> Model -> (Model, Cmd msg)
update msg model = (model, Cmd.none)


-- VIEW
view : Model -> Html Msg
view model =
    mainPage

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


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none