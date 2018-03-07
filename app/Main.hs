module Main (main) where

import Data.List
import Types

main :: IO ()
main = do
    params <- parse
    print $ params

parse :: IO Params
parse = do
    input   <- getLine
    content <- readFile ("inputs/" ++ input ++ ".in")
    let inputLines = lines content
    let [r, c, f, n, b, t] =
            map (\x -> read x :: Int) . words . head $ inputLines
    let rides = map parseRide $ tail inputLines
    return Params
        { rows     = r
        , columns  = c
        , vehicles = f
        , rides    = rides
        , bonus    = b
        , steps    = t
        }

parseRide :: String -> Ride
parseRide r =
    let [a, b, x, y, s, f] = map (\x -> read x :: Int) . words $ r
    in  Ride
            { startRow  = a
            , startCol  = b
            , endRow    = x
            , endCol    = y
            , startTime = s
            , endTime   = f
            }

outputSolution :: String -> Solution -> IO ()
outputSolution input sol = do
    let outputs = map outputVehicle sol
    writeFile ("outputs/" ++ input ++ ".out") (intercalate "\n" outputs)
  where
    outputVehicle :: Rides -> String
    outputVehicle rides =
        show (length rides) ++ " " ++ unwords (map show rides)