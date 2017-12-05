Set Env: $MAVEN_PASSWD
Set after_success:
	- bash <(curl -s https://raw.githubusercontent.com/rekit-group/maven/releases/travis/decrypt.sh) && cd $TRAVIS_BUILD_DIR && mvn deploy
