#wget -O companies.csv "http://www.nasdaq.com/screening/companies-by-name.aspx?letter=0&exchange=nasdaq&render=download"
using JuliaDB, IterableTables, FileIO, CSVFiles, CSV, DataFrames, Plots, StatsPlots
current = CSV.File("companies.csv") |> DataFrame
buy = CSV.File("BuyPrice.csv") |> DataFrame

#for i == 1:N #loop all stickers
A = buy[:,1] .== "GOOGL" #find true
B = current[:,1] .== "GOOGL" #find true

#calculate buy total value
A1 = buy[:,8] .== buy price
A2 = buy[:,7] .== buy amount

B1 = current[:,3] .== last price
A2 = buy[:,7] .== buy amount


Diff(i) = (B1.*A2) - (A1.*A2)
Totalbuy(i) = A1.*A2
#end
