# Goals
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
## Defining the rough model
Thinking in functions means that this problem looks like a `String -> String` Function.
By thinking about an intermediate step that needs to happen I get to 

`String -> (PlayerHand, PlayerHand)  -> String`.
Further looking for intermediate steps:

`String ->  (PlayerHand, PlayerHand) ->  (PlayerScore, PlayerScore) -> String`

`String ->  (PlayerHand, PlayerHand) -> (PlayerScore, PlayerScore)-> PlayerScore -> String`

`String -> ((Player,[Card]),(Player,[Card])) ->  (PlayerHand, PlayerHand) -> (PlayerScore, PlayerScore) -> PlayerScore -> String`

That should provide a good design baseline for the rest of the code.

## drilling down on the rough model
### Card
`Card` looks like a good candidate for a datatype along the lines of `data Card = Card Int String` with `Int` being the value 
of the card and `String` being the suit. Formulating it like this quickly leads two new datatypes and leads to
 `data Card = Card Value Suit`. 

#### Suit
`Suit` is fairly straightforward being just `data Suit = Heart | Diamond | Club | Spade`.

#### Value
`Value` is a bit trickier. It would be easy to use it simply as a type synonym of `Int` but a card can also be a King,
which needs to be mapped to a Number. But Cards only range from Ace to King in value. So this leads to defining every 
card value as its own type of `Value` and deriving `Enum`,`Eq` and `Ord` so that they are naturally ordered and can be 
compared for equality.
#### Comparing Cards
Because a `Suit` is not strictly ordered in this kata and has no direct impact on the value between cards  we should
compare `Card` types by their `Value` alone, instead of checking if `Suit` AND `Value` are equal for instance.

One way to achieve that would be to implement custom `Eq` and `Ord` instances of `Card`. The other way would be to write 
a `Card -> Value` function and compare the values themselves. That function could be composed to a function like
`isEqual::Card -> Card -> Boolean`, or used alone to map tuples of Cards to tuples of Values and then compare them 
accordingly. That would just be a roundabout way to implement the `Eq` and `Ord` instances, so I chose to do it directly
and make comparability a property of `Card` itself.

#### Creating Cards
With our function signature we basically want a `String -> Card` function that takes a `String` of length two and 
returns our Card. On further thought the function is better represented as `Char -> Char -> Card` with the first `Char`
being the `Value` and the second being the `Suit`. That is one way of doing it, but Haskell has the `Read` class. 
Data types that implement `Read` can be converted from a String. This means that `Value` and `Suit` need to derive `Read`
as well. Some googling suggests, that implementing your own `Read` is not really intended so creating by function seems 
to be the correct choice. In that move its easy to also implement the reverse operations, so we can print out our winning 
hand.

#### Showing Cards
To get Cards back to their String representation Hakell offers the `Show` class. Writing a custom Implementation so that
`Value` and `Suit` get back to their Input form is fairly straightforward.

## Player
`Player` is also a straightforward type: Its just a type synonym for a `String`.

## PlayerScore
Next up I inspect the rough function chain backwards, as the scoring is the next part which is explicitly specified by
the kata, so we can model it directly after the description. This leads to `data PlayerScore = PlayerScore Player Score`
as a rough idea for the type.

### Score 
The first thought is to make Scores consist out of Card so that `data Score = HighCard Card | ...`. Because the data 
constructors have a parameter, this would prevent a simple ordering by deriving `Enum`. That means to implement `Ord`
correctly I would need to provide a comparison between every `Score` with every other `Score`.  This lead me to a slight 
reframing of `Score`. `Score` as the absolute value of a Hand makes it easier to implement the `Ord` class for `Score`.
So I need to implement a `Hand -> Score` and then probably `Score -> Int` function which is easy to compare. 

#### Score -> Int function
Because `Scores` of the same rank need to be compared by their I can make my life easy by having `Highcard` be of the
lowest `Int` values and go up in an order of magnitude above `Highcard`. So if `Highcard` has a value of 2-14 then a 
`Pair` has a value of 100 + the value of the `Highcard`. Adding 100 per rank should be sufficient and easy enough. If I
ever need to optimize for space I could increment in steps of 15 per rank. This is also the point where multiple files
for holding data types comes in handy.