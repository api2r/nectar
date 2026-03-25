# resp_parse fails gracefully for unsupported classes (#40)

    Code
      (expect_pkg_error_classes(resp_parse(1), "nectar", "unsupported_response_class")
      )
    Output
      <error/nectar-error-unsupported_response_class>
      Error:
      ! `1` must be a <list> or a <httr2_response>.
      x `1` is a number.

