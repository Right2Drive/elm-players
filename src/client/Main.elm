module Main exposing (Model, Msg, update, view, subscriptions, init)


import Html exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
    {
    }


-- INIT

init : (Model, Cmd Msg)
init = 
    (Model, Cmd.none)


-- UPDATE

type Msg
    = ReplaceMe

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ReplaceMe ->
            (model, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ text "Create Elm App"
        ]

