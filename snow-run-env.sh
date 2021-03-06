my_dir="$( cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}")"; pwd -P )"
export PATH=$PATH:$my_dir/bin

source $my_dir/include/autocomplete.sh
if [[ -f .snow_run ]]; then
    source .snow_run
elif [[ -f ../.snow_run ]]; then
    source ../.snow_run
fi


echo "ServiceNow instance(e.g. dev1234.service-now.com) [$snow_instance]:"
read r_snow_instance
if [[ -n $r_snow_instance ]]
then
    snow_instance=$r_snow_instance
    unset r_snow_instance
fi
export snow_instance

if [[ -f $HOME/.netrc ]] && grep -q "$snow_instance" < $HOME/.netrc; then
    snow_user=$(grep -A2 "machine ${snow_instance}" < $HOME/.netrc | sed -nE 's;login (.+);\1;gp')
    snow_pwd=$(grep -A2 "machine $snow_instance" < $HOME/.netrc | sed -nE 's;password (.+);\1;gp')
fi


echo -n "User [$snow_user]: "
read r_snow_user
if [[ -n $r_snow_user ]]
then
    snow_user=$r_snow_user
    unset r_snow_user
fi
export snow_user



echo -n "Password: "
read -s r_snow_pwd
if [[ -n $r_snow_pwd ]]
then
    snow_pwd=$r_snow_pwd
    unset r_snow_pwd
fi
export snow_pwd


echo ""
