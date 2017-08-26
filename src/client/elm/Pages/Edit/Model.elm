module Pages.Edit.Model exposing (..)

type alias EditModel =
    { playerNameField : PlayerNameField
    }


type PlayerNameField
    = EditName
    | DisplayName


initEdit : EditModel
initEdit =
    { playerNameField = DisplayName
    }
