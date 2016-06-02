module Repositories.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, value, disabled)
import Html.App
import String
import Html.Events exposing (onInput, onClick)
import Repositories.Types exposing (..)
import Repositories.Issues.View as IssuesView
import Bootstrap exposing (..)


repositoryNameInput : Model -> Html Msg
repositoryNameInput model =
    Html.form []
        [ Bootstrap.formGroup
            [ input
                [ onInput NewRepoInput
                , value model.repoName
                , class "form-control"
                ]
                []
            ]
        ]


renderRepositoryRow : Model -> Html Msg
renderRepositoryRow model =
    case model.repository of
        Just repository ->
            row
                [ column6 [ text repository.fullName ]
                , column3 [ text repository.description ]
                , column3 [ text ((toString repository.stars) ++ "stars") ]
                ]

        Nothing ->
            row [ column12 [ text "Loading repository..." ] ]


view : Model -> Html Msg
view model =
    container
        [ row
            [ column6 [ h4 [] [ text "GitHub Issue Browser" ] ]
            , column3 [ (repositoryNameInput model) ]
            , column3
                [ btnDefault [ onClick FetchGithubData, disabled (String.isEmpty model.repoName) ]
                    [ text "Go!" ]
                ]
            ]
        , renderRepositoryRow model
        , IssuesView.view model.issues |> Html.App.map IssueMessage
        ]
