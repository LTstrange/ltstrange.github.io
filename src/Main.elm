module Main exposing (main)
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Attributes exposing (src)
-- import Browser


main : Html msg
main = div [ class "container"] 
    [ header [] 
    [ h1 [] [text "Welcome to my World!"]
    ]
    -- Show up
    , section [] 
        [ img [src "./assets/logo.png"] []
        , h3 [] [text "This is LTstrange!"]
        
    -- Info
        , h2 [] [text "Info"]
        , p [] [ text "Email: 835422774@qq.com"]
        ]
    ]