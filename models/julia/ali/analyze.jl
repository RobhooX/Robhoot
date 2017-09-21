using DataFrames
using Dates

#= 
# usage:
y = dfs_to_matrix(data_dir);

TODO:

  1. FIXME: Julia is unable to take inverse of matrix M in function efficient_frontier if model_portfolio_data.jl 
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
    if ff == "42_histoDay.txt" || ff == "SWT_histoDay.txt"
      continue
    end
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
  all_files = readdir(data_dir)
  all_dfs = create_dataframes(data_dir)
  max_df_length = longest_df(all_dfs)
  data_matrix = reshape(zeros(max_df_length*length(all_dfs)), (max_df_length, length(all_dfs)))
  for (index, df) in enumerate(all_dfs)
    prices = df[:close]
    price_size = length(prices)
    start_column = max_df_length - price_size
    data_matrix[start_column+1:end, index] = prices
  end

  # sanity check of data
  problems = []
  for col in 1:length(data_matrix[1, :])
    for row in 1:length(data_matrix[:, 1])
      if data_matrix[row, col] > 20000
        println("Extra large prices. Problems in $(all_files[col]) at line $row in the matrix")
        push!(problems, (row, col))
      end
    end
  end

  return data_matrix
end