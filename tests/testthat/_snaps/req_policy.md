# .req_policy errors informatively for unnamed policies

    Code
      (expect_pkg_error_classes(.req_policy(req, list(my_policy = "whatever")),
      "nectar", "bad_policy"))
    Output
      <error/nectar-error-bad_policy>
      Error:
      ! All components of `...` must be named.

