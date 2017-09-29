using DataFrames
using Dates

#= 
# usage:
y = dfs_to_matrix(data_dir);

TODO:

  1. Obtain portfolio: D:\projects\cryptoCurrency_trade\src\Robhoot\models\octave-matlab\ModernPortfolioTheory(M1)\Alex\EffFront_Alex.m

An example output: D:\projects\cryptoCurrency_trade\src\Robhoot\models\octave-matlab\ModernPortfolioTheory(M1)\Alex\EffFront_c100000_s20_c1000.txt

=#

"""
  Exclude dataframes with all values zero, or with most values too large, etc.
  Used in create_dataframes()
"""
function choose_dataframes(all_dfs::Array, df_names::Array, max_price)
  final_dfs = []
  final_names = []
  for (index, df) in enumerate(all_dfs)
    closing = df[:close]
    if length(find(closing)) < 10
      continue
    end
    contin = false
    for cc in closing
      if cc > max_price
        println("There are too high values in coin $(df_names[index]). Skipping it.")
        contin = true
        break
      end
    end
    if contin
      continue
    end

    push!(final_dfs, df)
    push!(final_names, df_names[index]);
  end

  return final_dfs, final_names
end


"""
  Create a dataframe for each cryptocurrency history file. Return a list of all dataframes
"""
function create_dataframes(data_dir::String, max_price)
  all_files = readdir(data_dir)
  all_dfs = []
  df_names = []
  for ff in all_files
    df_name = split(ff, "_")[1]
    push!(df_names, df_name)
    df = readtable(joinpath(data_dir, ff),header=true, separator='\t')
    #convert dates to DateTime
    df[:_date] = [DateTime(i) for i in df[:_date]]
    push!(all_dfs, df)
  end
  all_dfs, df_names = choose_dataframes(all_dfs, df_names, max_price)
  return all_dfs, df_names
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
function dfs_to_matrix(data_dir; max_price=10000)
  all_dfs, df_names = create_dataframes(data_dir, max_price)
  max_df_length = longest_df(all_dfs)
  data_matrix = reshape(zeros(max_df_length*length(all_dfs)), (max_df_length, length(all_dfs)))
  for (index, df) in enumerate(all_dfs)
    prices = df[:close]
    price_size = length(prices)
    start_column = max_df_length - price_size
    data_matrix[start_column+1:end, index] = prices
  end

  return data_matrix, df_names
end