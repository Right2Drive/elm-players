module Msgs exposing (Msg(..))

import Navigation exposing (Location)
import Dom exposing (Error)

import Data.Players.Msgs exposing (PlayersMsg(..))
import Pages.Edit.Msgs exposing (EditMsg(..))

type Msg
    = OnLocationChange Location
    | NoOp
    | PlayersMsg PlayersMsg
    | EditMsg EditMsg
    | DomTask (Result Error ()) -- TODO: Learn more about this
