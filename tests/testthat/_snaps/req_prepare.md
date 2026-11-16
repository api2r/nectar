# bodies with paths are handled properly (#6)

    Code
      test_result <- req_prepare(base_url = "https://example.com", body = list(foo = "bar",
        baz = fs::path(test_path("fixtures", "img-test.png"))))
      test_result$body
    Output
      $data
      $data$foo
      Form data of length 5 (type: application/json) 
      
      $data$baz
      Form file: img-test.png 
      
      
      $type
      [1] "multipart"
      
      $content_type
      NULL
      
      $params
      list()
      

# req_prepare() errors for unsupported tidy policy objects (#86)

    Code
      req_prepare(base_url = "https://example.com", tidy_policy = "not_tidy_policy")
    Condition <nectar-error-unsupported_tidy_policy_class>
      Error:
      ! `not_tidy_policy` must be `NULL` or a <nectar_tidy_policy>.
      x `not_tidy_policy` is a string.

# req_prepare() errors for unsupported auth objects (#81)

    Code
      req_prepare(base_url = "https://example.com", auth = "not_auth")
    Condition <nectar-error-unsupported_auth_class>
      Error:
      ! `not_auth` must be `NULL` or a <nectar_auth>.
      x `not_auth` is a string.

# .as_nectar_request() fails gracefully for non-reqs

    Code
      .as_nectar_request(test_obj)
    Condition <nectar-error-unsupported_request_class>
      Error:
      ! `1` must be a <httr2_request>.
      x `1` is a number.

