validate_manifest_data <- function(data)
{
  for (j in seq_len(ncol(data))) {
    values <- data[[j]]
    values <- values[!is.na(values)]

    if (length(values) == 0) {
      next
    }

    if (!is.numeric(values) || any(values %% 1 != 0)) {
      stop("Manifest variables must be coded as integers.", call.=FALSE)
    }

    if (min(values) < 1) {
      stop("Manifest variables must be coded with consecutive integers starting at 1.", call.=FALSE)
    }

    max_val <- max(values)
    if (!identical(sort(unique(values)), seq_len(max_val))) {
      stop("Manifest variables must be coded with consecutive integers starting at 1.", call.=FALSE)
    }
  }
}

validate_grouping <- function(grouping)
{
  values <- grouping[!is.na(grouping)]

  if (length(values) == 0) {
    return(invisible(NULL))
  }

  if (!is.numeric(values) || any(values %% 1 != 0)) {
    stop("Grouping must be coded as integers.", call.=FALSE)
  }

  if (min(values) < 1) {
    stop("Grouping must be coded with consecutive integers starting at 1.", call.=FALSE)
  }

  if (!identical(sort(unique(values)), seq_len(max(values)))) {
    stop("Grouping must be coded with consecutive integers starting at 1.", call.=FALSE)
  }
}
