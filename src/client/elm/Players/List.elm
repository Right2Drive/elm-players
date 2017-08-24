module Players.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Models exposing (Player, PlayerId)
import RemoteData exposing (WebData)
import Routing exposing (playerPath)

type TdContent
    = HtmlContent (Html Msg)
    | TextContent String
    | NumContent Int

view : WebData (List Player) -> Html Msg
view players =
    div []
        [ nav
        , maybeList players
        ]

maybeList : WebData (List Player) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success players ->
            list players

        RemoteData.Failure error ->
            text (toString error)


nav : Html msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ]
            [ text "Players"
            ]
        ]

list : List Player -> Html Msg
list players =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ createTh "Id"
                    , createTh "Name"
                    , createTh "Level"
                    , createTh "Actions" 
                    ]
                ]
            , tbody [] (List.map playerRow players)
            ]
        ]

createTh : String -> Html msg
createTh textValue =
    th [] [ text textValue ]


playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ createTd (TextContent player.id)
        , createTd (TextContent player.name)
        , createTd (NumContent player.level)
        , player
            |> editButton -- Create edit button
            |> HtmlContent -- Convert to HTML Content
            |> createTd -- Use this to create a td element
        ]


-- While this has not reduced the code, or made it easier to understand
-- it was more of an experiment in the usage of `case` statements in Elm.
-- It would have been better to just type out the various td [] [] elements
-- as there was not enough code re-use to validate the refactor
-- TODO: Would be an interesting experiment to convert Msg to msg
createTd : TdContent -> Html Msg
createTd content =
    let
        tdContent =
            case content of
                HtmlContent htmlContent ->
                    htmlContent

                TextContent textContent ->
                    text textContent
                
                NumContent numContent ->
                    text (toString numContent)
    in
        td [] [ tdContent ]


editButton : Player -> Html msg
editButton player =
    let
        path =
            playerPath player.id
    in
        a
            [ class "btn regular"
            , href path
            ]
            [ i [ class "fa fa-pencil mr1" ] []
            , text "Edit"
            ]
