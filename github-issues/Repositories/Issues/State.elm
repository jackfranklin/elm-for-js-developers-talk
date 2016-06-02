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


updateToFetchIssues : String -> Model -> ( Model, Cmd Msg )
updateToFetchIssues repo model =
    update repo FetchIssues model


update : String -> Msg -> Model -> ( Model, Cmd Msg )
update fullRepoName msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchIssues ->
            ( { model | loading = True }, getIssueData fullRepoName )

        NewIssues issues ->
            ( { model | loading = False, issues = issues }, Cmd.none )
