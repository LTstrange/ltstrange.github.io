module Main exposing (main)
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Attributes exposing (src, alt)
-- import Browser


main : Html msg
main = div [ class "container"] 
    [ header [] 
        [ h1 [] [text "Welcome to my World!"]
        
        -- Show up
        , img [src "./assets/logo.svg", alt "logo"] []
        , h3 [] [text "This is LTstrange!"]
        ,p [] [text "welcome to my website!"]
        
        -- Info
        , h2 [] [text "Info"]
        , p [] [ text "Email: 835422774@qq.com"]
        ]
    ]