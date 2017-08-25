module Msgs exposing (..)

import Models exposing (Player)
import RemoteData exposing (WebData)
import Navigation exposing (Location)
import Http exposing (Error)

type Msg
    = OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
    | ChangeLevel Int Player
    | OnPlayerSave (Result Error Player)
    | EditName
    | ChangeName String Player
