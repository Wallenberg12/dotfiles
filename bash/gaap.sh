#!/bin/bash
# git autocommit and push
# 
# use git caching or ssh key auth
# git config --global credential.helper cache
# git config --global credential.helper 'cache --timeout=3600'


if test "$#" -ne 1; then
    echo "Target dir is required!"
    exit 1
fi

TARGETDIR=$1

# check if TARGETDIR is a valid git repository
if git -C $TARGETDIR rev-parse; then 
	cd $TARGETDIR

	function scan_and_commit () {
		git diff --name-only > /tmp/gaap_files
		n=$(wc -l /tmp/gaap_files | awk '{print $1}')

		if test $n -ne 0; then 
			while read file; do
				git add "$file"
			done < /tmp/gaap_files
			git commit -m "autocommit $(date)"
			git push
		fi
		rm /tmp/gaap_files
	}
	export -f scan_and_commit

	watch -n 10 scan_and_commit
fi
