module Repositories.State exposing (..)

import Repositories.Types exposing (..)
import Repositories.Data exposing (getRepositoryData)
import Repositories.Issues.State as IssuesState
import Repositories.Issues.Types as IssuesTypes


initialModel : Model
initialModel =
    { repoName = "jackfranklin/gulp-load-plugins"
    , repository = Nothing
    , issues = IssuesState.initialModel
    }


initialCommands : Cmd Msg
initialCommands =
    Cmd.batch
        [ getRepositoryData initialModel.repoName
        , Cmd.map IssueMessage (IssuesState.initialCommands initialModel.repoName)
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        NewGithubData repo ->
            ( { model | repository = Just repo }, Cmd.none )

        NewRepoInput str ->
            ( { model | repoName = str }, Cmd.none )

        FetchGithubData ->
            let
                ( newSubModel, subCmd ) =
                    IssuesState.update model.repoName IssuesTypes.FetchIssues model.issues
            in
                ( { model | repository = Nothing, issues = newSubModel }
                , Cmd.batch [ Cmd.map IssueMessage subCmd, getRepositoryData model.repoName ]
                )

        IssueMessage submsg ->
            let
                ( newModel, newCmd ) =
                    IssuesState.update model.repoName submsg model.issues
            in
                ( { model | issues = newModel }, Cmd.map IssueMessage newCmd )
