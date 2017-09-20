module Data.Players.Update exposing (updatePlayers)

import RemoteData

import Msgs exposing (Msg)
import Model exposing (Model)
import Data.Players.Msgs exposing (PlayersMsg(..))
import Data.Players.Model exposing (PlayersModel, Player, Players)
import Data.Players.Commands exposing (savePlayerCmd)

updatePlayers : PlayersMsg -> Model -> ( Model, Cmd Msg )
updatePlayers msg model =
    update msg model model.playersModel


update : PlayersMsg -> Model -> PlayersModel -> ( Model, Cmd Msg )
update msg model playersModel =
    case msg of
        OnFetchPlayers response ->
            ( setPlayers model response, Cmd.none )

        ChangeLevel howMuch player ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
                ( model, savePlayerCmd updatedPlayer )

        OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        OnPlayerSave (Err err) ->
            ( model, Cmd.none )

        ChangeName player name ->
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
            RemoteData.map updatePlayerList model.playersModel.players
    in
        setPlayers model updatedPlayers


setPlayers : Model -> Players -> Model
setPlayers model players =
    let
        playersModel =
            model.playersModel

        newPlayersModel =
            { playersModel | players = players }

    in
        { model | playersModel = newPlayersModel }


