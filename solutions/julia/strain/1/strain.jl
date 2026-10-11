keep(values, predicate) = values[predicate.(values)]
discard(values, predicate) = setdiff(values, keep(values, predicate))