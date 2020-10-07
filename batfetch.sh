# Colors
green=`tput setaf 2` # Green color.
reset=`tput sgr0` # Reset Color.

# Bold Font
bold=`tput bold`

echo "${bold}${green}Welcome to Batfetch!${reset}"

# Battery data directory of linux system.
dir="/sys/class/power_supply/"

# Array to store the name of files having battery information.
files=(
manufacturer # Reports the name of the device manufacturer.
model_name # Reports the name of the device model.
capacity # Fine grain representation of battery capacity.
status # Represents the charging status of the battery.
technology #Describes the battery technology supported by the supply.
type # Describes the main type of the supply.
capacity_level # Reports an average IBAT current reading for the battery.
charge_now # Reports the current coloumb counter value inside the battery monitor chip.
charge_full # Reports the assumed battery 'full level'
current_now # Reports the IBUS current supplied now.
serial_number # Reports the serial number of the device.
voltage_now # Reports an instant, single VBAT voltage reading for the battery.
voltage_min_design #Reports the minimum safe VBAT voltage permitted for the battery, during discharging
)

# Properties name of information.
property=(
Manufacturer 
Model\ Name 
Capacity 
Status 
Technology 
Type 
Capacity\ Level 
Charge\ Now 
Charge\ Full 
Current\ Now 
Serial\ Number 
Voltage\ Now 
Voltage\ Min\ Design 
)

# Array to store
batteries=()

# Get all the batteries from system.
for directory in $(ls -d $dir*/); do
    if [ "${directory:24:1}" = "B" ]; then
        batteries+=($directory)
    fi
done

# Looping through all the available batteries.
for bat in ${batteries[@]}; do
    echo ""
    echo "${bold}${green}Battery ---> ${bat:24:4}${reset}"
    echo "-----------------"
    # Looping to get all the data for a battery.
    for index in ${!files[@]}; do
        echo ${bold}${green}${property[index]}:${reset} $(cat $bat${files[index]})
    done
done
