module Pages.Edit.Model exposing (..)

type alias EditModel =
    { editName : Bool
    }


initEdit : EditModel
initEdit =
    { editName = False
    }
