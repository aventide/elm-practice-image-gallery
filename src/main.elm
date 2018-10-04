module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, button, div, img, input, node, span, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Http



-- To learn http and Browser.element: https://guide.elm-lang.org/effects/


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { urls : List String, textContent : String }


init : Model
init =
    { urls =
        [ "https://cdn6.bigcommerce.com/s-if8arfen/products/6694/images/6850/3504517__37514.1444115495.200.200.jpg?c=2"
        , "https://static.ideaconnection.com/images/inventions/cold-plasma-bandages-promote-healing-without-drugs-13182.jpg"
        , "https://vignette.wikia.nocookie.net/sorcerers-apprentice/images/0/0a/Plasma_Bolt.jpg/revision/latest?cb=20120504013500"
        ]
    , textContent = ""
    }



-- UPDATE


type Msg
    = AddImage String
    | ChangeText String
    | Reset
    | Clear


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddImage url ->
            if String.length url > 0 then
                { model | urls = url :: model.urls }

            else
                model

        ChangeText text ->
            { model | textContent = text }

        Reset ->
            init

        Clear ->
            { model | urls = [] }



-- VIEW


viewImage : String -> Html Msg
viewImage url =
    img [ src url ] []


viewImages : List String -> String -> Html Msg
viewImages imageList textContent =
    div [ style "font-family" "Lato" ]
        [ node "link" [ href "https://fonts.googleapis.com/css?family=Lato", rel "stylesheet" ] []
        , div [ style "display" "flex", style "justify-content" "center", style "margin-bottom" "1em" ]
            [ span [ style "margin-right" "2em", style "font-weight" "bold", style "text-decoration" "underline" ] [ text "My Image Gallery" ]
            , input [ value textContent, onInput ChangeText ] []
            , button
                [ onClick (AddImage textContent) ]
                [ text "Add" ]
            , button
                [ onClick Reset ]
                [ text "Reset" ]
            , button
                [ onClick Clear ]
                [ text "Clear" ]
            ]
        , div [ style "display" "grid", style "justify-content" "center" ]
            [ div [ style "display" "grid", style "grid-template-columns" "1fr 1fr 1fr", style "grid-gap" "1em" ] (List.map viewImage imageList)
            ]
        ]


view : Model -> Html Msg
view model =
    viewImages model.urls model.textContent
