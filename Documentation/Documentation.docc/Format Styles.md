#  Included Format Styles

TMDBSwifty includes format styles to simplify displaying values returned from the TMDB API.

## Runtime

``/TMDBSwifty/TMDB/``

All television and movie runtimes are decoded as ``Measurement<UnitDuration>`` objects natively yet runtimes tend to be 
communicated to users as minute values only.

By default, the ``Runtime`` format style will take this into account and can be accessed from the extension on FormatStyle using the `.runtime` computed property:

```swift
let ninetyMinutes = Measurement(value: 90, unit: UnitDuration.minute)

// Outputs "90 min"
ninetyMinutes.formatted(.runtime) 
```

More complicated options can be chosen by using the ``.runtime(style:displayUnit:)`` method.


