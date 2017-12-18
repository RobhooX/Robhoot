#=
These functions help you a) get a list of all available cryptocurrencies, b) download data for every day of their history, and c) update these data.

# Usage:
	# get a list of coins and write them to file ("../data/cryptocompare_coins.txt")
	get_all_coins(write_to_file=true)

	# download data for your list of coins
	coin_list = read_coin_list_file(coin_list_file)
	get_histoDay(coin_list; toSym="USD", write_folder="./")

	# update the data you have downloaded to include new days since the last time you downloaded/updated them
	update_histoDay(coin_list_file, histoDay_dir"./")
=#

using Requests
using Dates

"
Get a list of available coins on cryptocompare.com api
"
function get_all_coins(;write_to_file=true)
	url = "https://www.cryptocompare.com/api/data/coinlist/"  # api url to get coin list.
	# for help see: https://www.cryptocompare.com/api#-api-data-coinlist-
	getreq = get(url)
	if getreq.status != 200
		println("Could not fetch data, check url or try again later.")
		return
	else
		println("Fetched data successfully!")
	end
	jsonlist = Requests.json(getreq)
	data = jsonlist["Data"]
	name_symbols = keys(data)
	if write_to_file
		out_file = "../data/cryptocompare_coins.txt"
		open(out_file, "w")
		open(out_file, "a") do ff
			for (key, value) in data
				entry = join([key, value["FullName"]], "\t")
				println(ff, entry)
			end
		end
	end
	return name_symbols
end

function read_coin_list_file(coin_list_file)
	coin_list = []
	for line in eachline(open(coin_list_file))
		coin_abbr = split(line, "\t")[1]
		push!(coin_list, coin_abbr)
	end
	return coin_list
end

"""
Get historical day data of a coin from a given date to present
"""
function get_histoDay_partial(coin::String, start_date::DateTime; toSym="USD")
	end_date = DateTime(today() - Day(1))  # yesterday
	output = []
	if end_date > start_date
		for dd in start_date:end_date
			unixdate = Int64(datetime2unix(dd))
			url = "https://min-api.cryptocompare.com/data/histoday?fsym=$(coin)&tsym=$(toSym)&toTs=$(unixdate)&limit=1"
			getreq = 0
			try
				getreq = get(url)
			catch
				println("Unable to query $coin on $dd")
				continue
			end
			if getreq.status == 200
				data = Requests.json(getreq)["Data"]
				for dd2 in 1:length(data)
					jj = data[dd2]
					dd2_date = unix2datetime(jj["time"])
					if dd2_date == dd
						entry = join([dd2_date, jj["open"], jj["close"], jj["low"], jj["high"], jj["volumefrom"], jj["volumeto"]], "\t")
						push!(output, entry)
					end
				end
			end
		end
	end
	return output
end

"
write all open, high, low, close, volumefrom and volumeto daily historical data for each coin in the list and write it to file.
"
function get_histoDay(coin_list; toSym="USD", write_folder="./")
	counter = 0
	for coin in coin_list
		if contains(coin, "*")
			coin = strip(coin, '*')
		end
		coin = strip(coin)
		out_file = joinpath(write_folder, "$(coin)_histoDay.txt")
		url = "https://min-api.cryptocompare.com/data/histoday?fsym=$(coin)&tsym=$(toSym)&allData=true"
		getreq = 0
		try
			getreq = get(url)
		catch
			println("Unable to query the string due to unexpected character in name of $coin")
			counter += 1
			continue
		end
		if getreq.status == 200
			try
				open(out_file, "w")
			catch
				println("Could not write $coin to file, because of its name")
				counter += 1
				continue
			end
			data = Requests.json(getreq)["Data"]
			open(out_file, "a") do ff
				println(ff, join(["#date", "open", "close", "low", "high", "volumefrom", "volumeto"], "\t"))
				for day in 1:length(data)
					jj = data[day]
					date = unix2datetime(jj["time"])
					entry = join([date, jj["open"], jj["close"], jj["low"], jj["high"], jj["volumefrom"], jj["volumeto"]], "\t")
					println(ff, entry)
				end
			end
		else
			counter += 1
			println("Couldn't fetch data for $coin")
		end
	end
	if counter > 0
		println("Did not fetch results for the $counter coins!")
	end
end

"""
Add new data (day history) to each coin file. The program check the history file of each coin, finds the last day for which data are available, and if new data is available, appends them to the files.

# Parameters
coin_list: a file containing a list of available coins, each representing a coin like this: ZCL	ZClassic (ZCL)
histoDay_dir: the directory with history files of each coins, each file named with the pattern: <coin abbr.>_histoDay.txt
"""
function update_histoDay(coin_list_file::String, histoDay_dir)
	coin_list = read_coin_list_file(coin_list_file)
	for coin in coin_list
		file_path = joinpath(histoDay_dir, join([coin, "_histoDay.txt"]))
		if isfile(file_path)
			last_line = readlines(open(file_path))[end]
			if startswith(last_line, "#")  # the file has no data
				get_histoDay([coin], toSym="USD", write_folder=histoDay_dir)
				continue
			end
			fields = split(last_line, "\t")
			last_date = DateTime(fields[1])
			if ~(last_date < DateTime(today() - Day(1)))
				continue
			end
			last_year, last_month, last_day = year(last_date), month(last_date), day(last_date)
			start_date = last_date + Day(1)
			new_data = get_histoDay_partial(String(coin), start_date, toSym="USD")
			if length(new_data) > 0
				println("Adding data to $file_path...")
				open(file_path, "a") do myfile
					for item in new_data
						println(myfile, item)
					end
				end
			end
		else
			get_histoDay([coin], toSym="USD", write_folder=histoDay_dir)
		end
	end
end