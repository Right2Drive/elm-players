module Data.Players.Update exposing (..)

import Data.Players.Msgs exposing (PlayersMsg(..))
import Data.Players.Model exposing (PlayersModel, Player)
import Data.Players.Commands exposing (savePlayerCmd)
import RemoteData

updatePlayers : PlayersMsg -> PlayersModel -> ( PlayersModel, Cmd PlayersMsg )
updatePlayers msg model =
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


updatePlayer : PlayersModel -> Player -> PlayersModel
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
