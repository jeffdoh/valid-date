#!/bin/bash


PHONEBOOK="phonebook.txt"


declare -A AREA_CODES
AREA_CODES=(
    ["02"]="서울"
    ["031"]="경기"
    ["032"]="인천"
    ["051"]="부산"
    ["053"]="대구"
)


if [ "$#" -ne 2 ]; then
    echo "Usage: $0 도준호 010-6545-1606"
    exit 1
fi

name=$1
phone=$2


if [[ ! $phone =~ ^[0-9-]+$ ]]; then
    echo "전화번호 형식이 잘못되었습니다. 숫자와 하이픈만 허용됩니다."
    exit 1
fi


area_code=$(echo $phone | cut -d'-' -f1)
area=${AREA_CODES[$area_code]}

if [ -z "$area" ]; then
    echo "유효한 지역번호가 아닙니다."
    exit 1
fi


if grep -q "^$name " $PHONEBOOK; then
    existing_phone=$(grep "^$name " $PHONEBOOK | awk '{print $2}')
    if [ "$existing_phone" == "$phone" ]; then
        echo "$name님의 전화번호가 이미 등록되어 있습니다."
        exit 0
    else
        echo "$name님의 전화번호가 업데이트 되었습니다."
        grep -v "^$name " $PHONEBOOK > temp && mv temp $PHONEBOOK
    fi
fi


echo "$name $phone $area" >> $PHONEBOOK
sort -o $PHONEBOOK $PHONEBOOK

echo "$name님의 전화번호가 추가되었습니다."

exit 0