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
            , test "formats US phone numbers"
                ( \_ ->
                    expectFormat "(432) 654-5431" "us" "4326545431"
                )
            , test "ignores superfluous digits"
                ( \_ ->
                    expectFormat "34 56 12 45" "dk" "34561245123"
                )
            , test "fills in placeholders in place of missing digits"
                ( \_ ->
                    expectFormat "34 56 12 4 " "dk" "3456124"
                )
            , test "ignores non-digits"
                ( \_ ->
                    expectFormat "34 56 12 45" "dk" "yo 34 56 lo 12 x 45"
                )
            ]
        ]


expectFormat output country input =
    Expect.equal (Just output) (formatString country input)


main =
    Test.Runner.Html.run suite
