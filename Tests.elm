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
            , test "ignores superfluous digits"
                ( \_ ->
                    Expect.equal "34 56 12 45" (formatString "34561245123")
                )
            , test "fills in placeholders in place of missing digits"
                ( \_ ->
                    Expect.equal "34 56 12 4 " (formatString "3456124")
                )
            ]
        ]


main =
    Test.Runner.Html.run suite