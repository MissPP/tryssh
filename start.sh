#!/bin/bash
passwdArr=(1 2 3 4 5 6 a b c d e f g h i j k l m n o p q r s t u v w x y z)
count3=0
operation_order=$1@$2

# Fixed length can be repeated in full combination
get_regular_length(){
    local passwd_length=6
    local x=0
        if [ ${#1} -eq $passwd_length ]; then
            echo "try password: "${1}
    		    count3=`expr $count3 + 1`
            res[$count3]=${1}
            if [ $count3 -eq 3 ];then
                count3=0
                ./t.sh ${operation_order} ${res[0]} ${res[1]} ${res[2]}
            fi
            return
        else
            for ((x=0;x<${#passwdArr[@]};x++)){
                get_regular_length ${1}${passwdArr[$x]}
            }
        fi
}

# Unfixed length
get_all_combine(){
    local x=0
    local passwd_length=10
    if [ ${#1} -eq ${passwd_length} ]; then
         return
    else
        for ((x=0;x<${#passwdArr[@]};x++)){
            echo "try password: "${1}${passwdArr[$x]}
            count3=`expr $count3 + 1`
            res[$count3]=${1}${passwdArr[$x]}
            if [ $count3 -eq 3 ];then
                count3=0
                ./t.sh ${operation_order} ${res[0]} ${res[1]} ${res[2]}
            fi
            get_all_combine ${1}${passwdArr[$x]}
        }
    fi
}

# All sorts
get_all_sort(){
    local x=0
    local tmpArr=($1)
    if [ ${#2} -eq ${#passwdArr[@]} ]; then
         echo "try password: "$2
         count3=`expr $count3 + 1`
         res[$count3]=$2
         if [ $count3 -eq 3 ];then
             count3=0
             ./t.sh ${operation_order} ${res[0]} ${res[1]} ${res[2]}
         fi
         return
    else
        for ((x=0;x<${#tmpArr[@]};x++)){
            #remove element
            local resultArr=($1)
            unset resultArr[$x]
            for((y=$x;y<${#resultArr[@]};y++)){
                flag=$[$y+1]
	              if [ $flag -eq ${#tmpArr[@]} ]; then
	              unset resultArr[$y]
	              else
                resultArr[$y]=${resultArr[$y+1]}
       	        fi
            }
            #end remove element,  maybe str is better
            get_all_sort "${resultArr[*]}" "${2}${tmpArr[$x]}"
        }
    fi
}

remove_element(){
    local arr=($1)
    unset arr[$2]
    for((x=$2;x<${#arr[@]};x++)){
        flag=$[$x+1]
	      if [ $flag -eq ${#arr[@]} ]; then
	          unset arr[$x]
	      else
            arr[$x]=${arr[$x+1]}
       	fi
    }
    resultArr=${arr[@]}
}

#get_regular_length
get_all_combine
#get_all_sort "${passwdArr[*]}"
echo "try fail"
