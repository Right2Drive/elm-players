module Global.Players.Msgs exposing (Msg(..))

import RemoteData exposing (WebData)
import Http exposing (Error)
import Global.Players.Model exposing (..)

type Msg
    = OnFetchPlayers (WebData (List Player))
    | ChangeLevel Int Player
    | OnPlayerSave (Result Error Player)
    | ChangeName String Player
