module Repositories.State exposing (..)

import Repositories.Types exposing (..)
import Repositories.Data exposing (getRepositoryData)
import Repositories.Issues.State


initialModel : Model
initialModel =
    { string = "jackfranklin/gulp-load-plugins"
    , repository = Repository "Loading..." "" 0
    , loading = True
    , issues = Repositories.Issues.State.initialModel
    }


initialCommands : Cmd Msg
initialCommands =
    Cmd.batch
        [ getRepositoryData initialModel.string
        , Cmd.map IssueMessage (Repositories.Issues.State.initialCommands initialModel.string)
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        NewGithubData repo ->
            ( { model | repository = repo, loading = False }, Cmd.none )

        NewRepoInput str ->
            ( { model | string = str }, Cmd.none )

        FetchGithubData ->
            ( { model | loading = True }, getRepositoryData model.string )

        IssueMessage submsg ->
            let
                ( newModel, newCmd ) =
                    Repositories.Issues.State.update model.string submsg model.issues
            in
                ( { model | issues = newModel }, Cmd.map IssueMessage newCmd )
