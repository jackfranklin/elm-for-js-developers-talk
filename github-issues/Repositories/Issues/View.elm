module Repositories.Issues.View exposing (view)

import Html exposing (..)
import Repositories.Issues.Types exposing (..)
import Bootstrap exposing (..)


view : Model -> Html Msg
view model =
    case model.issues of
        Nothing ->
            row [ column12 [ text "Loading issues" ] ]

        Just issues ->
            row [ column12 (List.map (\issue -> text issue.title) issues) ]
