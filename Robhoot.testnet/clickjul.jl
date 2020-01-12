#https://maxmouchet.github.io/ClickHouse.jl/stable/
using ClickHouse
client = ClickHouseClient("http://localhost:8123")

table_sql = """
CREATE TABLE clickhouse_jl_test (
    a UInt32,
    b Float64)
ENGINE MergeTree()
ORDER BY a
"""
