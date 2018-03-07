module Score (score) where

import Distance
import Types

-- score scores a given solution. 
-- The solution is assumed to be valid (rides can be completed and are correctly ordered).
-- Vehicles always start at (0,0) at t=0.
score :: Params -> Solution -> Int
score p s = sum $ map (scoreRides p 0 (0, 0)) s

scoreRides :: Params -> Time -> Position -> Rides -> Int
scoreRides _ _ _   []     = 0
scoreRides p t pos (r:rs) = s + scoreRides p t' pos' rs
  where
    ride          = rides p !! r
    rideDist      = rideDistance ride
    (s, t', pos') = scoreRide t pos ride
    -- TODO: this needs more testing
    scoreRide :: Time -> Position -> Ride -> (Int, Time, Position)
    scoreRide t pos r
        | t + startDist <= startTime r
        = (bonus p + rideDist, startTime r + rideDist, (endRow r, endCol r))
        | otherwise
        = (rideDist, t + startDist + rideDist, (endRow r, endCol r))
        where startDist = distance pos (startRow r, startCol r)