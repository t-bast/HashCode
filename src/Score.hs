module Score (score, scoreRide) where

import Distance
import Types

-- score scores a given solution. 
-- The solution is assumed to be valid (rides can be completed and are correctly ordered).
-- Vehicles always start at (0,0) at t=-1 (they make a move at t=0).
score :: Params -> Solution -> Int
score p s = sum $ map (scoreRides p (-1, (0, 0))) s

-- scoreRide scores a ride.
-- It also returns the vehicle state after taking that ride.
scoreRide :: Bonus -> VehicleState -> Ride -> (Int, VehicleState)
scoreRide b (t, pos) r
  | t + startDist <= startTime r
  = (b + rideDist, (startTime r + rideDist, (endRow r, endCol r)))
  | otherwise
  = (rideDist, (t + startDist + rideDist, (endRow r, endCol r)))
 where
  rideDist  = rideDistance r
  startDist = distance pos (startRow r, startCol r)

scoreRides :: Params -> VehicleState -> Rides -> Int
scoreRides _ _        []       = 0
scoreRides p (t, pos) (r : rs) = s + scoreRides p (t', pos') rs
 where
  ride            = rides p !! r
  rideDist        = rideDistance ride
  (s, (t', pos')) = scoreRide (bonus p) (t, pos) ride

