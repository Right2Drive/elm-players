module Pages.Edit.Update exposing (updateEdit)

import Pages.Edit.Model exposing (EditModel)
import Pages.Edit.Msgs exposing (EditMsg(..))

updateEdit : EditMsg -> EditModel -> ( EditModel, Cmd EditMsg)
updateEdit msg model =
    case msg of
        EditName ->
            ( model, Cmd.none )
