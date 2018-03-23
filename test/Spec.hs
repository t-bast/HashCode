import Test.Hspec

import qualified Spec.Distance
import qualified Spec.Score

main :: IO ()
main = hspec $ do
    Spec.Score.spec
    Spec.Distance.spec
