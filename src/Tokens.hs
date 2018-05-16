{-# LANGUAGE OverloadedStrings #-}
module Tokens ( Tag(..)
              , Content(..)
              , sectionDelimiter
              ) where

import qualified Data.Text as T

data Tag
  = SectionTag
  | HeaderTag
  | ParamTag
  deriving (Show, Eq)

data Content a
  = Describe a
  | Define a
  deriving (Show)

--

sectionDelimiter :: T.Text
sectionDelimiter = "@section"
