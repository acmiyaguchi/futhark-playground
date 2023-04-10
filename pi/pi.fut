-- # Calculating pi with futhark

def linspace (n: i64) (start: f64) (end: f64) : [n]f64 =
  tabulate n (\i -> start + f64.i64 i * ((end-start)/f64.i64 n))

-- With an evaluation directive, we can show what it evaluates to:

-- > linspace 10i64 0f64 10f64

-- > linspace 10i64 5f64 10f64
