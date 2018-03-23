module Spec.Score (spec) where

import Types
import Score
import Test.Hspec

testParams = Params
    { rows     = 4
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
                 , Ride
                     { startRow  = 2
                     , startCol  = 1
                     , endRow    = 3
                     , endCol    = 3
                     , startTime = 2
                     , endTime   = 10
                     }
                 , Ride
                     { startRow  = 3
                     , startCol  = 3
                     , endRow    = 1
                     , endCol    = 3
                     , startTime = 5
                     , endTime   = 10
                     }
                 , Ride
                     { startRow  = 3
                     , startCol  = 3
                     , endRow    = 1
                     , endCol    = 3
                     , startTime = 4
                     , endTime   = 10
                     }
                 ]
    , bonus    = 2
    , steps    = 10
    }

spec :: Spec
spec = do
    describe "Score" $ do

        it "should handle empty solution" $ score testParams [] `shouldBe` 0

        it "should handle single vehicle"
            $          score testParams [[2, 1]]
            `shouldBe` 4

        it "should handle two vehicles"
            $          score testParams [[0], [2, 1]]
            `shouldBe` 10

        it "should get bonus if right on time"
            $          score testParams [[3, 4]]
            `shouldBe` 9

        it "should miss bonus if too late"
            $          score testParams [[3, 5]]
            `shouldBe` 7

    describe "Score Ride" $ do
        let testRide = Ride
                { startRow  = 1
                , startCol  = 2
                , endRow    = 4
                , endCol    = 7
                , startTime = 4
                , endTime   = 15
                }

        it "should correctly compute score with bonus"
            $ let (s, _) = scoreRide 2 (3, (1, 1)) testRide in s `shouldBe` 10

        it "should correctly compute score without bonus"
            $ let (s, _) = scoreRide 30 (3, (0, 1)) testRide in s `shouldBe` 8

        it "should correctly update vehicle state with wait"
            $ let (_, p) = scoreRide 1 (0, (1, 1)) testRide
              in  p `shouldBe` (12, (4, 7))

        it "should correctly update vehicle state with no wait"
            $ let (_, p) = scoreRide 1 (3, (0, 1)) testRide
              in  p `shouldBe` (13, (4, 7))

