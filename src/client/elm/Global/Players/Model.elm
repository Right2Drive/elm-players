module Global.Players.Model exposing (..)

import RemoteData exposing (RemoteData(Loading), WebData)

type alias Model =
    { players : Players
    }

type alias Player =
    { id : PlayerId
    , name  : String
    , level : Int
    }

type alias Players = WebData (List Player)

type alias PlayerId = String

init : Model
init =
    { players = Loading
    }
