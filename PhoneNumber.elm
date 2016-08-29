module PhoneNumber exposing (formatString)


{-| The PhoneNumber module allows formatting phone numbers according to country
specific rules.

    PhoneNumber.formatString "us" "5417543010"
    --> Just "(541) 754-3010"

@docs formatString
-}


import String
import Char
import Dict


type Part
    = Digits Int
    | Str String
    | Space


placeholder : Char
placeholder =
    ' '


formats =
    Dict.fromList
        [ ( "dk"
          , [ Digits 2
            , Space
            , Digits 2
            , Space
            , Digits 2
            , Space
            , Digits 2
            ]
          )
        , ( "us"
          , [ Str "("
            , Digits 3
            , Str ")"
            , Space
            , Digits 3
            , Str "-"
            , Digits 4
            ]
          )
        ]


{-| Formats a string of digits according to the country code.
-}
formatString : String -> String -> Maybe String
formatString country input =
    Dict.get country formats
        |> Maybe.map (\format ->
            String.filter Char.isDigit input
                |> formatParts format
                |> String.concat 
          )


formatParts : List Part -> String -> List String
formatParts parts chars =
    case parts of
        [] ->
            []

        part :: restParts ->
            let
                (output, restChars) = formatPart part chars
            in
                output :: formatParts restParts restChars


formatPart : Part -> String -> (String, String)
formatPart part digits =
    case part of
        Space ->
            (" ", digits)

        Str string ->
            (string, digits)

        Digits length ->
            ( String.left length digits
                |> String.padRight length placeholder
            , String.dropLeft length digits
            )
