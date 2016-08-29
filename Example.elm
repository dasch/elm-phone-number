import Html.App exposing (beginnerProgram)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import PhoneNumber


type alias Model =
    { phoneNumberInput : String
    , countryCode : String
    }


type Msg
    = ChangePhoneNumber String


main =
    beginnerProgram
        { model = init
        , update = update
        , view = view
        }


init =
    { phoneNumberInput = "123"
    , countryCode = "us"
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangePhoneNumber newNumber ->
            { model | phoneNumberInput = newNumber }


view : Model -> Html Msg
view model =
    div []
        [ div [] [ input [ type' "text", onInput ChangePhoneNumber, value model.phoneNumberInput ] [] ]
        , pre [] [ text (Maybe.withDefault "-" (PhoneNumber.formatString model.countryCode model.phoneNumberInput)) ]
        ]
