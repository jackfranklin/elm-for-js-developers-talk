module Repositories.State exposing (..)

import Repositories.Types exposing (..)
import Repositories.Data exposing (getRepositoryData)


initialModel : Model
initialModel =
    { string = "jackfranklin/gulp-load-plugins"
    , repository = Repository "Loading..." ""
    }


initialCommands : Cmd Msg
initialCommands =
    Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        NewGithubData repo ->
            ( { model | repository = repo }, Cmd.none )

        NewRepoInput str ->
            ( { model | string = str }, Cmd.none )

        FetchGithubData ->
            ( model, getRepositoryData model.string )
