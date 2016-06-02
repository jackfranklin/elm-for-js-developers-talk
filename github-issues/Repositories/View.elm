module Repositories.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, value, disabled)
import String
import Html.Events exposing (onInput, onClick)
import Repositories.Types exposing (..)
import Bootstrap exposing (..)


repositoryNameInput : Model -> Html Msg
repositoryNameInput model =
    Html.form []
        [ Bootstrap.formGroup
            [ input
                [ onInput NewRepoInput
                , value model.string
                , class "form-control"
                ]
                []
            ]
        ]


view : Model -> Html Msg
view model =
    container
        [ row
            [ column6 [ h4 [] [ text "GitHub Issue Browser" ] ]
            , column3 [ (repositoryNameInput model) ]
            , column3
                [ btnDefault [ onClick FetchGithubData, disabled (String.isEmpty model.string) ]
                    [ text "Go!" ]
                ]
            ]
        , row
            [ column6 [ text model.repository.fullName ]
            , column6 [ text model.repository.description ]
            ]
        ]
