echo "Welcome to Batfetch!"

# Battery data directory of linux system.
dir="/sys/class/power_supply/"

# Array to store the name of files having battery information.
files=(
manufacturer 
model_name 
capacity 
status 
technology 
capacity_level 
charge_full 
charge_now 
current_now 
cycle_count 
serial_number 
voltage_min_design 
voltage_now
)

# Properties name of information.
property=(
Manufacturer 
Model\ Name 
Capacity 
Status 
Technology 
Capacity\ Level 
Charge\ Full 
Charge\ Now 
Current\ Now 
Cycle\ Count 
Serial\ Number 
Voltage\ Min\ Design 
Voltage\ Now
)

# Array to store
batteries=()

# Get all the batteries from system.
for directory in $(ls -d $dir*/); do
    if [ "${directory:24:1}" = "B" ]; then
        batteries+=($directory)
    fi
done

# Looping to display all the data.
for bat in ${batteries[@]}; do
    echo ""
    echo "Battery ---> ${bat:24:4}"
    for index in ${!files[@]}; do
        echo ${property[index]} : $(cat $bat${files[index]})
    done
done
