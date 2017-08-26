module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import RemoteData exposing (RemoteData(NotAsked, Loading, Failure, Success))

import Model exposing (Model, Route(PlayersRoute, PlayerRoute, NotFoundRoute))
import Data.Players.Model exposing (PlayerId)
import Pages.Edit.View exposing (editView)
import Pages.List.View exposing (listView)
import Pages.NotFound.View exposing (notFoundView)

view : Model -> Html Msg
view model =
    div [ class "view" ]
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        PlayersRoute ->
            playersRoute model

        PlayerRoute id ->
            playerRoute model id

        NotFoundRoute ->
            notFoundRoute model


playersRoute : Model -> Html Msg
playersRoute model =
    listView model.playersModel.players


playerRoute : Model -> PlayerId -> Html Msg
playerRoute model id =
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
                        |> List.filter (\player -> player.id == id)
                        |> List.head
            in
                case maybePlayer of
                    Just player ->
                        editView player model.editModel.playerNameField

                    Nothing ->
                        notFoundView


notFoundRoute : Model -> Html Msg
notFoundRoute model =
    notFoundView
