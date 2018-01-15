module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode


-- MAIN


main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL


type alias Model =
  { booksList : List Book
  , errors : String
  }
  
type alias Book =
  { title : String
  , amazonUrl : String
  , imageUrl : String
  , rating : Int
  , id : Int
  }

initialModel : Model
initialModel = 
  { booksList = []
  , errors = ""  
  }

initialCommand : Cmd Msg
initialCommand =
  fetchBooksList
  
  
init : ( Model, Cmd Msg )
init =
  ( initialModel, initialCommand )


-- API


fetchBooksList : Cmd Msg
fetchBooksList =
  Http.get "/api/books" decodeBooksList
    |> Http.send FetchBooksList


decodeBook : Decode.Decoder Book
decodeBook =
  Decode.map5 Book
    (Decode.field "title" Decode.string)
    (Decode.field "amazonUrl" Decode.string)
    (Decode.field "imageUrl" Decode.string)
    (Decode.field "rating" Decode.int)
    (Decode.field "id" Decode.int)
    

decodeBooksList : Decode.Decoder (List Book)
decodeBooksList =
  decodeBook
    |> Decode.list
    |> Decode.at [ "data" ]


-- UPDATE


type Msg 
  = FetchBooksList (Result Http.Error (List Book))

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    FetchBooksList result ->
      case result of
        Ok books ->
          ( { model | booksList = books }, Cmd.none )

        Err message ->
          ( { model | errors = toString message }, Cmd.none )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW


view : Model -> Html Msg
view model =
  if List.isEmpty model.booksList then
    div [] []
  else
    div []
        [ booksIndex model
        ]
      
booksIndex : Model -> Html msg
booksIndex model =
    div [ class "books-index" ] [ booksList model.booksList ]
    

booksList : List Book -> Html msg
booksList books =
    div [ class "books-list row" ] (List.map booksListItem books)


booksListItem : Book -> Html msg
booksListItem book =
    div [ class "book-item col-sm-4" ]
        [ div [ class "thumbnail" ] 
          [ img [ src book.imageUrl, height 300 ] []
          , p [ class "book-title" ] [ text (toString book.id ++ ". " ++ book.title) ]
          , img [ src ("/images/stars_" ++ (toString book.rating) ++ ".jpg"), class "stars" ] []
          , p [] 
            [ a [ class "btn btn-warning btn-block amazon-button", href book.amazonUrl ]
              [ text "Buy in Amazon" ]
            ]
          ]
        ]