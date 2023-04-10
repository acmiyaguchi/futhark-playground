-- # Calculating pi with futhark

import "lib/github.com/diku-dk/statistics/statistics"
module s = mk_statistics f64
let mean = s.mean

-- > mean [3.0f64,4.5f64,6.0f64,6.5f64]

-- # References
-- See the following links for repositories used through this module:

-- * https://futhark-book.readthedocs.io/en/latest/random-sampling.html
-- * https://futhark-lang.org/examples/dex-pi.html
-- * https://github.com/diku-dk/statistics