#ibin/bash

# 山手線に入力された駅があるか探す
in_stations() {
  stations=("東京" "有楽町" "新橋" "浜松町" "田町" "品川" "大崎" "五反田" "目黒" "恵比寿" "渋谷" "原宿" "代々木" "新宿" "新大久保" "高田馬場" "目白" "池袋" "大塚" "巣鴨" "駒込" "田端" "西日暮里" "日暮里" "鶯谷" "上野" "御徒町" "秋葉原" "神田") 

  for station in ${stations[@]};do
    # 正解の場合入力値を配列に格納
    if [ $1 = $station ];then
      echo "${1} clear!!"
      cleared=("${cleared[@]}" ${1})
      # 全て正解した場合はスクリプトを終了
      if [ "${#cleared[@]}" -eq 29 ];then
        exit
      fi
      return 0
    fi
  done
  # 以降駅名リストに入力値が見つからない場合に通過
  echo "${1} not found!!"
  return 1
}

# 既に入力された駅名はスキップする
in_cleared() {
  for clear in ${cleared[@]};do
    if [ $1 = $clear ];then
      return 0
    fi
  done
  return 1
}

# START
echo "Let's play yamanote-game!!"
echo "Please press the Enter after typing the station name of the Yamanote Line"
echo "Example 東京 有楽町 新橋 etc.."
cleared=()
while :
do
  read input
  in_cleared $input
  if [ $? -eq 0 ];then
    echo "${input} is already cleared"
    continue
  fi
  in_stations $input
done
