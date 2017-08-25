module Update exposing (..)

import Msgs exposing (Msg(..))
import Model exposing (Model)
import Global.Players.Update as PlayersUpdate exposing (update)
import Pages.Edit.Update as EditUpdate exposing (update)
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
                    PlayersUpdate.update playersMsg model.playersModel -- TODO: Refactor
            in
                ( { model | playersModel = playersModel }
                , Cmd.map PlayersMsg playersCmd
                )
        
        EditMsg editMsg ->
            let
                ( editModel, playersCmd ) =
                    EditUpdate.update editMsg model.editModel
            in
                ( { model | editModel = editModel }
                , Cmd.map EditMsg playersCmd
                )
