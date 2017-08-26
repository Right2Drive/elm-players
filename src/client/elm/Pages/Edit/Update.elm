module Pages.Edit.Update exposing (updateEdit)

import Msgs exposing (Msg)
import Pages.Edit.Model exposing (EditModel, PlayerNameField(..))
import Model exposing (Model)
import Pages.Edit.Msgs exposing (EditMsg(..))
import Commands exposing (focus)

updateEdit : EditMsg -> Model -> ( Model, Cmd Msg )
updateEdit msg model =
    update msg model model.editModel


update : EditMsg -> Model -> EditModel -> ( Model, Cmd Msg )
update msg model editModel =
    case msg of
        EditPlayerName ->
            let
                newEditModel =
                    { editModel | playerNameField = EditName }
            in
                ( { model | editModel = newEditModel }, focus "edit-page-player-input" )
