-- # Calculating pi with futhark

import "lib/github.com/diku-dk/cpprandom/random"
import "lib/github.com/diku-dk/statistics/statistics"
module s = mk_statistics f64

let mean = s.mean
let stddev = s.stddev

-- Let's generate a bunch of numbers between 0 and 1, and see how many of them
-- are inside the unit circle.  The ratio of the number of points inside the
-- circle to the total number of points is pi/4.

-- Let's first define a function to generate a bunch of uniform random numbers:
module dist = uniform_real_distribution f64 minstd_rand

def sample_uniform rng n : (minstd_rand.rng, [n]f64) =
  let rngs = minstd_rand.split_rng n rng
  let f = dist.rand (0, 1)
  let (rngs, xs) = unzip (map f rngs)
  let rng = minstd_rand.join_rng rngs
  in (rng, xs)

-- Sampling once should give us a set of random numbers:
let rng1 = minstd_rand.rng_from_seed [42] 
-- > sample_uniform rng1 3i64

-- Now we can define a function to check if a point is inside the unit circle.
-- Most of this definition comes from the futhark book, but we've made a few
-- modifications to use the `statistics` library, and to return a tuple of
-- the mean and standard deviation of the points inside the circle.

def sqr (x:f64) = x * x

def in_circle ((x, y): (f64, f64)) : bool =
  sqr x + sqr y < 1.0f64

def pi_arr [n] (arr: [n](f64, f64)) : (f64, f64) =
  let bs = map (f64.bool <-< in_circle) arr
  -- multiply each value by 4
  let bs = map ( 4f64 * ) bs
  let mean_bs = mean bs
  let stddev_bs = stddev bs
  in (mean_bs, stddev_bs)

def main n seed : (f64, f64) =
  let rng = minstd_rand.rng_from_seed [seed]
  let (rng, xs) = sample_uniform rng n
  let (_, ys) = sample_uniform rng n
  in pi_arr (zip xs ys)

-- > main 100000i64 42

-- This result matches closely with the dex-pi example.

-- # References
-- See the following links for repositories used through this module:

-- * https://futhark-book.readthedocs.io/en/latest/random-sampling.html
-- * https://futhark-lang.org/examples/dex-pi.html
-- * https://github.com/diku-dk/statistics
-- * https://github.com/diku-dk/cpprandom