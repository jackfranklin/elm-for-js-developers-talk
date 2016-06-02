module Types exposing (..)

import Repositories.Types


type Msg
    = NoOp
    | RepositoryMessage Repositories.Types.Msg


type alias Model =
    { repository : Repositories.Types.Model
    }
