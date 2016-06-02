module State exposing (..)

import Types exposing (Model, Msg)


initialModel : Model
initialModel =
    {}


initialCommands : Cmd Msg
initialCommands =
    Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )
