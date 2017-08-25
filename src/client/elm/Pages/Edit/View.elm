module Pages.Edit.View exposing (editView)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)
import RemoteData exposing (RemoteData(NotAsked, Loading, Failure, Success))

import Model exposing (Model)
import Msgs exposing (Msg(..))
import Data.Players.Msgs exposing (PlayersMsg(..))
import Data.Players.Model exposing (Player, PlayerId)
import Pages.Edit.Msgs exposing (EditMsg(..))
import Pages.NotFound.View exposing (notFoundView)
import Routing exposing (playersPath)


type LevelButton
    = Increase
    | Decrease

editView : Model -> PlayerId -> Html Msg
editView model id =
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
                        |> List.filter(\player -> player.id == id)
                        |> List.head
            in
                case maybePlayer of
                    Just player ->
                        core player

                    Nothing ->
                        notFoundView


core : Player -> Html Msg
core player =
    div []
        [ nav player
        , form player
        ]

-- Create the top nav-bar
nav : Player -> Html Msg
nav player =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listButton
        ]


form : Player -> Html Msg
form player =
    div [ class "m3" ]
        [ formTitle player
        , formLevel player
        ]


formTitle : Player -> Html Msg
formTitle player =
    div [ class "elm-container" ]
        [ h1 [] [ text player.name ]
        , btnCore "fa-pencil edit-player" (EditMsg EditName)
        ]


formLevel : Player -> Html Msg
formLevel player =
    div [ class "clearfix py1" ]
        [ div [ class "col col-5"] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevel Decrease player
            , btnLevel Increase player
            ]
        ]


btnLevel : LevelButton -> Player -> Html Msg
btnLevel buttonType player =
    case buttonType of
        Increase ->
            player
                |> ChangeLevel 1 -- Generate message
                |> PlayersMsg -- Convert to PlayersMsg
                |> btnCore "fa-plus-circle" -- Generate button

        Decrease ->
            player
                |> ChangeLevel -1 -- Generate message
                |> PlayersMsg -- Convert to PlayersMsg
                |> btnCore "fa-minus-circle" -- Generate button
    

btnCore : String -> Msg -> Html Msg
btnCore className messageType =
    a [ class "btn ml1 h1" ]
        [ i 
            [ class ("fa " ++ className)
            , onClick messageType ] 
            []
        ]


listButton : Html msg
listButton =
    a
        [ class "btn regular"
        , href playersPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] []
        , text "List"
        ]

