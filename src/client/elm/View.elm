module View exposing (..)

import Html exposing (..)
import Msgs exposing (Msg)
import Models exposing (Model, PlayerId, Route(PlayersRoute, PlayerRoute, NotFoundRoute))
import Players.List
import Players.Edit
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
            Players.List.view model.players

        PlayerRoute id ->
            playerEditPage model id

        NotFoundRoute ->
            notFoundView


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    case model.players of
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
                        Players.Edit.view player

                    Nothing ->
                        notFoundView


notFoundView : Html msg
notFoundView =
    div [] [ text "Not Found!" ]
