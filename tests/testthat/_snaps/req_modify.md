# req_modify() handles bodies with paths

    Code
      test_result <- req_modify(req_base, body = list(foo = "bar", baz = fs::path(
        test_path("fixtures", "img-test.png"))))
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
      

