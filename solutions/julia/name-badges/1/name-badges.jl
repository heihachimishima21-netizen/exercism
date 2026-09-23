print_name_badge(id, name, department) = "$(!ismissing(id) ? "[" * string(id) * "] - " : "")$name - $(!isnothing(department) ? uppercase(department) : "OWNER")"

salaries_no_id(ids, salaries) = sum(salaries[ismissing.(ids)])