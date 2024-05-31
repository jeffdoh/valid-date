convert_month() {
    case "${1,,}" in
        jan|january|1) echo "Jan" ;;
        feb|february|2) echo "Feb" ;;
        mar|march|3) echo "Mar" ;;
        apr|april|4) echo "Apr" ;;
        may|5) echo "May" ;;
        jun|june|6) echo "Jun" ;;
        jul|july|7) echo "Jul" ;;
        aug|august|8) echo "Aug" ;;
        sep|september|9) echo "Sep" ;;
        oct|october|10) echo "Oct" ;;
        nov|november|11) echo "Nov" ;;
        dec|december|12) echo "Dec" ;;
        *) echo "Invalid" ;;
    esac
}


if [ "$#" -ne 3 ]; then
    echo "입력값 오류"
    exit 1
fi


month=$(convert_month $1)
day=$2
year=$3


if [ "$month" == "Invalid" ]; then
    echo "Invalid month: $1"
    exit 1
fi


if ! [[ $year =~ ^[0-9]+$ ]] || ! [[ $day =~ ^[0-9]+$ ]]; then
    echo "Invalid date: $1 $2 $3"
    exit 1
fi


is_leap=0
if [ $((year % 4)) -ne 0 ]; then
    is_leap=0
elif [ $((year % 400)) -eq 0 ]; then
    is_leap=1
elif [ $((year % 100)) -eq 0 ]; then
    is_leap=0
else
    is_leap=1
fi


declare -A days_in_month=( ["Jan"]=31 ["Feb"]=28 ["Mar"]=31 ["Apr"]=30 ["May"]=31 ["Jun"]=30 ["Jul"]=31 ["Aug"]=31 ["Sep"]=30 ["Oct"]=31 ["Nov"]=30 ["Dec"]=31 )


if [ "$is_leap" -eq 1 ]; then
    days_in_month["Feb"]=29
fi


if [ "$day" -gt "${days_in_month[$month]}" ] || [ "$day" -lt 1 ]; then
    echo "$month $day $year is not a valid date"
    exit 1
fi


echo "$month $day $year"
exit 0

