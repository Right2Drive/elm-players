module Global.Players.Msgs exposing (PlayersMsg(..))

import RemoteData exposing (WebData)
import Http exposing (Error)
import Global.Players.Model exposing (Player)

type PlayersMsg
    = OnFetchPlayers (WebData (List Player))
    | ChangeLevel Int Player
    | OnPlayerSave (Result Error Player)
    | ChangeName String Player
