#!/bin/bash

# source: https://github.com/fmahnke/shell-semver

# Increment a version string using Semantic Versioning (SemVer) terminology.

# Parse command line options.
while getopts ":MmprRdD" Option
do
  # shellcheck disable=SC2220
  case $Option in
    M ) major=true;;
    m ) minor=true;;
    p ) patch=true;;
    R ) release=true;;
    r ) rc=true;;
    d ) dev=true;;
    D ) patchDev=true;;
  esac
done

if [ ! -z $patchDev ]
then
  patch=true
  dev=true
fi
shift $(($OPTIND - 1))

version=$1
# Build array from version string.

a=( ${version//./ } )

# If version string is missing or has the wrong number of members, show usage message.
if [ ${#a[@]} -eq 4 ]
then
  b=true
elif [ ${#a[@]} -ne 3 ]
then
  echo "usage: $(basename $0) [-Mmp] major.minor.patch"
  exit 1
fi

# Increment version numbers as requested.
if [ ! -z $major ]
then
  ((a[0]++))
  a[1]=0
  a[2]=0
fi

if [ ! -z $minor ]
then
  ((a[1]++))
  a[2]=0
fi

if [ ! -z $patch ]
then
  ((a[2]++))
fi
if [ ! -z $rc ]
then
  if [[ ${a[2]} != *"-rc"* ]]
  then
    a[2]=$(echo "${a[2]}" | sed -e "s/-dev//g")
    a[2]=${a[2]}-rc
    a[3]=0
  else
    ((a[3]++))
  fi
  echo "${a[0]}.${a[1]}.${a[2]}.${a[3]}"
  exit 0
fi
if [ ! -z $release ]
then
  # shellcheck disable=SC2001
  a[2]=$(echo "${a[2]}" | sed -e "s/-rc//g")
  a[2]=$(echo "${a[2]}" | sed -e "s/-dev//g")
  echo "${a[0]}.${a[1]}.${a[2]}"
  exit 0
fi
if [ ! -z $dev ]
then
  ((a[2]++))
  ((a[2]--))
  # shellcheck disable=SC2001
  a[2]=$(echo "${a[2]}" | sed -e "s/-dev//g")
  a[2]=${a[2]}-dev
  echo "${a[0]}.${a[1]}.${a[2]}"
  exit 0
fi
echo "${a[0]}.${a[1]}.${a[2]}"

