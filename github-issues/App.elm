module App exposing (..)

import View
import Html.App
import State


main : Program Never
main =
    Html.App.program
        { init = ( State.initialModel, State.initialCommands )
        , view = View.view
        , update = State.update
        , subscriptions = (\_ -> Sub.none)
        }
