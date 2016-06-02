module Bootstrap exposing (..)

import Html exposing (Html, Attribute, div, button)
import Html.Attributes exposing (class)


container : List (Html a) -> Html a
container contents =
    div [ class "container" ] contents


row : List (Html a) -> Html a
row contents =
    div [ class "row" ] contents


column : Int -> List (Html a) -> Html a
column width contents =
    div [ class ("col-md-" ++ (toString width)) ] contents


btn : String -> List (Attribute a) -> List (Html a) -> Html a
btn className attributes contents =
    button (attributes ++ [ class ("btn " ++ className) ]) contents


btnDefault : List (Attribute a) -> List (Html a) -> Html a
btnDefault =
    btn "btn-default"


column3 : List (Html a) -> Html a
column3 =
    column 3


column6 : List (Html a) -> Html a
column6 =
    column 6


column9 : List (Html a) -> Html a
column9 =
    column 9


column12 : List (Html a) -> Html a
column12 =
    column 12


formGroup : List (Html a) -> Html a
formGroup =
    div [ class "form-group" ]


pageHeader : List (Html a) -> Html a
pageHeader =
    div [ class "page-header" ]
