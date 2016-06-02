module Repositories.Data exposing (..)

import Repositories.Types exposing (..)
import Json.Decode as JD exposing ((:=), Decoder)
import Json.Decode.Extra exposing ((|:))
import HttpBuilder exposing (..)
import GitHubToken
import Task exposing (Task)


gitHubRequest : String -> Decoder a -> Task (Error String) (Response a)
gitHubRequest url successDecoder =
    get ("https://api.github.com/repos/" ++ url)
        |> withHeader "Content-Type" "application/json"
        |> withHeader "Authorization" GitHubToken.token
        |> send (jsonReader successDecoder) stringReader


repositoryDecoder : Decoder Repository
repositoryDecoder =
    JD.succeed Repository
        |: ("full_name" := JD.string)
        |: ("description" := JD.string)


getRepositoryData : String -> Cmd Msg
getRepositoryData userRepoString =
    Task.perform (always NoOp)
        (NewGithubData << .data)
        (httpRequest userRepoString)


httpRequest : String -> Task (HttpBuilder.Error String) (HttpBuilder.Response Repository)
httpRequest userRepoString =
    gitHubRequest userRepoString repositoryDecoder
