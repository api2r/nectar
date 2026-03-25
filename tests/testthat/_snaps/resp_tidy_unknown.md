# resp_tidy_unknown fails gracefully with object information

    Code
      (expect_pkg_error_classes(resp_tidy_unknown(mock_response), "nectar",
      "unknown_response_type"))
    Output
      <error/nectar-error-unknown_response_type>
      Error:
      ! No parser is defined for this response.
      i Response pieces: structured, other, and status

