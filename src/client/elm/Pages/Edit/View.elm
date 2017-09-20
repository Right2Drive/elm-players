module Pages.Edit.View exposing (editView)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onBlur)

import Msgs exposing (Msg(..))
import Data.Players.Msgs exposing (PlayersMsg(..))
import Data.Players.Model exposing (Player, PlayerId)
import Pages.Edit.Msgs exposing (EditMsg(..))
import Pages.Edit.Model exposing (PlayerNameField(..))
import Routing exposing (playersPath)


type LevelButton
    = Increase
    | Decrease


editView : Player -> PlayerNameField -> Html Msg
editView player field =
    div [ class "page"
        , id "edit-page"
        ]
        [ nav player
        , form player field
        ]


-- Create the top nav-bar
nav : Player -> Html Msg
nav player =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listButton
        ]


form : Player -> PlayerNameField -> Html Msg
form player field =
    div [ class "m3" ]
        [ formTitle player field
        , formLevel player
        ]


formTitle : Player -> PlayerNameField -> Html Msg
formTitle player field =
    div [ class "elm-container" ]
        [ formHeader player field
        , btnCore "fa-pencil edit-player" (EditMsg EditPlayerName)
        ]


formHeader : Player -> PlayerNameField -> Html Msg
formHeader player field =
    let
        ( className, readOnly ) =
            case field of
                EditName ->
                    ( "edit", False )

                DisplayName ->
                    ( "display", True )
    in
        input
            [ value player.name
            , class className
            , id playerInputId
            , readonly readOnly
            , onInput
                <| \n -> n
                    |> ChangeName player
                    |> PlayersMsg
            , DisplayPlayerName
                |> EditMsg
                |> onBlur
            ]
            []



playerInputId : String
playerInputId =
    "edit-page-player-input"

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
