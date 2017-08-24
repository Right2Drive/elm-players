module Players.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Player)
import RemoteData exposing (WebData)


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

list : List Player -> Html msg
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


playerRow : Player -> Html msg
playerRow player =
    tr []
        [ createTd player.id
        , createTd player.name
        , createTd (toString player.level)
        , createTd ""
        ]

createTd : String -> Html msg
createTd textValue =
    td [] [ text textValue ]
