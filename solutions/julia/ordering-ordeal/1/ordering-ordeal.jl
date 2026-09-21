function sortquantity!(qty)
    desc_idx = sortperm(qty, rev=true)
    sort!(qty, rev=true)
    desc_idx
end

sortcustomer(cust, srtperm) = cust[srtperm]

function production_schedule!(cust, qty)
    desc_idx = sortquantity!(qty)
    cust_ord = sortcustomer(cust, desc_idx)
    cust_ord, sortperm(cust_ord)
end