module Pages.NotFound.View exposing (notFoundView)

import Html exposing (..)

import Msgs exposing (Msg)

-- TODO: This should be moved into data or rendered in routing
notFoundView : Html Msg
notFoundView =
    div [] [ text "Not Found!" ]
