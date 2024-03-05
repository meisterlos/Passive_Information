#!/bin/bash

# Kullanıcıdan domain adını al
read -p "Lütfen kontrol etmek istediğiniz domain adını girin: " domain

echo "--------------------------------"
echo "TXT Kayıtları:"
echo "--------------------------------"
nslookup -type=txt $domain

echo "--------------------------------"
echo "HINFO Kayıtları:"
echo "--------------------------------"
nslookup -type=hinfo $domain

echo "--------------------------------"
echo "NSEC Kayıtları:"
echo "--------------------------------"
nslookup -type=nsec $domain

echo "--------------------------------"
echo "DMARC Kaydı:"
echo "--------------------------------"
dig _dmarc.$domain TXT +short

echo "--------------------------------"
echo "Subdomainler ve Alt Domainler:"
echo "--------------------------------"
echo "Alt domainlerin kontrol edilmesi..."
echo "--------------------------------"
subdomains=$(wget -qO - https://crt.sh/?q=%25.$domain\&output=json | jq '.[].name_value' | sed 's/\"//g' | grep -oE "([a-zA-Z0-9._-]+\.$domain)")
echo "$subdomains" | sort | uniq

