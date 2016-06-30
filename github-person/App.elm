module App exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App
import Http
import Json.Decode as Json exposing ((:=))
import Task


type alias GithubPerson =
    { name : String
    , company : String
    }


type alias Model =
    { username : String
    , githubPerson : Maybe GithubPerson
    }


type Msg
    = NewGithubData GithubPerson
    | FetchGithubData
    | FetchError Http.Error



-- TODO: what happens when the JSON decoding fails? Do I need to deal with this?


githubDecoder : Json.Decoder GithubPerson
githubDecoder =
    Json.object2 GithubPerson
        ("name" := Json.string)
        ("company" := Json.string)


fetchGithubData : String -> Cmd Msg
fetchGithubData username =
    Http.get githubDecoder ("https://api.github.com/users/" ++ username)
        |> Task.perform FetchError NewGithubData


initialModel : Model
initialModel =
    { username = "jackfranklin"
    , githubPerson = Nothing
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchError _ ->
            ( model, Cmd.none )

        NewGithubData person ->
            ( { model | githubPerson = Just person }, Cmd.none )

        FetchGithubData ->
            ( model, fetchGithubData model.username )


view : Model -> Html Msg
view { githubPerson, username } =
    case githubPerson of
        Nothing ->
            button [ onClick FetchGithubData ] [ text "Load!" ]

        Just person ->
            div [] [ text (person.name ++ ", " ++ person.company) ]


main : Program Never
main =
    Html.App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
