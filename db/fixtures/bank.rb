banks = {}
banks = CSV.read('./db/fixtures/bank_list.csv').map { |row| {code: row[0], name: row[1]} }
banks.each { |bank| Bank.create(code: bank[:code], name: bank[:name]) }
