-- 9.3
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x


-- 9.4
eftBool :: Bool -> Bool -> [Bool]
eftBool x y
  | x > y = []
  | x == y = [x]
  | otherwise = x : (eftBool (succ x) y)

eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd x y
  | x > y = []
  | x == y = [x]
  | otherwise = x : (eftOrd (succ x) y)

eftInt :: Int -> Int -> [Int]
eftInt x y
  | x > y = []
  | x == y = [x]
  | otherwise = x : (eftInt (succ x) y)

eftChar :: Char -> Char -> [Char]
eftInt x y
  | x > y = []
  | x == y = [x]
  | otherwise = x : (eftChar (succ x) y)


-- 9.5

-- Q: In the final example above, why does it only return a single a?
-- A: Because the first Char matches the condition, but the second does not.


-- 9.6

-- 1)

myWords :: String -> [String]
myWords "" = []
myWords x
  | dropWhile (/=' ') x == "" = [x]
  | otherwise = (takeWhile (/=' ') x) : myWords(dropWhile (==' ') (dropWhile (/=' ') x))

-- 2)

myLines :: String -> [String]
myLines "" = []
myLines x
  | dropWhile (/='\n') x == "" = [x]
  | otherwise = (takeWhile (/='\n') x) : myLines(dropWhile (=='\n') (dropWhile (/='\n') x))

-- 3)

mySplit :: Char -> String -> [String]
mySplit _ "" = []
mySplit c str
  | dropWhile (/=c) str == "" = [str]
  | otherwise = (takeWhile (/=c) str) : (mySplit c (dropWhile (==c) (dropWhile (/=c) str)))

myWords' :: String -> [String]
myWords' x = mySplit ' ' x

myLines' :: String -> [String]
myLines' x = mySplit '\n' x


-- 9.7

-- 1)
[(x,y) | x <- mySqr, y <- myCube]

-- 2)
[(x,y) | x <- mySqr, y <- myCube, x < 50, y < 50]

-- 3)
length [(x,y) | x <- mySqr, y <- myCube, x < 50, y < 50]


-- 9.8

-- Will it blow up?

-- 1) Returns a value (it only blows up if you try to print it)

-- 2) Returns a value: [1]

-- 3) Blows up since sum evaluates over values

-- 4) Returns a value since length only walks the spine

-- 5) Blows up since length forces evaluation of ++, which will error out due
--    to undefined not being a list type

-- 6) Returns a value ([2]) since `take 1 $ filter` stops after finding the
--    first match, and 2 occurs before undefined in the list

-- 7) Errors out since no even values occur before undefined in the list

-- 8) Returns a value ([1]) for the same reason as #6

-- 9) Returns a value ([1, 3])

-- 10) Errors out since `take 3` will be looking for one more match, causing
--     undefined to get evaluated

-- Intermission: Is it in normal form?

-- Note: I'm mainly guessing here because I don't think this WHNF/NF stuff was
-- explained very well at this point to be doing these questions

-- 1) NF

-- 2) WHNF

-- 3) WHNF

-- 4) WHNF

-- 5) WHNF

-- 6) Neither?

-- 7) WHNF


-- 9.9

-- 1) Bottom

-- 2) 2

-- 3) Bottom

-- 4) The inner lambda returns True or False if the given Char is in the list "aeiou".
--    The addition of `map` means it apply it to a [Char] i.e. a String.
--    Its type is: itIsMystery :: String -> [Bool]

-- 5a)
-- [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

-- 5b)
-- [1, 10, 20]

-- 5c)
-- [15, 15, 15]

-- 6)
import Data.Bool
map (\x -> bool x (-x) (x == 3)) [1..10]


-- 9.10

-- 1)
filter (\x -> (rem x 3) == 0) [1..30]
-- or
[x | x <- [1..30], (rem x 3) == 0]

-- 2)
length $ filter (\x -> (rem x 3) == 0) [1..30]

-- 3)
myFilter :: String -> [String]
myFilter str = filter (\x -> not (elem x ["the", "a", "an"])) (words str)


-- 9.11

-- 1)
zip' :: [a] -> [b] -> [(a, b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y) : zip xs ys

-- 2)
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ _ [] = []
zipWith' _ [] _ = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

-- 3)
zip'' :: [a] -> [b] -> [(a, b)]
zip'' xs ys = zipWith' (,) xs ys


-- 9.12

-- Data.Char

-- 1)
isUpper :: Char -> Bool
toUpper :: Char -> Char

-- 2)
import Data.Char
onlyUpper :: String -> String
onlyUpper str = filter isUpper str

-- 3)
capitalize :: String -> String
capitalize "" = ""
capitalize (x:xs) = (toUpper x) : xs

-- 4)
allCaps :: String -> String
allCaps "" = ""
allCaps (x:xs) = (toUpper x) : allCaps xs

-- 5)
firstLetterUpper :: String -> Char
firstLetterUpper str = toUpper (head str)

-- 6)
firstLetterUpper' :: String -> Char
firstLetterUpper' str = (toUpper . head) str

firstLetterUpper'' :: String -> Char
firstLetterUpper'' = toUpper . head

-- Ciphers

-- See cipher.hs

-- Writing your own standard functions

-- 1)
myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = x || myOr xs

-- 2)
myAny :: (a -> Bool) -> [a] -> Bool
myAny _ [] = False
myAny f (x:xs) = f x || myAny f xs

-- 3)
myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem x (y:ys) = x == y || myElem x ys

myElem' :: Eq a => a -> [a] -> Bool
myElem' x ys = any (==x) ys

-- 4)
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = (myReverse xs) ++ [x]

-- 5)
squish :: [[a]] -> [a]
squish [] = []
squish (x:xs) = x ++ squish xs

-- 6)
squishMap :: (a -> [b]) -> [a] -> [b]
squishMap _ [] = []
squishMap f xs = squish (map f xs)

-- 7)
squishAgain :: [[a]] -> [a]
squishAgain x = squishMap (\x -> x) x

-- 8)
myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ (x:[]) = x
myMaximumBy f (x:xs) = if (f x (myMaximumBy f xs)) == GT then x else (myMaximumBy f xs)

-- 9)
myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ (x:[]) = x
myMinimumBy f (x:xs) = if (f x (myMinimumBy f xs)) == LT then x else (myMinimumBy f xs)

myMaximum :: (Ord a) => [a] -> a
myMaximum xs = myMaximumBy compare xs

myMinimum :: (Ord a) => [a] -> a
myMinimum xs = myMinimumBy compare xs
