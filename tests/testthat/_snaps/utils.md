# check_httr2_response errors with not_httr2_response for non-response (#noissue)

    Code
      (expect_pkg_error_classes(check_httr2_response(1), "nectar",
      "not_httr2_response"))
    Output
      <error/nectar-error-not_httr2_response>
      Error:
      ! `x` must be a <httr2_response> object.
      x `x` is a number.

