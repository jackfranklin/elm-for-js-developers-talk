module App exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Json exposing (field)


type alias GithubPerson =
    { name : String
    , company : String
    }


type alias Model =
    { username : String
    , githubPerson : Maybe GithubPerson
    }


type Msg
    = NewGithubData (Result Http.Error GithubPerson)
    | FetchGithubData


githubDecoder : Json.Decoder GithubPerson
githubDecoder =
    Json.map2 GithubPerson
        (field "name" Json.string)
        (field "company" Json.string)


fetchGithubData : String -> Cmd Msg
fetchGithubData username =
    Http.get ("https://api.github.com/users/" ++ username) githubDecoder
        |> Http.send NewGithubData


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
        NewGithubData (Ok person) ->
            ( { model | githubPerson = Just person }, Cmd.none )

        NewGithubData (Err _) ->
            ( model, Cmd.none )

        FetchGithubData ->
            ( model, fetchGithubData model.username )


view : Model -> Html Msg
view { githubPerson, username } =
    case githubPerson of
        Nothing ->
            button [ onClick FetchGithubData ] [ text "Load!" ]

        Just person ->
            div [] [ text (person.name ++ ", " ++ person.company) ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
