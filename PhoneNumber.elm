module PhoneNumber exposing (formatString)


import String


type Part
    = Digits Int
    | Space


placeholder : Char
placeholder =
    ' '


dkFormat =
    [ Digits 2
    , Space
    , Digits 2
    , Space
    , Digits 2
    , Space
    , Digits 2
    ]


formatString : String -> String
formatString input =
    let
        format = dkFormat
    in
        String.concat (formatParts format input)


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
