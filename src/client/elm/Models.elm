module Models exposing (..)

import RemoteData exposing (WebData)

type alias Model =
    { players : WebData (List Player)
    }

type alias Player =
    { id : PlayerId
    , name  : String
    , level : Int
    }

type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute


type alias PlayerId = String

initialModel : Model
initialModel =
    { players = RemoteData.Loading
    }
