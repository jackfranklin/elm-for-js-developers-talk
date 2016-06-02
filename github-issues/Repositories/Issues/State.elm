module Repositories.Issues.State exposing (..)

import Repositories.Issues.Types exposing (..)
import Repositories.Issues.Data exposing (..)


initialModel : Model
initialModel =
    { issues = Nothing
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
            ( { model | issues = Nothing }, getIssueData fullRepoName )

        NewIssues issues ->
            ( { model | issues = Just issues }, Cmd.none )
