module Repositories.Data exposing (..)

import Repositories.Types exposing (..)
import Json.Decode as JD exposing ((:=), Decoder)
import Json.Decode.Extra exposing ((|:))
import HttpBuilder exposing (..)
import GitHubToken
import Task exposing (Task)


gitHubRequest : String -> Decoder a -> Task (Error String) (Response a)
gitHubRequest url successDecoder =
    get ("http://localhost:3001/repos/" ++ url)
        |> withHeader "Content-Type" "application/json"
        |> withHeader "Authorization" GitHubToken.token
        |> send (jsonReader successDecoder) stringReader


repositoryDecoder : Decoder Repository
repositoryDecoder =
    JD.succeed Repository
        |: ("full_name" := JD.string)
        |: ("description" := JD.string)
        |: ("stargazers_count" := JD.int)


issueDecoder : Decoder Issue
issueDecoder =
    JD.succeed Issue
        |: ("title" := JD.string)
        |: ("created_at" := JD.string)


issuesDecoder : Decoder (List Issue)
issuesDecoder =
    JD.list issueDecoder


getRepositoryData : String -> Cmd Msg
getRepositoryData userRepoString =
    Task.perform (always NoOp)
        (NewGithubData << .data)
        (gitHubRequest userRepoString repositoryDecoder)
