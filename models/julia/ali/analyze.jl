using DataFrames
using Dates

#= 
# usage:
dfs_to_matrix(data_dir)

TODO:
1. Clean the code
  b) Make plots in model portfolio and fix the code for your dataset

2. Obtain portfolio: D:\projects\cryptoCurrency_trade\src\Robhoot\models\octave-matlab\ModernPortfolioTheory(M1)\Alex\EffFront_Alex.m

An example output: D:\projects\cryptoCurrency_trade\src\Robhoot\models\octave-matlab\ModernPortfolioTheory(M1)\Alex\EffFront_c100000_s20_c1000.txt

=#

"""
  Create a dataframe for each cryptocurrency history file. Return a list of all dataframes
"""
function create_dataframes(data_dir::String)
  all_files = readdir(data_dir)
  all_dfs = []
  for ff in all_files
    df = readtable(joinpath(data_dir, ff),header=true, separator='\t')
    #convert dates to DateTime
    df[:_date] = [DateTime(i) for i in df[:_date]]
    push!(all_dfs, df)
  end
  return all_dfs
end

"""
  Returns the length of the longest dataframe given a list of dataframes.
"""
function longest_df(all_dfs)
  max_df_length = 0
  for df in all_dfs
    df_size = size(df)[1]
    if df_size > max_df_length
      max_df_length = df_size
    end
  end
  return max_df_length
end

"""
  creates and returns a matrix with number of columns as number of coins and number of rows as max_df_length

  # parameters
  data_dir: directory containing history files for each coin
"""
function dfs_to_matrix(data_dir)
  all_dfs = create_dataframes(data_dir)
  max_df_length = longest_df(all_dfs)
  data_matrix = reshape(zeros(max_df_length*length(all_dfs)), (max_df_length, length(all_dfs)))
  for (index, df) in enumerate(all_dfs)
    prices = df[:close]
    price_size = length(prices)
    start_column = max_df_length - price_size
    data_matrix[start_column+1:end, index] = prices
  end
  return data_matrix
end