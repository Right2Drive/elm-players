module View exposing (..)

import Html exposing (..)
import Msgs exposing (Msg)
import Model exposing (Model, Route(PlayersRoute, PlayerRoute, NotFoundRoute))
import Data.Players.Model exposing (PlayerId)
import Pages.Edit.View exposing (editView)
import Pages.List.View exposing (listView)
import Pages.NotFound.View exposing (notFoundView)

view : Model -> Html Msg
view model =
    div []
        [ page model
        ]

page : Model -> Html Msg
page model =
    case model.route of
        PlayersRoute ->
            listView model.playersModel.players

        PlayerRoute id ->
            editView model id

        NotFoundRoute ->
            notFoundView
