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


renderIssues : Model -> List (Html Msg)
renderIssues model =
    List.map
        (\issue ->
            row [ column12 [ text issue.title ] ]
        )
        model.issues


view : Model -> Html Msg
view model =
    container
        (List.concat
            [ [ row
                    [ column6 [ h4 [] [ text "GitHub Issue Browser" ] ]
                    , column3 [ (repositoryNameInput model) ]
                    , column3
                        [ btnDefault [ onClick FetchGithubData, disabled (String.isEmpty model.string) ]
                            [ text "Go!" ]
                        ]
                    ]
              , renderRepositoryRow model
              ]
            , renderIssues model
            ]
        )
