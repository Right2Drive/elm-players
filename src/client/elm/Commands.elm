module Commands exposing (focus)

import Task
import Dom exposing (focus)

import Msgs exposing (Msg(DomTask))

focus : String -> Cmd Msg
focus id =
    id
        |> Dom.focus
        |> Task.attempt DomTask
