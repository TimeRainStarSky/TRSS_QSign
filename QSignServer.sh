. "$HOME/Function.sh"
while start QSignServer;do
bash bin/unidbg-fetch-qsign --basePath="txlib/$(<QQVersion)"
restart
done