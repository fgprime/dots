if [ $(pgrep cntlm2) ]; then
	echo "CNTLM proxy is running"
else
	echo "Initialize CNTLM proxy"
	cntlm -I -d muc -u $USER $PROXY:$PROXYPORT
fi
