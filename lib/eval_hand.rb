module EvalHand
  def EvalHand.eval_hand(cards)
    def self.same_number_count(numbers)
      same_numbers = numbers.inject(Hash.new(0)){|hash, a| hash[a] += 1; hash}.values.sort.reverse
    end

    def self.flash?(suits)
      suits.uniq.size == 1
    end

    def self.straight?(numbers)
      steps = numbers.sort.map{|i|i - numbers[0]}
      steps == [0,1,2,3,4] || steps == [0,9,10,11,12]
    end

    role = ["ハイカード", "ワンペア", "ツーペア", "スリー・オブ・ア・カインド", "ストレート", "フラッシュ", "フルハウス", "フォー・オブ・ア・カインド", "ストレートフラッシュ"]
    result = {}
    res = []
    er_res = []
    max_index = 0
    cards.each do |card|
      puts card
      re = {}
      er_re = {}

      hand = card.split(" ")
      suits = []
      numbers = []

      if hand.count != 5
        er_re["card"] = card
        er_re["msg"] = "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
        er_res.push er_re
      elsif hand.size - hand.uniq.size != 0 #同じカードを含んでいたら
        er_re["card"] = card
        er_re["msg"] = "カードが重複しています。"
        er_res.push er_re
      else
        hand.each_with_index do |c, i|
          er_r = {}
          puts c
          puts /[SHDC]/ === c[0,1]
          puts c[1,10]
          puts /(?<!\d)([1-9]|1[0-3])(?!\d)/ === c[1,10]
          if /[SHDC]/ === c[0,1] && /(?<!\d)([1-9]|1[0-3])(?!\d)/ === c[1,10]
            suits.push c[0,1]
            numbers.push c[1,10].to_i
          else
            er_r["card"] = card
            er_r["msg"] = "#{i + 1}番目のカード指定文字が不正です。(#{c})"
            er_res.push er_r
            er_re["error"] = er_r
          end
        end
        if er_re.present?
        else
          case same_number_count(numbers)
            when [2,1,1,1]
              hand = role[1]
            when [2,2,1]
              hand = role[2]
            when [3,1,1]
              hand = role[3]
            when [3,2]
              hand = role[6]
            when [4,1]
              hand = role[7]
            else
              case [straight?(numbers), flash?(suits)]
              when [true, false]
                hand = role[4]
              when [false, true]
                hand = role[5]
              when [true, true]
                hand = role[8]
              else
                hand = role[0]
              end
            end
          re["card"] = card
          re["hand"] = hand
          index = role.find_index(re["hand"]).to_i
          if index > max_index
            max_index = index
          end
          re["best"] = false
          res.push re
        end
      end
    end
    res.each do |r|
      if role.find_index(r["hand"]).to_i == max_index
        r["best"] = true
      end
    end
    result["result"] = res if res.present?
    result["error"] = er_res if er_res.present?
    return result
  end
end
