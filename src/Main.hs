{-# LANGUAGE TemplateHaskell #-}
module Main where

import           Control.Monad              (forM_)
import           Data.Aeson
import           Data.Aeson.TH
import qualified Data.ByteString.Lazy.Char8 as ByteString
import           Data.Char
import           Data.Time
import           Text.HTML.Scalpel
import           Text.Printf

main :: IO ()
main = do
    t <- getCurrentTime
    printf "{\"time\": %s, \"msg\":\"fetching hackage downloads\"}\n" (show t)
    r <- scrapeURL "http://hackage.haskell.org/packages/top" packageDownloadsScraper
    forM_ r (mapM_ (ByteString.putStrLn . encode))

packageDownloadsScraper :: Scraper String [PackageDownloads]
packageDownloadsScraper = chroots "tr" $ do
    tds <- texts "td"
    case tds of
        (name:downloads:_) -> do
            href <- attr "href" "a"
            return $ PackageDownloads name href (read downloads)
        _ -> fail "Couldn't parse"

data PackageDownloads = PackageDownloads { packageName      :: String
                                         , packageHref      :: String
                                         , packageDownloads :: Int
                                         }
  deriving(Show)

deriveJSON defaultOptions { fieldLabelModifier = map toLower . drop (length "package")
                          } ''PackageDownloads
