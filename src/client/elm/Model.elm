module Model exposing (..)

import Global.Players.Model exposing (PlayersModel, initPlayers, PlayerId)
import Pages.Edit.Model as EditModel exposing (EditModel, initEdit)


type alias Model =
    { route : Route
    , playersModel : PlayersModel
    , editModel : EditModel
    }


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute


initialModel : Route -> Model
initialModel route =
    { route = route
    , playersModel = initPlayers
    , editModel = initEdit
    }
