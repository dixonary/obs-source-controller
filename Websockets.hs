{-# LANGUAGE ExtendedDefaultRules #-}

module Websockets where

import Control.Monad (void)
import Data.Aeson
import Data.Aeson.Text
import Data.Aeson.Types (Pair)
import Data.ByteString.Lazy (ByteString)
import Data.Function ((&))
import Data.HashMap.Strict as HM
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.Encoding as Text
import qualified Data.Text.Lazy as Text (fromStrict, toStrict)
import Network.WebSockets.Client

-- Send command, ignoring response
sendCommand_ :: Text -> [Pair] -> IO ()
sendCommand_ = fmap void <$> sendCommand

sendCommand :: Text -> [Pair] -> IO (Maybe Value)
sendCommand req opts = withConnection "ws://localhost:4444" $ \connection -> do
  ["request-type" .= req, "message-id" .= ""] <> opts
    & object
    & encodeToLazyText
    & Text.toStrict
    & sendTextData connection
  x <- receiveData connection :: IO ByteString
  sendClose connection (Text.pack "Goodbye")
  return $ decode x

setScene :: Text -> IO ()
setScene scene =
  sendCommand_ "SetCurrentScene" ["scene-name" .= scene]

setVisible :: Text -> Bool -> IO ()
setVisible item render =
  sendCommand_
    "SetSceneItemProperties"
    ["item" .= item, "visible" .= render, "scene" .= "main"]

getVisible :: Text -> IO Bool
getVisible item = do
  resp <- sendCommand "GetSceneItemProperties" ["item" .= item]
  case resp of
    Just (Object xo) -> case HM.lookup "visible" xo of
      Just (Bool v) -> return v
      _ -> return False
    _ -> return False
