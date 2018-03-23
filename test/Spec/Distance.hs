module Spec.Distance (spec) where

import Types
import Distance
import Test.Hspec

spec :: Spec
spec = describe "Distance" $ do
    it "should correctly compute distance" $ distance (1, 2) (5, 5) `shouldBe` 7
    it "should detect null distance" $ distance (42, 42) (42, 42) `shouldBe` 0
    it "should correctly compute ride distance" $ do
        let ride = Ride
                { startRow  = 1
                , startCol  = 2
                , endRow    = 1
                , endCol    = 5
                , startTime = 1
                , endTime   = 42
                }
        rideDistance ride `shouldBe` 3
