module Pages.Edit.Model exposing (..)

type alias Model =
    { editName : Bool
    }


init : Model
init =
    { editName = False
    }
