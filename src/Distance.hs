module Distance where

import Types

rideDistance :: Ride -> Int
rideDistance r = distance (startRow r, startCol r) (endRow r, endCol r)

distance :: Position -> Position -> Int
distance (r1, c1) (r2, c2) = abs (r1 - r2) + abs (c1 - c2)