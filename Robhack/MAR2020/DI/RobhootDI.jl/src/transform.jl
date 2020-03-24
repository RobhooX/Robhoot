
"convert a json object to DataFrame"
function json2df(input)
  cols = reduce(∩, keys.(input[:data]))
  df = DataFrame((Symbol(c)=>getindex.(input[:data], c) for c ∈ cols)...)
  return df
end

# TODO
function json2sqlite(input)
end

#=
using ClickHouse
client = ClickHouseClient("http://localhost:8123")


table_sql = """
CREATE TABLE clickhouse_jl_test (
    a UInt32,
    b Float64)
ENGINE MergeTree()
ORDER BY a
"""

query(client, table_sql)
query(client, "INSERT INTO clickhouse_jl_test (a, b) VALUES (1, 3.14) (2, 1.61)")

query(client, "SELECT * FROM clickhouse_jl_test")
=#