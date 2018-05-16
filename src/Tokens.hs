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

data Content
  = Describe T.Text
  | Define T.Text
  deriving (Show)

--

sectionDelimiter :: T.Text
sectionDelimiter = "@section"
