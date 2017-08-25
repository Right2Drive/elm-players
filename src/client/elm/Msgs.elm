module Msgs exposing (Msg(..))

import Navigation exposing (Location)

import Global.Players.Msgs as PlayersMsgs exposing (Msg(..))
import Pages.Edit.Msgs as EditMsgs exposing (Msg(..))

type Msg
    = OnLocationChange Location
    | PlayersMsg PlayersMsgs.Msg
    | EditMsg EditMsgs.Msg
