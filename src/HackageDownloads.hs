{-# LANGUAGE TemplateHaskell #-}
module HackageDownloads where

import           Data.Aeson.TH
import           Data.Char
import           Text.HTML.Scalpel

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

deriveJSON defaultOptions
    { fieldLabelModifier = map toLower . drop (length "package")
    } ''PackageDownloads

scrapePackageDownloads :: IO (Maybe [PackageDownloads])
scrapePackageDownloads =
    scrapeURL "http://hackage.haskell.org/packages/top" packageDownloadsScraper
