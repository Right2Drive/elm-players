module Main exposing (..)

import Navigation exposing (Location)

import Msgs exposing (Msg(..))
import Model exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)
import Routing exposing (parseLocation)
import Global.Players.Commands exposing (fetchPlayers)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            parseLocation location
    in
        ( initialModel currentRoute
        , fetchPlayers
        )


-- MAIN


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
