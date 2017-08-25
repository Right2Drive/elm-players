module Model exposing (..)

import Global.Players.Model as PlayersModel exposing (Model, init, PlayerId)
import Pages.Edit.Model as EditModel exposing (Model, init)


type alias Model =
    { route : Route
    , playersModel : PlayersModel.Model
    , editModel : EditModel.Model
    }


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute


initialModel : Route -> Model
initialModel route =
    { route = route
    , playersModel = PlayersModel.init
    , editModel = EditModel.init
    }
