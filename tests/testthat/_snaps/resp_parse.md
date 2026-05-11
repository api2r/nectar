# resp_parse fails gracefully for unsupported classes (#40)

    Code
      (expect_pkg_error_classes(resp_parse(1), "nectar", "unsupported_response_class")
      )
    Output
      <error/nectar-error-unsupported_response_class>
      Error:
      ! `1` must be a <httr2_response> or a <list> of <httr2_response> objects.
      x `1` is a number.

# resp_parse fails gracefully for list of non-responses (#88)

    Code
      (expect_pkg_error_classes(resp_parse(list(1, 2)), "nectar",
      "unsupported_response_class"))
    Output
      <error/nectar-error-unsupported_response_class>
      Error in `resp_parse()`:
      ! `resps` must be a list of <httr2_response> objects.
      x Not all elements of `resps` are <httr2_response> objects.

