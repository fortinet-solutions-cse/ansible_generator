#!/bin/bash

# This script finds every module (including unit tests) in this directory 

original_dir=$(pwd)
ansible_dir=$1

if [ -z $1 ]; then
  me=`basename "$0"`
  echo "Please indicate the root of the Ansible repository where you want to put generated files."
  echo "   e.g.:"
  echo "         ./${me} ~/ansible"
  echo ""
  exit -1
fi

if [ ! -f ${ansible_dir}/MANIFEST.in ] || 
   [ ! -d ${ansible_dir}/lib/ansible/modules/network/fortios/ ] || 
   [ ! -d ${ansible_dir}/test/units/modules/network/fortios/ ]; then
  echo "Directory does not look like an official Ansible Repository."
  exit -1

fi

cd ${ansible_dir}
git checkout devel
git branch final_pr
git checkout final_pr

modules=$(find ${original_dir} -name "fortios_*.py")
echo "Generating branches and commits for each module:"
for module in ${modules}
do
  basename=${module##*/}
  basename=${basename%.*}

  echo $basename

  cp ${module} ${ansible_dir}/lib/ansible/modules/network/fortios/

  test_file=$(find ${original_dir} -name "test_${basename}.py")
  if [ ! -z ${test_file} ]; then 
    cp ${test_file} ${ansible_dir}/test/units/modules/network/fortios/
  fi

done