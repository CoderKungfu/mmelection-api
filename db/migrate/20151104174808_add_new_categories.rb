class AddNewCategories < ActiveRecord::Migration
  def self.up
    categories = [
      "ႀကိဳတင္မဲ မသမာမႈ",
      "ပိုမဲ မသမာမႈ",
      " ေရြးေကာက္ပြဲ ႏွင့္ ဆက္စပ္ အၾကမ္းဖက္မႈ"
    ]

    i = 21
    categories.each do |description|
      i = i + 1
      code = "type_#{i}"
      FraudCategory.create(code: code, description: description)
    end
  end

  def self.down
  end
end
