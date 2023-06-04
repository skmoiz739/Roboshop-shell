component=shipping
source common.sh
if [ -z "$mysql_root_password" ]; then
  echo "mysql_root_password is missing"
  exit1
fi
maven