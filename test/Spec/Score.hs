module Spec.Score (spec) where

import Types
import Score
import Test.Hspec

testParams = Params
    { rows     = 3
    , columns  = 4
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
    , bonus    = 2
    , steps    = 10
    }

spec :: Spec
spec = describe "Score" $ do
    it "should handle empty solution" $ score testParams [] `shouldBe` 0
    it "should handle simple solution"
        $          score testParams [[0], [2, 1]]
        `shouldBe` 10