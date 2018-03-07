module Types where

type Bonus = Int
type Distance = Int
type Time = Int

data Ride = Ride { startRow :: Int
                 , startCol :: Int
                 , endRow :: Int
                 , endCol :: Int
                 , startTime :: Time
                 , endTime :: Time
                 } deriving (Show)

data Params = Params { rows :: Int
                     , columns :: Int
                     , vehicles :: Int
                     , rides :: [Ride]
                     , bonus :: Bonus
                     , steps :: Time
                     } deriving (Show)