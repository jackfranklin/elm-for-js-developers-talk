module View exposing (view)

import Types exposing (..)
import Html exposing (..)


view : Model -> Html Msg
view model =
    div [] [ text "Hello World" ]
