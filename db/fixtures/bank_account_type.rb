bank_account_types = %w(普通 当座)
bank_account_types.each { |type| BankAccountType.create(name: type) }
