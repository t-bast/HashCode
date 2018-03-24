module Greedy (solve) where

import Data.List
import Data.Ord (comparing)
import Distance
import Score
import Types

-- This is the simplest greediest algorithm we can think of.
-- It is O(n2) which is quite bad, but we'll improve that later.
solve :: Params -> Solution
solve p = solve' (vehicles p) [0 .. (-1 +) $ length $ rides $ p]
  where
    solve' :: Int -> Rides -> Solution
    solve' 0 _ = []
    solve' n r = assigned : recSolution
      where
        assigned    = fillVehicle p r
        remaining   = r \\ assigned
        recSolution = solve' (n - 1) remaining

-- fillVehicle takes unassigned rides and chooses a list of rides for that vehicle.
fillVehicle :: Params -> Rides -> Rides
fillVehicle p r = unfoldr (nextRide p) ((0, (0, 0)), r)

-- nextRide choses the next ride and updates the state.
nextRide
    :: Params
    -> (VehicleState, Rides)
    -> Maybe (RideIndex, (VehicleState, Rides))
nextRide p (vs, rs) = best
  where
    validRides  = filter (\ride -> validRide vs (rides p !! ride)) rs
    ridesResult = map
        (\r ->
            let (s, vs') = scoreRide (bonus p) vs (rides p !! r) in (s, r, vs')
        )
        validRides
    best =
        if null ridesResult
        then
            Nothing
        else
            let (s, r, vs') = bestRide ridesResult
            in  Just (r, (vs', rs \\ [r]))

bestRide :: [(Int, RideIndex, VehicleState)] -> (Int, RideIndex, VehicleState)
bestRide [r] = r
bestRide (r@(s, _, _) : rs) | s > s'    = r
                            | otherwise = best'
    where best'@(s', _, _) = bestRide rs

validRide :: VehicleState -> Ride -> Bool
validRide (t, (r, c)) ride | t + startDist <= startTime ride = True
                           | t + startDist + rideDist <= endTime ride = True
                           | otherwise                       = False
  where
    startDist = distance (r, c) (startRow ride, startCol ride)
    rideDist  = rideDistance ride