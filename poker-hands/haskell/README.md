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
\<Playername> wins - with <winning hand>