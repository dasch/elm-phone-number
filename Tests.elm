import Test exposing (..)
import Test.Runner.Html
import Expect
import PhoneNumber exposing (formatString)


suite =
    describe "PhoneNumber"
        [ describe "format"
            [ test "formats Danish phone numbers"
                ( \_ ->
                    Expect.equal "34 56 12 45" (formatString "34561245")
                )
            ]
        ]


main =
    Test.Runner.Html.run suite
