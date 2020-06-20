module Main where

import Control.Monad
import Data.Char (toLower)
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Text (Text)
import qualified Data.Text as Text
import Network.WebSockets.Client
import System.IO
import Websockets

type VisMap = Map Char Bool

chars :: [Char]
chars = ['0' .. '9'] ++ ['a' .. 'z']

main :: IO ()
main = do
  hSetBuffering stdin NoBuffering
  hSetBuffering stdout NoBuffering
  -- Get the visual state of the scene items with char names
  viz <-
    fmap (Map.fromList . zip chars)
      $ sequence
      $ (getVisible . Text.pack . (: [])) <$> chars
  loop viz

-- Get a char, and flip its scene item's visibility
loop :: Map Char Bool -> IO ()
loop viz = do
  x <- getChar
  putStr "\b \b"
  if x `elem` chars
    then do
      let viz' = Map.adjust not x viz
      setVisible (Text.pack [x]) $ viz' Map.! (toLower x)
      loop viz'
    else loop viz