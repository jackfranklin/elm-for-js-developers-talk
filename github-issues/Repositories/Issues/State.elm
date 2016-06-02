module Repositories.Issues.State exposing (..)

import Repositories.Issues.Types exposing (..)
import Repositories.Issues.Data exposing (..)


initialModel : Model
initialModel =
    { loading = True
    , issues = []
    }


initialCommands : String -> Cmd Msg
initialCommands repoName =
    getIssueData repoName


update : String -> Msg -> Model -> ( Model, Cmd Msg )
update fullRepoName msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchIssues ->
            ( { model | loading = True }, getIssueData fullRepoName )

        NewIssues issues ->
            ( { model | loading = False, issues = issues }, Cmd.none )
