module PhoneNumber exposing (formatString)


import String
import Dict


type Part
    = Digits Int
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

        Digits length ->
            ( String.left length digits
                |> String.padRight length placeholder
            , String.dropLeft length digits
            )
