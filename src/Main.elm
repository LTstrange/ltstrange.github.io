module Main exposing (main)
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Attributes exposing (src, alt)
import Html.Attributes exposing (href)
-- import Browser


main : Html msg
main = div [ class "container"] 
    [ header [] 
        [ h1 [] [text "Welcome to my World!"]
        
        -- Show up
        , img [src "./assets/logo.svg", alt "logo"] []
        , h3 [] [text "This is LTstrange!"]
        , h4 [] [ text "Welcome to my website!"]
        , p [] [ text " where I explore a world of coding, game development, language design, and operating systems."]
        , p [] [ text "I am good at languages like C, C#, Rust, and Python,"]
        , p [] [ text "and I've even crafted my own programming language called Siren."]
        , p [] [ text "Check out my github repository!"]
        -- , a [] [ href "https://github.com/"]
        -- Info
        , h2 [] [text "Info"]
        , p [] [ text "Email: 835422774@qq.com"]
        ]
    ]