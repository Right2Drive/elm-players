module Routing exposing (matchers, parseLocation, playerPath, playersPath)

import Navigation exposing (Location)
import UrlParser exposing (..)

import Model exposing (Route(..))

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route
        
        Nothing ->
            NotFoundRoute


playersPath : String
playersPath =
    "#players"


playerPath : String -> String
playerPath id =
    "#players/" ++ id
