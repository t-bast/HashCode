module Types where

type Bonus = Int
type Distance = Int
type Time = Int
type Row = Int
type Column = Int
type Position = (Row, Column)
type VehicleState = (Time, Position)

data Ride = Ride { startRow :: Row
                 , startCol :: Column
                 , endRow :: Row
                 , endCol :: Column
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

type RideIndex = Int
-- Rides are represented by their index in the Params record.
type Rides = [RideIndex]
-- A solution is a list of rides (how the rides are split between vehicles).
type Solution = [Rides]
