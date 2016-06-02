module Repositories.Issues.View exposing (view)

import Html exposing (..)
import Repositories.Issues.Types exposing (..)
import Bootstrap exposing (..)


view : Model -> Html Msg
view model =
    row [ column12 (List.map (\issue -> text issue.title) model.issues) ]
