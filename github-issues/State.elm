module State exposing (..)

import Types exposing (Model, Msg(..))
import Repositories.State


initialModel : Model
initialModel =
    { repository = Repositories.State.initialModel
    }


initialCommands : Cmd Msg
initialCommands =
    Cmd.batch
        [ Cmd.map RepositoryMessage Repositories.State.initialCommands
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        RepositoryMessage submsg ->
            let
                ( newModel, newCmd ) =
                    Repositories.State.update submsg model.repository
            in
                ( { model | repository = newModel }, Cmd.map RepositoryMessage newCmd )
