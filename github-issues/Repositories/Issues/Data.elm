module Repositories.Issues.Data exposing (..)

import Repositories.Issues.Types exposing (..)
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


issueDecoder : Decoder Issue
issueDecoder =
    JD.succeed Issue
        |: ("title" := JD.string)
        |: ("created_at" := JD.string)


issuesDecoder : Decoder (List Issue)
issuesDecoder =
    JD.list issueDecoder


getIssueData : String -> Cmd Msg
getIssueData userRepoString =
    Task.perform (always NoOp)
        (NewIssues << .data)
        (gitHubRequest (userRepoString ++ "/issues") issuesDecoder)
