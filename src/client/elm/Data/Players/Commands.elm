module Data.Players.Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Encode as Encode
import RemoteData exposing (WebData)

import Msgs exposing (Msg(..))
import Json.Decode.Pipeline exposing (decode, required)
import Data.Players.Msgs exposing (PlayersMsg(..))
import Data.Players.Model exposing (PlayerId, Player)


fetchPlayers : Cmd Msg
fetchPlayers =
    Http.get fetchPlayersUrl playersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map convertMsg


convertMsg : (WebData (List Player)) -> Msg
convertMsg data =
    data
        |> OnFetchPlayers
        |> PlayersMsg


savePlayerUrl : String -> String
savePlayerUrl playerId =
    "http://localhost:4000/players/" ++ playerId


savePlayerRequest : Player -> Http.Request Player
savePlayerRequest player =
    Http.request
        { body = playerEncoder player |> Http.jsonBody
        , expect = Http.expectJson playerDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = savePlayerUrl player.id
        , withCredentials = False
        }


savePlayerCmd : Player -> Cmd PlayersMsg
savePlayerCmd player =
    if validatePlayerName player.name then
        Cmd.none

    else
        savePlayerRequest player
            |> Http.send OnPlayerSave


validatePlayerName : String -> Bool
validatePlayerName playerName =
    not (String.isEmpty playerName || String.length playerName > 32)


fetchPlayersUrl : String
fetchPlayersUrl =
    "http://localhost:4000/players"


playerEncoder : Player -> Encode.Value
playerEncoder player =
    let
        attributes =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        Encode.object attributes



playersDecoder : Decode.Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder


playerDecoder : Decode.Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "level" Decode.int
