# Send data in request body

Automatically choose between
[`httr2::req_body_json()`](https://httr2.r-lib.org/reference/req_body.html)
and
[`httr2::req_body_multipart()`](https://httr2.r-lib.org/reference/req_body.html)
based on the content of the body. This is currently experimental and
needs to be tested on more APIs.

## Usage

``` r
.req_body_auto(req, body, mime_type = NULL, call = rlang::caller_env())
```

## Arguments

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- body:

  (multiple types) An object to use as the body of the request. If any
  component of the body is a path, pass it through
  [`fs::path()`](https://fs.r-lib.org/reference/path.html) or otherwise
  give it the class "fs_path" to indicate that it is a path.

- mime_type:

  (`length-1 character`) The mime type of any files present in the body.
  Some APIs allow you to leave this as NULL for them to guess.

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

## Value

A modified HTTP
[request](https://httr2.r-lib.org/reference/request.html).
