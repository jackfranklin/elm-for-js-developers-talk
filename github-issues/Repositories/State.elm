module Repositories.State exposing (..)

import Repositories.Types exposing (..)
import Repositories.Data exposing (getRepositoryData, getIssueData)


initialModel : Model
initialModel =
    { string = "jackfranklin/gulp-load-plugins"
    , repository = Repository "Loading..." "" 0
    , loading = True
    , issues = []
    }


initialCommands : Cmd Msg
initialCommands =
    Cmd.batch
        [ getRepositoryData initialModel.string
        , getIssueData initialModel.string
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

        NewIssues issues ->
            ( { model | issues = issues }, Cmd.none )

        FetchIssues ->
            ( model, getIssueData model.string )
