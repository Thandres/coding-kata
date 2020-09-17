module CardOperations
    ( toValue,
      fromValue,
      toSuit,
      fromSuit,
      newCard,
      stringToCard,
      scoreValue
    ) where

import Modell

toValue:: Char -> Value
toValue c = toEnum ((fromCharToInt c)-2) :: Value

fromValue:: Value -> Int
fromValue val = (fromEnum val) + 2

stringToCard :: String -> Card
stringToCard string
 | length string == 2 = newCard (head string) (head string)

newCard:: Char ->  Char -> Card
newCard val suit = Card (toValue val) (toSuit suit)

toSuit:: Char -> Suit
toSuit 'H' = Heart
toSuit 'D' = Diamond
toSuit 'C' = Club
toSuit 'S' = Spade

fromSuit::  Suit -> Char
fromSuit Heart= 'H'
fromSuit Diamond= 'D'
fromSuit Club= 'C'
fromSuit Spade = 'S'

fromCharToInt:: Char -> Int
fromCharToInt 'T' = 10
fromCharToInt 'J' = 11
fromCharToInt 'Q' = 12
fromCharToInt 'K' = 13
fromCharToInt 'A' = 14
fromCharToInt c = read [c]::Int

scoreValue:: Score -> Int
scoreValue (HighCard (Card val _)) = fromValue val