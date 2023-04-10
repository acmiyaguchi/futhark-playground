-- # Calculating pi with futhark

import "lib/github.com/diku-dk/statistics/statistics"
module s = mk_statistics f64

-- sample from a uniform distribution n times
let sample_uniform (n:i64) : [n]f64 =
  let d = s.mk_uniform {a=0f64, b=1f64}
  let ones = replicate n 0.7
  let samples = map (\u -> s.sample d u) ones
  in samples

-- > sample_uniform 5i64

def sqr (x:f64) = x * x

def in_circle (p: []f64) : bool =
  sqr p[0] + sqr p[1] < 1.0f64

def pi_arr [n] (arr: [n][]f64) : f64 =
  let bs = map (i32.bool <-< in_circle) arr
  let sum = reduce (+) 0 bs
  in 4f64 * r64 sum / f64.i64 n

-- def main (n:i64) : f64 =
--   let arr = sample_uniform n
--   in pi_arr arr


-- # References
-- See the following links for repositories used through this module:

-- * https://futhark-book.readthedocs.io/en/latest/random-sampling.html
-- * https://futhark-lang.org/examples/dex-pi.html
-- * https://github.com/diku-dk/statistics