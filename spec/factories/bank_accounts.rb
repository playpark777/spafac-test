FactoryBot.define do
  factory :bank_account do
    association :profile, factory: :profile
    bank_id { (Bank.first || Bank.create(name: "三井住友銀行", code: "0009")).id }
    branch_code "301"
    branch_name "札幌支店"
    type_of_bank_account_id { (BankAccountType.first ||
                               BankAccountType.create(name: "普通")).id }
    number "0000000"
    name { Gimei.katakana }

    factory :invalid_bank_account do
      number ""
    end
  end
end
