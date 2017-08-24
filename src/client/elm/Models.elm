module Models exposing (..)

import RemoteData exposing (WebData)

type alias Model =
    { players : Players
    , route : Route
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

type alias Players = WebData (List Player)


initialModel : Route -> Model
initialModel route =
    { players = RemoteData.Loading
    , route = route
    }
