
"convert a json object to DataFrame"
function json2df(input, mainentry::Symbol)
  cols = reduce(∩, keys.(input[mainentry]))
  df = DataFrame((Symbol(c)=>getindex.(input[mainentry], c) for c ∈ cols)...)
  return df
end

# TODO
function json2sqlite(input)
end
