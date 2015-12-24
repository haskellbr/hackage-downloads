module Main where

import           Control.Monad
import           Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as ByteString
import           Data.Time
import           HackageDownloads
import           Text.HTML.Scalpel
import           Text.Printf

main :: IO ()
main = do
    t <- getCurrentTime
    printf "{\"time\": %s, \"msg\":\"fetching hackage downloads\"}\n" (show t)
    r <- scrapeURL "http://hackage.haskell.org/packages/top" packageDownloadsScraper
    forM_ r (mapM_ (ByteString.putStrLn . encode))
