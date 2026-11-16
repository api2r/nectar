# .req_policy errors informatively for unnamed policies

    Code
      .req_policy(req, list(my_policy = "whatever"))
    Condition <nectar-error-bad_policy>
      Error:
      ! All components of `...` must be named.

