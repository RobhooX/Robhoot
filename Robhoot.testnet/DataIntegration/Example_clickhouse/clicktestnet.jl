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

query(client, table_sql)
query(client, "INSERT INTO clickhouse_jl_test (a, b) VALUES (1, 3.14) (2, 1.61)")

query(client, "SELECT * FROM clickhouse_jl_test")

