#installed
#https://github.com/maxmouchet/JuliaRegistry/commit/f6f60db841ba43c4f8657fa77bd6f5ecee627abc
#(v1.0) pkg> add https://github.com/maxmouchet/ClickHouse.jl.git
#Cloning git-repo `https://github.com/maxmouchet/ClickHouse.jl.git`
#Updating git-repo `https://github.com/maxmouchet/ClickHouse.jl.git`
#Resolving package versions...
#Installed Parsers ─ v0.2.22
#Installed CSV ───── v0.4.3
#Updating `~/.julia/environments/v1.0/Project.toml`
#[212d6d54] + ClickHouse v0.0.1 #master (https://github.com/maxmouchet/ClickHouse.jl.git)
#Updating `~/.julia/environments/v1.0/Manifest.toml`
#[336ed68f] + CSV v0.4.3
#[212d6d54] + ClickHouse v0.0.1 #master (https://github.com/maxmouchet/ClickHouse.jl.git)
#[69de0a69] + Parsers v0.2.22

#Random matrix
#https://sunoru.github.io/RandomNumbers.jl/dev/man/mersenne-twisters/
using RandomNumbers.MersenneTwisters#check need
using JuliaDB, IterableTables, FileIO, CSVFiles, CSV, DataFrames, Plots#check need
import Random#check need


#Deliveroo data: 30000 riders 200 cities: 500 riders per city -- 6 deliveries per day per rider

#rng = MersenneTwister(1234);
#output = rand(15:40,1000);
t = table(rand(15:40,3000), rand(150:300,3000), names = [:x, :w]);
FileIO.save("test.csv", t)
df = CSV.File("test.csv") |> DataFrame
histogram(df[:,2])


#Test clickhouse 
#using ClickHouse
#client = ClickHouseClient("http://localhost:8123")


#table_sql = """
#CREATE TABLE clickhouse_jl_test (
#    a UInt32,
#    b Float64)
#ENGINE MergeTree()
#ORDER BY a
#"""

#query(client, table_sql)
#query(client, "INSERT INTO clickhouse_jl_test (a, b) VALUES (1, 3.14) (2, 1.61)")

#query(client, "SELECT * FROM clickhouse_jl_test")


#table_sql = """
#CREATE TABLE test 
#(
#    x UInt32,
#    w Float64
#)
#ENGINE MergeTree()
#ORDER BY x"""

#query(client, table_sql)
#query(client, "INSERT INTO clickhouse_jl_test (a, w) VALUES test.csv")

#cat test.csv | query("INSERT INTO test FORMAT CSV")
#query(client, "INSERT INTO clickhouse_jl_test (a, b) VALUES (1, 3.14) (2, 1.61)")
#query=(client, "INSERT INTO test FORMAT CSV")

#query(client, "SELECT * FROM test")


#table_deliveroo = """
#CREATE TABLE deliveroo (
#    x UInt32,
#    w Float64)
#ENGINE MergeTree()
#ORDER BY x
#"""
#---Query clickhouse
#query(client, table_deliveroo)
#test.csv | client query="INSERT INTO deliveroo FORMAT CSV"
#query(client, "INSERT INTO deliveroo test")


#query(client, "INSERT INTO clickhouse_jl_deliveroo (a, b) VALUES (1, 3.14) (2, 1.61)")
#query="INSERT INTO test FORMAT CSV"
#query(client, "SELECT * FROM clickhouse_jl_deliveroo")
#query(client, "DROP TABLE clickhouse_jl_deliveroo")
