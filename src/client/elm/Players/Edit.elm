module Players.Edit exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Msgs exposing (Msg)
import Models exposing (Player)


view : Player -> Html Msg
view player =
    div []
        [ nav player
        , form player
        ]


nav : Player -> Html Msg
nav player =
    div [ class "clearfix mb2 white bg-black p1" ]
        []


form : Player -> Html Msg
form player =
    div [ class "m3" ]
        [ h1 [] [ text player.name ]
        , formLevel player
        ]


formLevel : Player -> Html Msg
formLevel player =
    div [ class "clearfix py1" ]
        [ div [ class "col col-5"] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
        ]


btnLevelDecrease : a -> Html Msg
btnLevelDecrease player =
    btnLevel "fa-minus-circle"


btnLevelIncrease : a -> Html Msg
btnLevelIncrease player =
    btnLevel "fa-plus-circle"

btnLevel : String -> Html Msg
btnLevel className =
    a [ class "btn ml1 h1" ]
        [ i [ class ("fa " ++ className) ] [] ]

