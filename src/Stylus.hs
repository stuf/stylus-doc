{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}
module Stylus where

import qualified Data.Text as T
import           Data.Monoid ((<>))
import           Data.List (partition, groupBy)
import           Tokens (Content(..), sectionDelimiter)

--

type TextContent = Content T.Text

parseContent :: T.Text -> [[TextContent]]
parseContent = map parseSection . T.splitOn sectionDelimiter

parseSection :: T.Text -> [TextContent]
parseSection = map (parseLine . parseSectionLine) . filter (/= "") . T.lines

parseSectionLine :: T.Text -> TextContent
parseSectionLine x | T.isPrefixOf "//" x = Describe x
                   | otherwise = Define x

parseLine :: TextContent -> TextContent
parseLine (Describe x) = Describe $ T.drop 3 x
parseLine x = x

-- Convert

appendLine :: T.Text -> TextContent -> T.Text
appendLine xs (Describe x) = xs <> x
appendLine xs (Define x) = xs <> x

foldLines :: [TextContent] -> T.Text
foldLines xs = foldl appendLine "" xs


-- Grouping of conten

groupByType :: [TextContent] -> [[TextContent]]
groupByType = groupBy pred
              where pred :: TextContent -> TextContent -> Bool
                    pred (Define _) (Define _) = True
                    pred (Describe _) (Describe _) = True
                    pred _ _ = False
