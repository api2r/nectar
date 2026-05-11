# resp_tidy errors for non-response input (#88)

    Code
      (expect_pkg_error_classes(resp_tidy(1), "nectar", "not_httr2_response"))
    Output
      <error/nectar-error-not_httr2_response>
      Error in `resp_tidy()`:
      ! `x` must be a <httr2_response> object.
      x `x` is a number.

