#!/bin/bash

player_hp=100
bot_hp=100

log_file="battle_log.txt"
echo "=== New Battle Session: $(date)===" >> $log_file

while [ $player_hp -gt 0 ] && [ $bot_hp -gt 0 ]; do
  echo "Your HP: $player_hp | Bot HP: $bot_hp"
  echo "Choose your move: [1] Attack [2] Defend"
  read move

  bot_move=$((RANDOM%2+1)) # 1 or 2

  if [ "$move" -eq 1 ]; then
    if [ "$bot_move" -eq 2 ]; then
      damage=5
    else
      damage=15
    fi
    bot_hp=$((bot_hp - damage))
    echo "You Attacked. Bot defended? $([ $bot_move -eq 2 ] && echo yes || echo no). Bot lost $damage HP."


  else
    if [ "$bot_move" -eq 1 ]; then
      damage=5
    else
      damage=0
    fi
    player_hp=$((player_hp - damage))
    echo "You defended. Bot attacked? $([ $bot_move -eq 1 ] && echo yes || echo no). You lost $damage HP"

  fi

    echo "Turn summary: Player HP=$player_hp, Bot HP=$bot_hp" >> "$log_file"
    echo ""

done

if [ $player_hp -le 0 ]; then
  echo "You lost" | tee -a "$log_file"
else
  echo "You won" | tee -a "$log_file"

# commit
git add $log_file
git commit -m "Battle on $(date)"

# run chmod +x battle.sh and then ./battle.sh to run game
