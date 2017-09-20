module Update exposing (..)

import Msgs exposing (Msg(..))
import Model exposing (Model)
import Data.Players.Update exposing (updatePlayers)
import Pages.Edit.Update exposing (updateEdit)
import Routing exposing (parseLocation)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute = parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none)

        NoOp ->
            ( model, Cmd.none )

        PlayersMsg playersMsg ->
            updatePlayers playersMsg model

        EditMsg editMsg ->
            updateEdit editMsg model

        DomTask result ->
            ( model, Cmd.none )
