{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}
module Stylus where

import qualified Data.Text as T
import           Data.Monoid ((<>))
import           Data.List (partition, groupBy)
import           Tokens (Content(..), sectionDelimiter)

--

parseContent :: T.Text -> [[Content]]
parseContent = map parseSection . T.splitOn sectionDelimiter

parseSection :: T.Text -> [Content]
parseSection = map (parseLine . parseSectionLine) . filter (/= "") . T.lines

parseSectionLine :: T.Text -> Content
parseSectionLine x | T.isPrefixOf "//" x = Describe x
                   | otherwise = Define x

parseLine :: Content -> Content
parseLine (Describe x) = Describe $ T.drop 3 x
parseLine x = x

-- Grouping of conten

groupByType :: [Content] -> [[Content]]
groupByType = groupBy pred
              where pred :: Content -> Content -> Bool
                    pred (Define _) (Define _) = True
                    pred (Describe _) (Describe _) = True
                    pred _ _ = False
