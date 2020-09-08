# Ziele
- Use algebraic data types
- get more comfortable using Haskell/Functional Design

# Optional Goal
Can the algebraic data types be used to completely implement the hand value logic?

# Input
```
   Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C AH
   Black: 2H 4S 4C 2D 4H  White: 2S 8S AS QS 3S
   Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C KH
   Black: 2H 3D 5S 9C KD  White: 2D 3H 5C 9S KH
```
\<Playername>: <5 space seperated cards> \<Playername>: <5 space seperated cards>
# Expected Output
```
White wins. - with high card: Ace 
Black wins. - with full house: 4 over 2 
Black wins. - with high card: 9
Tie.
```
\<Playername> wins - with \<winning hand>

# Process
Thinking in functions means that this problem looks like a `String -> String` Function.
By thinking about an intermediate step that needs to happen I get to `String -> (PlayerHand, PlayerHand)  -> String`.
Further looking for intermediate steps:

`String ->  (PlayerHand, PlayerHand) ->  (PlayerScore, PlayerScore) -> String`

`String ->  (PlayerHand, PlayerHand) -> (PlayerScore, PlayerScore)-> PlayerScore -> String`

`String -> ((Player,[Card]),(Player,[Card])) ->  (PlayerHand, PlayerHand) -> (PlayerScore, PlayerScore) -> PlayerScore -> String`

That gives a good design baseline for the rest of the code.

`Card` looks like a good candidate for a datatype along the lines of `data Card = Card Int String` with `Int` being the value 
of the card and `String` being the suit. Formulating it like this quickly leads two new datatypes and leads to
 `data Card = Card Value Suit`. 
 
`Suit` is fairly straightforward being just `data Suit = Heart | Diamond | Club | Spade`.
 
`Value` is a bit trickier. It would be easy to use it simply as a type synonym of `Int` but a card can also be a King,
which needs to be mapped to a Number. But Cards only range from Ace to King in value. So this leads to defining every 
card value as its own type of `Value` and deriving `Enum`,`Eq` and `Ord` so that they are naturally ordered and can be 
compared for equality.
