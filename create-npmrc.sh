if [ -z "$1" ]
then
TOKEN=$(echo -n "$NEXUS_USERNAME_REPOSITORY:$NEXUS_PASSWORD_REPOSITORY" | openssl base64)
cat > .npmrc <<EOF
registry=https://registry.npmjs.org/
@rappipay:registry=https://repo-nexus.security.rappi.com/repository/npm-group/
registry=https://repo-nexus.security.rappi.com/repository/npm-group/
_auth=$TOKEN
EOF
echo ".npmrc file created $1"
elif [ $1 == '--ci' ]
then
TOKEN=$(echo -n "${NEXUS_USERNAME}:${NEXUS_PASSWORD}" | base64)
cat > .npmrc <<EOF
registry=https://registry.npmjs.org/
@rappipay:registry=${NEXUS_URL}/repository/npm-group/
registry=${NEXUS_URL}/repository/npm-group/
_auth=$TOKEN
EOF
echo ".npmrc file created $1"
elif [ $1 == '--local' ]
then
echo "Please login to nexus registry to install Rappi dependencies 📚 (VPN credentials)"
echo "Stay connected to Rappi Prod VPN during intallation 📶"
echo User VPN:
read user
echo Password VPN:
read -s password
TOKEN=$(echo -n "$user:$password" | openssl base64)
cat > .npmrc <<EOF
registry=https://registry.npmjs.org/
@rappipay:registry=https://repo-nexus.security.rappi.com/repository/npm-group/
registry=https://repo-nexus.security.rappi.com/repository/npm-group/
_auth=$TOKEN
EOF
echo ".npmrc file created $1"
elif [ $1 == '--generator' ]
then
TOKEN=$(echo -n "$2:$3" | openssl base64)
cat > .npmrc <<EOF
registry=https://registry.npmjs.org/
@rappipay:registry=http://repo.ops.rappi.com/repository/npm-group/
registry=http://repo.ops.rappi.com/repository/npm-group/
_auth=$TOKEN
EOF
echo ".npmrc file created $1"
fi