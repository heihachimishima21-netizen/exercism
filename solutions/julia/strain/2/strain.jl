keep(values, predicate) = values[predicate.(values)]
discard(values, predicate) = keep(values, !predicate)