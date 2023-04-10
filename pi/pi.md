# Calculating pi with futhark

```futhark
def linspace (n: i64) (start: f64) (end: f64) : [n]f64 =
  tabulate n (\i -> start + f64.i64 i * ((end-start)/f64.i64 n))
```

With an evaluation directive, we can show what it evaluates to:

```
> linspace 10i64 0f64 10f64
```

```
[0.0f64, 1.0f64, 2.0f64, 3.0f64, 4.0f64, 5.0f64, 6.0f64, 7.0f64, 8.0f64, 9.0f64]
```


```
> linspace 10i64 5f64 10f64
```

```
[5.0f64, 5.5f64, 6.0f64, 6.5f64, 7.0f64, 7.5f64, 8.0f64, 8.5f64, 9.0f64, 9.5f64]
```

