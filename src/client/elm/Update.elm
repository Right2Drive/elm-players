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

        PlayersMsg playersMsg ->
            let
                ( playersModel, playersCmd ) =
                    updatePlayers playersMsg model.playersModel -- TODO: Refactor
            in
                ( { model | playersModel = playersModel }
                , Cmd.map PlayersMsg playersCmd
                )
        
        EditMsg editMsg ->
            let
                ( editModel, playersCmd ) =
                    updateEdit editMsg model.editModel
            in
                ( { model | editModel = editModel }
                , Cmd.map EditMsg playersCmd
                )
