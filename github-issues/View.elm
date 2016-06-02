module View exposing (view)

import Types exposing (..)
import Html exposing (..)
import Repositories.View as RepoView
import Html.App


repoView : Model -> Html Msg
repoView { repository } =
    RepoView.view repository |> Html.App.map RepositoryMessage


view : Model -> Html Msg
view model =
    div []
        [ repoView model
        ]
