#!/bin/sh

get_mic_default() {
    pactl info | tail -2 | head  -n 1 | awk '{print $4}'  
}

is_mic_muted() {
    pactl get-source-mute "$(get_mic_default)" | awk '{print $2}'
}

get_mic_status() {
    get_mic_default=$(pactl info | awk '/Default Source:/ {print $3}')
    mutedado=$(pactl get-source-mute "$get_mic_default" | awk '{print $2}')
    if [ "$mutedado" = "yes" ]; then
        printf "%s\n" " "
   
    else
         #volumen=$(pactl list sources | grep -E "Volumen: front-left"  | tail -1 | awk '{print $5}')
        #volumen=$(amixer get Capture | tail -1 | awk '{print $5}'    )
        #printf "%s\n" " $volumen"
        # pactl list sources | grep -E "Volumen: front-left"  | tail -1 | awk '{print $5}'
         #echo "$volumen"
         #echo "$(pactl list sources | grep -E "Volumen: front-left" | tail -1 | awk '{print $5}')" 
            volumen=$(pacmd list-sources | grep "\* index:" -A 7 | grep volume | awk -F/ '{print $2}' | tr -d ' ' )
            echo " $volumen" 
fi
}



listen() {
    
    LANG=EN; pactl subscribe | while read -r event; do
        if printf "%s\n" "${event}" | grep -qE '(source|server)'; then
            get_mic_status
        fi
    done

}

increase(){
    pactl set-source-volume @DEFAULT_SOURCE@ +5%

}
decrease(){
    pactl set-source-volume @DEFAULT_SOURCE@ -5%

}

toggle() {
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
}

case "${1}" in
 --toggle)
        toggle
        ;;
    --increase)
        increase
        ;;
    --decrease)
        decrease
        ;;
    *)
        listen
        ;;
esac