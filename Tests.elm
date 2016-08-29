import Test exposing (..)
import Test.Runner.Html
import Expect
import PhoneNumber exposing (formatString)


suite =
    describe "PhoneNumber"
        [ describe "format"
            [ test "formats Danish phone numbers"
                ( \_ ->
                    expectFormat "34 56 12 45" "dk" "34561245"
                )
            , test "ignores superfluous digits"
                ( \_ ->
                    expectFormat "34 56 12 45" "dk" "34561245123"
                )
            , test "fills in placeholders in place of missing digits"
                ( \_ ->
                    expectFormat "34 56 12 4 " "dk" "3456124"
                )
            ]
        ]


expectFormat output country input =
    Expect.equal (Just output) (formatString country input)


main =
    Test.Runner.Html.run suite
