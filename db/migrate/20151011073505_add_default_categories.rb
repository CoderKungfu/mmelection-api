class AddDefaultCategories < ActiveRecord::Migration
  def self.up
    categories = [
      "Bribing voters",
      "Threatening voters",
      "Campaigning by utilizing a certain religion or religious conspiracies",
      "Preventing vote casting and campaigning against successful election",
      "Destroying election materials of election commission",
      "Destroying voters list, ballot paper and advance ballot paper",
      "Transferring ballots to another person or voter",
      "Dropping of non-ballot items in ballot boxes",
      "Unauthorised opening of ballot boxes",
      "Casting of vote in multiple constituencies for a HlutTaw (a house of parliament)",
      "Multiple casting of vote in a constituency for a HlutTaw (a house of parliament)",
      "Impersonating to get other voters' ballots",
      "Unauthorized access or unauthorized entering into a polling booth and station",
      "Using fake ballots in casting",
      "Preventing of vote casting",
      "Campaigning within 500 yards of polling stations on election day",
      "Utilizing loudspeaker or violence within 500 yards of polling stations",
      "Employers not allowing time off for employees to vote",
      "Preventing secret voting or forcing to vote in non-secret area",
      "Disapproving or declining admission of registered monitoring organizations into polling stations",
      "Disallowing exchanging spoiled ballots or invalid ballots"
    ]

    categories.each_index do |i|
      description = categories[i]
      code = "type_#{i+1}"
      FraudCategory.create(code: code, description: description)
    end
  end

  def self.down
  end
end
