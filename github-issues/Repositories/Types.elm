module Repositories.Types exposing (..)


type alias Issue =
    { title : String
    , createdAt : String
    }


type alias Model =
    { string : String
    , repository : Repository
    , loading : Bool
    , issues : List Issue
    }


type alias Repository =
    { fullName : String
    , description : String
    , stars : Int
    }


type Msg
    = NoOp
    | FetchGithubData
    | FetchIssues
    | NewGithubData Repository
    | NewIssues (List Issue)
    | NewRepoInput String
