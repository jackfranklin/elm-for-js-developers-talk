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
                , value model.string
                , class "form-control"
                ]
                []
            ]
        ]


renderRepositoryRow : Model -> Html Msg
renderRepositoryRow model =
    if model.loading then
        row [ column12 [ text "Loading repository..." ] ]
    else
        row
            [ column6 [ text model.repository.fullName ]
            , column3 [ text model.repository.description ]
            , column3 [ text ((toString model.repository.stars) ++ "stars") ]
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
        , renderRepositoryRow model
        , IssuesView.view model.issues |> Html.App.map IssueMessage
        ]
