module Spec.Greedy (spec) where

import Greedy
import Types
import Test.Hspec

smallTestParams = Params
    { rows     = 3
    , columns  = 4
    , bonus    = 2
    , steps    = 10
    , vehicles = 2
    , rides    = [ Ride
                     { startRow  = 0
                     , startCol  = 0
                     , endRow    = 1
                     , endCol    = 3
                     , startTime = 2
                     , endTime   = 9
                     }
                 , Ride
                     { startRow  = 1
                     , startCol  = 2
                     , endRow    = 1
                     , endCol    = 0
                     , startTime = 0
                     , endTime   = 9
                     }
                 , Ride
                     { startRow  = 2
                     , startCol  = 0
                     , endRow    = 2
                     , endCol    = 2
                     , startTime = 0
                     , endTime   = 9
                     }
                 ]
    }

spec :: Spec
spec = describe "Greedy" $ it "solves the small input" $ do
    let solution = solve smallTestParams
    solution `shouldBe` [[0, 1], [2]]
