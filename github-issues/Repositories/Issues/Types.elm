module Repositories.Issues.Types exposing (..)


type alias Issue =
    { title : String
    , createdAt : String
    }


type alias Model =
    { loading : Bool
    , issues : List Issue
    }


type Msg
    = NoOp
    | FetchIssues
    | NewIssues (List Issue)
