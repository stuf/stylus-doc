module Main where

import qualified Data.Text as T
import           Control.Monad
import           Stylus       (parseContent)

infile :: FilePath
infile = "test.styl"

readData :: FilePath -> IO T.Text
readData = liftM T.pack . readFile

main :: IO ()
main = do
  file <- readData infile
  putStrLn "hello world"

  let parsed = parseContent file
  forM_ parsed $ print

  return ()
