module Repositories.Types exposing (..)


type alias Model =
    { string : String
    , repository : Repository
    }


type alias Repository =
    { fullName : String
    , description : String
    }


type Msg
    = NoOp
    | FetchGithubData
    | NewGithubData Repository
    | NewRepoInput String
