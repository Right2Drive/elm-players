module View exposing (..)

import Html exposing (..)
import Msgs exposing (Msg)
import Model exposing (Model, Route(PlayersRoute, PlayerRoute, NotFoundRoute))
import Data.Players.Model exposing (PlayerId)
import Pages.Edit.View exposing (editView)
import Pages.List.View exposing (listView)
import RemoteData exposing (RemoteData(NotAsked, Loading, Failure, Success))

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
            playerEditPage model id

        NotFoundRoute ->
            notFoundView


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    case model.playersModel.players of
        NotAsked ->
            text ""

        Loading ->
            text "Loading ..."

        Failure err ->
            text (toString err)
        
        Success players ->
            let
                maybePlayer =
                    players
                        |> List.filter(\player -> player.id == playerId)
                        |> List.head
            in
                case maybePlayer of
                    Just player ->
                        editView player

                    Nothing ->
                        notFoundView


notFoundView : Html msg
notFoundView =
    div [] [ text "Not Found!" ]
