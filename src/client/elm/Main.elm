module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)
import Commands exposing (fetchPlayers)


init : ( Model, Cmd Msg )
init =
    ( initialModel, fetchPlayers )


-- MAIN

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
