module Global.Players.Update exposing (..)

import Global.Players.Msgs exposing (Msg(..))
import Global.Players.Model exposing (Model, Player)
import Global.Players.Commands exposing (savePlayerCmd)
import RemoteData

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        ChangeLevel howMuch player ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch}
            in
                ( model, savePlayerCmd updatedPlayer )
        
        OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        OnPlayerSave (Err err) ->
            ( model, Cmd.none )

        ChangeName name player ->
            let
                updatedPlayer =
                    { player | name = name }
            in
                ( model, savePlayerCmd updatedPlayer )


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer
        
        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }
