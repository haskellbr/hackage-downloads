{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Concurrent
import           Control.Concurrent.STM
import           Control.Monad
import           Control.Monad.IO.Class
import           HackageDownloads
import           Web.Spock.Safe
import           Web.Spock.Worker

onScrapeError :: ErrorHandler conn sess st a
onScrapeError = ErrorHandlerIO $ \e _ -> do
    print e
    return WorkError

scraperWorkerHandler :: WorkHandler () () (TVar [PackageDownloads]) ()
scraperWorkerHandler = const $ do
    liftIO $ putStrLn "Scrapping Hackage..."
    mpkgDs <- liftIO scrapePackageDownloads
    case mpkgDs of
        Just pkgDs -> do
            st <- getState
            liftIO $ atomically (writeTVar st pkgDs)
            return WorkComplete
        Nothing -> return WorkError

main :: IO ()
main = do
    st <- newTVarIO []
    runSpock 3000 $ spock (defaultSpockCfg () PCNoDatabase st) $ do
        queue <- let cnf = WorkerConfig 1 WorkerNoConcurrency
          in newWorker cnf scraperWorkerHandler onScrapeError

        _ <- liftIO $ forkIO $ forever $ do
            addWork WorkNow () queue
            threadDelay (1000 * 1000 * 60 * 10)

        get "/" $ do
            pkgDs <- liftIO $ readTVarIO st
            json pkgDs
