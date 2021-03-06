----------------------------------------------------------------------------
-- |
-- Module      :  Spot.Randaut
-- Maintainer  :  Marvin Stenger
--
-- TODO
--
-----------------------------------------------------------------------------

{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE LambdaCase            #-}
{-# LANGUAGE NamedFieldPuns        #-}

-----------------------------------------------------------------------------
module Spot.Randaut
  ( RandautResult(..)
  , randautCMD
  ) where

-----------------------------------------------------------------------------

import Utils (cmd)

import System.Exit (ExitCode(..))

-----------------------------------------------------------------------------
data RandautResult =
    RandautSuccess String
  | RandautFailure String
  | RandautException String

-----------------------------------------------------------------------------
-- | randaut (spot) plain wrapper
randautCMD :: String -> [String] -> IO RandautResult
randautCMD stdin args =
  cmd "randaut" stdin args
  >>= \case
    Left err                    -> return $ RandautException err
    Right (ExitSuccess,out,_)   -> return $ RandautSuccess out
    Right (ExitFailure _,_,err) -> return $ RandautFailure err
