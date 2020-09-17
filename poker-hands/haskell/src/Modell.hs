module Modell (
  Card(..),
  Suit(..),
  Value(..),
  Score(..),
  Hand(..)
  ) where

data Card = Card Value Suit deriving (Read)

data Suit = Heart
  | Spade
  | Diamond
  | Club deriving (Eq,Read)

data Value =  Two
  | Three
  | Four
  | Five
  | Six
  | Seven
  | Eight
  | Nine
  | Ten
  | Joker
  | Queen
  | King
  | Ace deriving (Eq,Ord, Read, Bounded,Enum)

data Hand = Hand Card Card Card Card Card deriving (Eq,Show)

type Player = String

data PlayerScore = PlayerScore Player Score

data Score = HighCard Card deriving (Show)

instance Ord Card where
  Card val1 _ > Card val2 _ = val1 > val2
  Card val1 _ < Card val2 _ = val1 < val2
  Card val1 _ <= Card val2 _ = val1 <= val2

instance Eq Card where
    Card val1 _ == Card val2 _ = val1 == val2
    Card val1 _ /= Card val2 _ = not (val1 == val2)

instance Show Card where
  show (Card a b) = show (show a ++ show b)

instance Show Suit where
  show Heart = "H"
  show Diamond = "D"
  show Club =  "C"
  show Spade = "S"

instance Show Value where
  show Ten = "T"
  show Joker = "J"
  show Queen= "Q"
  show King= "K"
  show Ace = "A"
  show other = (show . (+) 2 . fromEnum) other

