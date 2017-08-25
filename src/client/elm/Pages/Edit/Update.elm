module Pages.Edit.Update exposing (..)

import Pages.Edit.Model exposing (Model)
import Pages.Edit.Msgs exposing (Msg(..))

update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
    case msg of
        EditName ->
            ( model, Cmd.none )
