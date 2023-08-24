module Main exposing (main)
import Html exposing (..)
import Html.Attributes exposing (class)
-- import Browser


main = div [ class "container"] [
    header [] [
        h1 [] [text "Welcome to my World!"]
    ],
    section [] [
        p [] [text "This is LTstrange!"]
    ]
    
    ]