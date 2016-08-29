module PhoneNumber exposing (formatString)


import String
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


formatString : String -> String -> Maybe String
formatString country input =
    Dict.get country formats
        |> Maybe.map (\format ->
            formatParts format input
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
