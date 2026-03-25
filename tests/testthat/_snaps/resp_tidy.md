# resp_tidy fails gracefully for non-responses (#40)

    Code
      (expect_pkg_error_classes(resp_tidy(test_obj), "nectar",
      "unsupported_response_class"))
    Output
      <error/nectar-error-unsupported_response_class>
      Error in `resp_tidy()`:
      ! No method is available to `nectar::resp_tidy()` this object.
      i `nectar::resp_tidy()` expects <httr2_response> objects, or lists thereof.

# resp_tidy fails gracefully for lists of non-responses (#40)

    Code
      (expect_pkg_error_classes(resp_tidy(test_obj), "nectar",
      "unsupported_response_class"))
    Output
      <error/nectar-error-unsupported_response_class>
      Error in `resp_tidy()`:
      ! No method is available to `nectar::resp_tidy()` this object.
      i You might want to try `nectar::resp_parse()` instead.

